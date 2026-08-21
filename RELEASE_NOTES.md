# APaaS WVP Server v1.0.1

First public container release of APaaS WVP Server.

- One-command deployment package for MySQL, Redis, ZLMediaKit, and WVP.
- Public database bootstrap script with operational data and secrets removed.
- Flyway baseline and upgrade policy for future database changes.
- GB28181, ONVIF, RTSP, and ZLMediaKit base deployment support.

The ISUP and Dahua native-SDK integrations are not enabled or supported by the
default container deployment. See DEPLOYMENT.md before enabling them.
