# APaaS WVP Server v1.0.2

Patch release for the public container deployment.

- One-command deployment package for MySQL, Redis, EMQX 5.4, ZLMediaKit, and WVP.
- The WVP VLStream MQTT extension now connects to the bundled MQTT Broker by default.
- Public database bootstrap script with operational data and secrets removed.
- Flyway baseline and upgrade policy for future database changes.
- GB28181, ONVIF, RTSP, and ZLMediaKit base deployment support.

The ISUP and Dahua native-SDK integrations are not enabled or supported by the
default container deployment. See DEPLOYMENT.md before enabling them.
