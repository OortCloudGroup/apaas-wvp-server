# VLStream WVP image

This repository publishes the independent WVP backend image used by the
VLStream Cloud Compose stack.

- Image: `ghcr.io/oortcloudgroup/vlstream-wvp-backend:<version>`
- HTTP port: `9080`
- GB28181 SIP port: `8116/tcp` and `8116/udp`
- Database: independent `ry-wvp` schema in the shared MySQL instance
- Redis: shared Redis instance, database index `10`
- Schema upgrades: Flyway migrations under
  `ruoyi-admin/src/main/resources/db/migration`

Linux ISUP and Dahua native SDK listeners are disabled by default. They must
only be enabled after the matching Linux native runtime has been installed and
verified.
