# WVP VLStream 原生设备模块

`ruoyi-vlstream` 负责在 WVP 中独立接入 VLStream 2.2 原生 MQTT 设备。模块接收设备状态与视频源快照、保存到 WVP 自己的数据表、返回协议业务回执，并通过 ZLMediaKit 将设备上报的 RTSP/RTMP 地址转换为浏览器可播放的 WebRTC 地址。

本模块不复用原有自定义协议设备表，也不依赖 VLS 的设备数据或角色初始化数据。

## 已实现功能

- MQTT 自动连接、断线重连和重新订阅。
- QoS 1、持久会话（`cleanSession=false`）、默认 60 秒 MQTT Keepalive。
- 接收 `device/state` 状态快照，兼容旧业务类型 `deviceBiz/state`。
- 校验协议版本、消息方向、Topic 与 `deviceId` 的一致性。
- 基于 `deviceId + messageId` 的消息幂等处理。
- 忽略比数据库当前状态更旧的过期快照，同时返回成功回执。
- 保存设备在线状态、名称、序列号、固件版本、IP、遥测数据和服务状态。
- 保存 `streams` 全量快照，未出现在新快照中的历史视频源会被标记为不可用。
- 支持硬件上报 `telemetry.diskTotalMB`，按原始数值存储，不做单位转换或数值扩展。
- 按最后心跳时间自动标记离线，并定时清理历史幂等消息。
- 提供 VLStream 设备列表、在线筛选、区域/分组/标签分类和权限控制。
- 检查默认 ZLMediaKit 节点的运行态在线状态。
- 按需创建 ZLMediaKit 拉流代理，并返回 RTC/RTCS 播放地址供统一 WebRTC 播放器使用。

## 业务流程

```text
硬件设备
  └─ MQTT QoS 1 上报 device/state（包含 streams 全量快照）
       └─ WVP ruoyi-vlstream
            ├─ 校验协议、Topic、deviceId 和 messageId
            ├─ 幂等保存设备、遥测、服务状态和视频源
            └─ 在原 Topic 发布 platform2dev 业务回执

用户点击预览
  └─ WVP读取设备可用视频源
       └─ 调用ZLMediaKit addStreamProxy拉取RTSP/RTMP
            └─ ZLMediaKit生成WebRTC播放地址
                 └─ 前端rtcPlayer播放
```

## MQTT 协议

### Topic

设备与平台共用以下 Topic：

```text
vlstream/v2.2/dev/{deviceId}/bus
```

WVP 的订阅过滤器为：

```text
vlstream/v2.2/dev/+/bus
```

### 当前支持的消息

| 字段 | 值 |
| --- | --- |
| `protocolVersion` | `2.2` |
| `msgDir` | `dev2platform` |
| `mainBizType` | `device`，兼容 `deviceBiz` |
| `subBizType` | `state` |

`payload.streams` 表示设备当前全部可用视频源的全量快照。设备没有视频能力时应传空数组；不能省略某一路仍然有效的视频源，否则平台会将对应历史流标记为不可用。

### 业务回执

WVP 在收到并处理设备消息后，会在原 Topic 发布 `msgDir=platform2dev` 的 QoS 1 回执。回执中的：

- `payload.sourceMsgId`：对应设备上报的 `messageId`。
- `payload.code`：HTTP 风格业务状态码，例如 `200`、`400`、`500`。
- `payload.errCode`：成功为 `0`，失败为协议错误码。
- `payload.msg` / `errDetail`：处理结果说明。

已覆盖的处理结果包括状态已接收、重复消息已确认、过期状态快照已忽略、Topic 与设备 ID 不一致、不支持的业务类型和平台处理失败。

## 数据存储

安装脚本会创建以下 WVP 独立表：

| 表名 | 用途 |
| --- | --- |
| `wvp_vlstream_device` | 设备基本信息、在线状态、最后心跳、遥测和服务状态 |
| `wvp_vlstream_device_stream` | 设备上报的视频源、可用状态和 ZLM 拉流代理信息 |
| `wvp_vlstream_message` | MQTT 消息幂等记录 |

视频源 URL 仅用于后端调用 ZLMediaKit 创建拉流代理，不通过 VLStream REST 列表接口返回。URL 可能包含摄像头账号密码，不应记录完整 MQTT 报文或完整视频源 URL。

## 安装

1. 完成 WVP 基础数据库初始化。
2. 执行 [`../sql/2026-08-13-vlstream.sql`](../sql/2026-08-13-vlstream.sql)。脚本可重复执行，并会创建数据表、菜单和权限点。
3. 配置 MQTT Broker 与 ZLMediaKit。
4. 启动或重启 `ruoyi-admin`。
5. 管理员默认可见菜单；其他角色需要在角色管理中授予“VLStream / 设备管理”及对应按钮权限。

## MQTT 环境变量

配置位于 `ruoyi-admin/src/main/resources/application.yml` 的 `vlstream.mqtt` 和 `vlstream.device`。

| 环境变量 | 默认值 | 用途 |
| --- | --- | --- |
| `VLSTREAM_MQTT_HOST` | `127.0.0.1` | MQTT Broker 主机名或 IP |
| `VLSTREAM_MQTT_PORT` | `1883` | MQTT Broker TCP 端口 |
| `VLSTREAM_MQTT_USERNAME` | 空 | Broker 用户名 |
| `VLSTREAM_MQTT_PASSWORD` | 空 | Broker 密码 |
| `VLSTREAM_WVP_MQTT_CLIENT_ID` | `wvp-vlstream-backend` | WVP 的 MQTT Client ID，必须与 VLS Client ID 不同 |
| `VLSTREAM_MQTT_QOS` | `1` | 配置项保留；当前协议收发固定使用 QoS 1 |
| `VLSTREAM_MQTT_KEEP_ALIVE_SECONDS` | `60` | MQTT 连接 Keepalive 秒数 |
| `VLSTREAM_MQTT_CONNECTION_TIMEOUT_SECONDS` | `10` | MQTT 连接超时秒数 |
| `VLSTREAM_DEVICE_OFFLINE_TIMEOUT_SECONDS` | `180` | 超过该时间未收到心跳后标记设备离线 |
| `VLSTREAM_MQTT_MESSAGE_RETENTION_HOURS` | `24` | MQTT 幂等消息记录保留时长 |

## ZLMediaKit 环境变量

配置位于 `application.yml` 的 `media` 节点。

| 环境变量 | 本地默认值 | 用途与格式 |
| --- | --- | --- |
| `ZLMEDIAKIT_HOST` | `127.0.0.1` | WVP访问ZLM HTTP API的主机；只填主机或IP，不带协议、端口或路径 |
| `ZLMEDIAKIT_HTTP_PORT` | `8090` | WVP访问ZLM HTTP API的端口 |
| `ZLMEDIAKIT_HOOK_HOST` | `host.docker.internal` | ZLM回调WVP时使用的WVP主机；必须从ZLM运行环境可达 |
| `ZLMEDIAKIT_SECRET` | 见本地配置 | ZLM API鉴权密钥，必须与ZLM的`api.secret`一致 |

`media.id` 必须与 ZLMediaKit 的 `general.mediaServerId` 一致。`ZLMEDIAKIT_HOST` 与 `ZLMEDIAKIT_HTTP_PORT` 必须分开配置，不能将 `127.0.0.1:8090` 整体写入 Host。

ZLM 必须启用 Hook，并将 `on_server_started`、`on_server_keepalive` 及流事件 Hook 指向 WVP 的 `/index/hook/*`。ZLM 运行在 Docker 中时，配置必须在容器重启后仍能生效；仅通过运行时 API 修改但不持久化，会导致容器重启后节点再次显示不可用。

## VLS 与 WVP 同时运行

普通 MQTT 订阅会向每个不同 Client ID 的订阅者各分发一份消息。当前职责按业务类型拆分：

- WVP 是唯一的 VLStream 设备中心，消费 `device/state` 和 `device/firmwareDeploy`，负责设备、心跳、视频流、固件任务及对应回执。
- VLS 消费 `aiBiz/struct`、`aiBiz/faceEvent`、模型下发回执，负责事件图片、AI 事件和模型业务。
- VLS 保持硬件接口不变，通过 `GET /internal/vlstream/device/{deviceId}` 向 WVP 校验设备；该最小只读接口仅供后端服务网络访问，不使用用户鉴权或额外共享密钥，硬件无需调用。
- WVP 已登记但离线的设备仍允许 VLS 接收补报事件；未登记设备会被拒绝。

两套系统的 MQTT Client ID 不能相同。若相同，Broker 会在新客户端连接时断开旧客户端。WVP 默认使用 `wvp-vlstream-backend`。
VLS 的 `VLSTREAM_NATIVE_DEVICE_LEGACY_ENABLED` 正常部署必须保持 `false`，避免两套服务同时消费心跳、固件回执并返回重复业务回执。

## 页面与权限

菜单路径为“VLStream / 设备管理”。当前权限点：

| 权限 | 用途 |
| --- | --- |
| `vlstream:device:list` | 查询设备及可用视频源 |
| `vlstream:device:play` | 创建ZLM拉流代理并预览 |

页面提供设备名称/ID/序列号搜索、在线状态筛选、区域/分组/标签分类、ZLM 可用状态和 WebRTC 视频预览。

## 联调检查

出现“ZLM 不可用”时依次检查：

1. `ZLMEDIAKIT_HOST` 是否只包含主机，端口是否配置在 `ZLMEDIAKIT_HTTP_PORT`。
2. WVP 能否调用 `http://{host}:{port}/index/api/getServerConfig`。
3. `ZLMEDIAKIT_SECRET` 是否与 ZLM 的 `api.secret` 一致。
4. ZLM 的 `general.mediaServerId` 是否与 `media.id` 一致。
5. ZLM 是否启用 `hook.enable=1`，并持续向 WVP 发送 `on_server_keepalive`。
6. Docker 中的 ZLM 是否能通过 `ZLMEDIAKIT_HOOK_HOST` 访问 WVP。
7. ZLM 重启后 Hook 配置是否仍然存在。

出现设备无回执时检查 MQTT Client ID 是否冲突、Topic 中的设备 ID 是否与消息体一致，以及消息是否为 `protocolVersion=2.2`、`msgDir=dev2platform`、`device/state`。
