# APaaS WVP Server Release Notes

- Restored the public one-command deployment package for MySQL, Redis, EMQX,
  ZLMediaKit, and WVP.
- Added a sanitized WVP bootstrap database that contains the complete current
  schema and only public default users, roles, menus, dictionaries, and jobs.
- Added an idempotent Flyway migration for legacy databases missing
  `sys_user.platform_user_id`.
- The release workflow packages the bootstrap SQL and verifies the archive
  checksum before publishing.

The default administrator is `admin / 123456`; change it after the first login.
The ISUP and Dahua native SDK integrations are disabled by default. See
DEPLOYMENT.md before enabling them.
