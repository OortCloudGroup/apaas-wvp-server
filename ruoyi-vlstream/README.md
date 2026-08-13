# WVP VLStream MQTT device module

This module receives the VLStream 2.2 native-device status snapshot and stores it in WVP-owned tables. It does not reuse the legacy custom-protocol device table.

## Installation

1. Execute `sql/2026-08-13-vlstream.sql` after the normal WVP database initialization.
2. Configure the MQTT broker through the `VLSTREAM_MQTT_*` environment variables.
3. Restart `ruoyi-admin`, then grant the `VLStream / 设备管理` menu to non-administrator roles when required.

The device publishes QoS 1 messages to `vlstream/v2.2/dev/{deviceId}/bus`. The module currently handles `mainBizType=device` (and legacy `deviceBiz`) with `subBizType=state`. The `streams` array is a full snapshot; missing historical streams are marked unavailable. Telemetry is stored as JSON and accepts the hardware field `diskTotalMB` without numeric expansion or unit conversion.

RTSP/RTMP source URLs are stored only for backend ZLMediaKit pull-proxy creation and are excluded from REST responses. Do not log MQTT payloads because URLs may contain credentials.

## Running VLS and WVP together

Normal MQTT subscriptions fan out one copy to every distinct client, so VLS and WVP both receive the report, persist it in their own tables, and publish their own protocol business reply. WVP follows the VLS connection behavior: QoS 1, persistent session (`cleanSession=false`), 60-second keepalive and automatic reconnect.

The only intentional difference is the MQTT client ID. WVP defaults to `wvp-vlstream-backend` through `VLSTREAM_WVP_MQTT_CLIENT_ID`; it must not equal the VLS client ID, otherwise the broker will disconnect the existing client when the other application connects.
