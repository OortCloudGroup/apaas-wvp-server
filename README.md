<p align="center">
	<img width="200" alt="logo" src="https://gdhxkj.oss-cn-guangzhou.aliyuncs.com/2025/05/29/c271a2c48ffc4b1eac47985402641109.png">
</p>
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">RuoYi-Wvp</h1>
<h4 align="center">基于ruoyi-vue的流媒体平台，开箱即用、完全开源、使用MIT许可协议</h4>
<p align="center">
  <a href="https://gitee.com/xiaochemgzi/RuoYi-Wvp/stargazers">
    <img src="https://gitee.com/xiaochemgzi/RuoYi-Wvp/badge/star.svg?theme=dark" alt="star" />
  </a>
  <a href="https://gitee.com/xiaochemgzi/RuoYi-Wvp">
    <img src="https://img.shields.io/badge/RuoYi_Wvp-v3.8.9-blue.svg" alt="version" />
  </a>
  <a href="https://gitee.com/xiaochemgzi/RuoYi-Wvp/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/mashape/apistatus.svg" alt="license" />
  </a>
</p>

---

## 平台介绍

RuoYi-Wvp 是基于 [RuoYi-Vue](https://ruoyi.vip/) 与 WVP 框架开发的全开源 GB/T 28181 流媒体平台，依托 [ZLMediaKit](https://github.com/ZLMediaKit/ZLMediaKit) 流媒体服务，实现高效、稳定的视频接入与分发。

### 核心能力

- **多协议接入**：支持 GB28181-2016/2022、ONVIF、RTSP、海康 ISUP、大华 SDK 等多种协议，轻松接入各类摄像头/NVR
- **VLStream 原生设备接入**：通过 MQTT 接收 VLStream 2.2 设备状态与视频源全量快照，提供业务回执、在线状态管理和独立数据存储
- **流媒体分发**：基于 ZLMediaKit 实现直播、回放、云台控制等功能
- **统一 WebRTC 预览**：VLStream 设备上报 RTSP/RTMP 源地址后，由 ZLMediaKit 按需拉流并转换为浏览器可播放的 WebRTC 地址
- **大屏可视化**：内置数据大屏看板，设备状态、告警等信息一目了然
- **代码生成**：整合 RuoYi 代码生成器，一键生成前后端 CRUD 代码
- **权限管理**：动态权限菜单，多终端认证，Spring Security + JWT 安全体系

---

## 项目结构

```
RuoYi-Wvp
├── ruoyi-admin          # 入口模块 - Spring Boot 启动，整合所有子模块
├── ruoyi-framework      # 框架模块 - 数据源、AOP、系统监控等基础设施
├── ruoyi-system         # 业务模块 - 设备管理、大屏接口、系统服务
├── ruoyi-wvp            # WVP 模块 - GB/T 28181 国标协议 SIP 信令
├── ruoyi-isup           # ISUP 模块 - 海康 ISUP 协议（CMS/SS/SMS/Alarm/Stream）
├── ruoyi-onvif          # ONVIF 模块 - ONVIF 协议设备接入
├── ruoyi-rtsp           # RTSP 模块 - RTSP 协议设备接入
├── ruoyi-dahua          # 大华模块 - 大华 SDK 集成（云台/报警/门禁/热成像等 15+ 功能）
├── ruoyi-vlstream       # VLStream 模块 - MQTT 原生设备、状态快照、业务回执和 ZLM 预览
├── ruoyi-common         # 公共模块 - 工具类、ZLM 服务、编解码等
├── ruoyi-quartz         # 定时任务 - 设备状态巡检等周期性任务
├── ruoyi-generator      # 代码生成 - Velocity 模板，一键生成前后端代码
├── ruoyi-ui-vue3        # 管理前端 - Vue 3 + Element Plus + Vite
└── ruoyi-ui-large       # 大屏前端 - Vue 3 + TypeScript + TailwindCSS + ECharts
```

---

## 近期新增功能（`73f5f6ab` ～ `f5330c54`）

- 完善国标、ISUP、RTSP、ONVIF 和大华 SDK 等协议设备的接入与管理。
- 优化工作台、导航菜单、列表、搜索、弹窗等管理端界面，并补充地图、告警、收藏、标记和云端录像等能力。
- 新增跨协议设备的区域、分组、标签统一分类管理。
- 新增 VLStream MQTT 原生设备模块，支持状态及视频源上报、业务回执、离线管理、独立存储和 ZLM 转 WebRTC 预览。
- 支持本地账号与 SSO 鉴权切换、`accessToken` 直达及外部平台联邦鉴权。
- 完善 ZLMediaKit 接入、数据库脚本、环境配置和构建信息展示。

VLStream 模块的部署与配置说明见 [`ruoyi-vlstream/README.md`](ruoyi-vlstream/README.md)。

---

## 技术栈

| 层级     | 技术                                                         |
| -------- | ------------------------------------------------------------ |
| **后端** | Spring Boot 2.7.18 · Spring Security 5.7 · MyBatis · Redis · Druid · JWT |
| **前端** | Vue 3.4 · Element Plus 2.7 · Vite 5.3 · Pinia · ECharts 5   |
| **流媒体** | ZLMediaKit · GB/T 28181 SIP · ONVIF · RTSP · 海康 ISUP · 大华 SDK |
| **数据库** | MySQL 8 · Redis 6                                            |
| **工具库** | Hutool 5.8 · Fastjson2 · Apache POI · Velocity · Swagger 3  |
| **大屏** | Vue 3 · TypeScript · TailwindCSS · ECharts · 自适应缩放     |

---

## 版本功能对比

| 功能 | 开源版 | 商业版 |
| --- | :---: | :---: |
| GB28181 协议 | ✓ | ✓ |
| ONVIF 协议 | ✓ | ✓ |
| RTSP 协议 | ✓ | ✓ |
| 海康 ISUP 协议 | ✓ | ✓ |
| 海康 SDK | - | ✓ |
| 大华 SDK | ✓ | ✓ |
| 宇视 SDK | - | ✓ |
| 天地伟业 SDK | - | ✓ |
| 萤石云 | - | ✓ |
| 乐橙云 | - | ✓ |
| GAT1400 协议 | - | ✓ |
| 小程序 + App | - | ✓ |

---

## 在线体验

- 访问地址：`https://vls-lite.oortcloudsmart.com:2443/ `
- 默认用户：`admin`
- 默认密码：`123456`

> 一键部署完成后可使用以上默认账号登录；正式环境请及时修改默认密码。

---

## 系统截图

|                                     |                                     |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/1.png" alt="" /> | <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/2.png" alt="" /> |
| <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/11.png" alt="" /> | <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/12.png" alt="" /> |
| <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/13.png" alt="" /> | <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/14.png" alt="" /> |
| <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/15.png" alt="" /> | <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/16.png" alt="" /> |
| <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/17.png" alt="" /> | <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/18.png" alt="" /> |
| <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/19.png" alt="" /> | <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/20.png" alt="" /> |
| <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/21.png" alt="" /> | <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/22.png" alt="" /> |
| <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/23.png" alt="" /> | <img src="https://ruoyi-wvp-1308576884.cos.ap-guangzhou.myqcloud.com/ruoyi-wvp/upload/24.png" alt="" /> |

---

## 关联开源项目

### RuoYi-Qs-NVR（基于 RuoYi-Cloud 的 NVR 系统）

| 平台   | 后端                                                                                          | 前端                                                                                                |
| ------ | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Gitee  | [ruoyi-qs-nvr](https://gitee.com/tangwenzhaoaini/ruoyi-qs-nvr)                                | [ruoyi-qs-nvr-ui](https://gitee.com/tangwenzhaoaini/ruoyi-qs-nvr-ui)                                |
| GitHub | [ruoyi-qs-nvr](https://github.com/2929004360/ruoyi-qs-nvr)                                    | [ruoyi-qs-nvr-ui](https://github.com/2929004360/ruoyi-qs-nvr-ui)                                    |

### RuoYi-Qs-Yolo（基于 YOLO 的 AI 识别系统）

| 平台   | 地址                                                                              |
| ------ | --------------------------------------------------------------------------------- |
| Gitee  | [ruoyi-qs-yolo](https://gitee.com/tangwenzhaoaini/ruoyi-qs-yolo)                  |
| GitHub | [ruoyi-qs-yolo](https://github.com/2929004360/ruoyi-qs-yolo)                      |

---

## 交流与支持

- **QQ 群**：[![QQ群](https://img.shields.io/badge/695642294-blue.svg)]()
- **微信**：ruoyi-wvp888（备注：ruoyi-wvp）

---

## 授权协议

本项目自有代码使用 MIT 协议，在保留版权信息的前提下可自由应用于商业及非商业项目。项目中使用了部分第三方开源代码，商用环境下请自行评估并遵循对应协议。因使用本项目产生的商业纠纷或侵权行为与本项目及开发者无关，请自行承担法律风险。

---

## 特别致谢

- [ZLMediaKit](https://github.com/ZLMediaKit/ZLMediaKit) — 高性能流媒体服务框架，作者 [夏楚](https://github.com/xia-chu)
- [WVP-GB28181-Pro](https://github.com/648540858/wvp-GB28181-pro) — 国标 GB/T 28181 服务器框架，作者 [648540858](https://github.com/648540858)
- [RuoYi-Vue](https://ruoyi.vip/) — 优秀的快速开发框架，作者 [若依](https://ruoyi.vip/)
- [GoView](https://gitee.com/dromara/go-view) — 大屏可视化低代码平台
