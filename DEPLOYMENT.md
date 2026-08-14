# APaaS WVP Server deployment

## Requirements

Use Docker Engine with Docker Compose v2. A Linux host must allow the selected
HTTP, SIP UDP, and RTP UDP port range through its firewall and cloud security
group. The default package uses Linux/amd64 for the WVP image.

## Fresh installation

```powershell
Copy-Item .env.example .env
docker compose up -d
```

Open `http://localhost:8080`. The initial account is `admin`; its password is
`123456`, verified against the administrator BCrypt hash in the source SQL.
Change it immediately after login.

The default Compose file starts four independent services: MySQL, Redis,
ZLMediaKit, and the WVP Java backend. No service is combined with another
service image. The WVP image
also contains the compiled browser UI, so no separate frontend service is
needed. The backend image is
`ghcr.io/oortcloudgroup/apaas-wvp-server:1.0.0`.

Use an existing MySQL, Redis, and ZLMediaKit installation with:

```powershell
docker compose -f compose.external.yaml up -d
```

Set `DB_HOST`, `REDIS_HOST`, `ZLM_HOST`, `ZLM_HOOK_IP`, and
`ZLM_PUBLIC_HOST` in `.env` first. The ZLMediaKit hook address must be reachable
from ZLMediaKit; when both services use the same Compose network it is normally
`wvp-backend`.

## Configuration and ports

Edit `.env` before the first start to change passwords and host ports. Do not
reuse the example passwords. `DB_PASSWORD` is the backend database password;
it is intentionally separate from `DB_USERNAME`.

`DB_MIGRATION_USERNAME` and `DB_MIGRATION_PASSWORD` are used only by Flyway
during startup. They need schema-migration privileges. The bundled deployment
uses the MySQL root account for this limited task, while the backend continues
to use the less-privileged `wvp` account defined by `DB_USERNAME` and
`DB_PASSWORD`. For `compose.external.yaml`, provide a dedicated migration
account instead of reusing a production root account where possible.

| Purpose | Default |
| --- | --- |
| WVP UI and HTTP API | `8080/tcp` |
| ZLMediaKit HTTP / WebSocket | `8081/tcp` |
| ZLMediaKit HTTPS | `8443/tcp` |
| GB28181 SIP | `8116/udp` |
| RTP media range | `40000-40300/udp` |

`VLSTREAM_VERIFY_TOKEN` is optional. For a VLStream service running on the
Docker host use `http://host.docker.internal:8080/blade-system/user/info`; when
the two backends share a Compose network, use the VLStream service name, for
example `http://backend:8080/blade-system/user/info`.

The packaged ZLMediaKit image is configured with the same `ZLM_SECRET` passed
to WVP. `ZLM_PUBLIC_HOST` must be the DNS name or public IP devices and browsers
can reach, not necessarily the Docker service name.

## Operations, data, and upgrades

View status and logs:

```powershell
docker compose ps
docker compose logs -f wvp-backend
docker compose logs -f zlmediakit
```

Stop or restart with `docker compose stop` and `docker compose up -d`.
Named volumes retain MySQL, Redis, ZLMediaKit, uploads, and logs. Back up MySQL
with `docker compose exec mysql mysqldump -uroot -p ry-wvp > ry-wvp-backup.sql`
(supply the root password interactively or securely through your shell).

The MySQL `/docker-entrypoint-initdb.d` scripts run only when the MySQL data
volume is empty. A fresh install creates and selects `ry-wvp` automatically.
An existing volume does not run initialization again. Deleting the volume
destroys every database in it and is not an upgrade procedure.

`10-ry-wvp.sql` is only for fresh installation. Flyway manages upgrades of an
existing database from `ruoyi-admin/src/main/resources/db/migration/`. Each new
release adds a new immutable `V<version>__description.sql`; previously released
migrations must never be edited, deleted, or renamed.

## Protocols and native SDKs

GB28181, ONVIF, RTSP, and ZLMediaKit are the supported v1.0.0 base deployment.
ISUP and Dahua integrations are optional/experimental: their native SDK shared
libraries, dependency completeness, and redistribution terms have not been
verified for this public Linux image. They are not enabled by the default
deployment and must be separately reviewed before use.

## Troubleshooting

- If MySQL does not initialize, check `docker compose logs mysql` and confirm
  that this is a new MySQL volume.
- If WVP cannot reach ZLMediaKit, compare `ZLM_SECRET`, `ZLM_HOST`, and
  `ZLM_HOOK_IP` on both sides.
- If devices cannot register or media has no video, open SIP and every port in
  the RTP UDP range on the host firewall/NAT/security group and set
  `ZLM_PUBLIC_HOST` to an externally reachable address.
- If the UI opens but authentication through VLStream fails, leave
  `VLSTREAM_VERIFY_TOKEN` empty for local WVP login or set it to the reachable
  VLStream verification endpoint.
