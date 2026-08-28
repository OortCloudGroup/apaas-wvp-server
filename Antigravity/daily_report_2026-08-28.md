# 工作日报 (Daily Work Report) - 2026-08-28

## 1. 标题 (Title)
VLStream 协议直连播放支持 (CameraRTC) 与 自动化构建部署体系建设

---

## 2. 详情 (Details)

### 模块一：VLStream 协议直连播放能力扩展 (CameraRTC)
- **核心逻辑增加**：在 `ruoyi-vlstream` 模块新增 `VlStreamPlaybackUtils` 工具类，用于识别 `cameraRTC` 协议及 WebRTC 播放源地址。
- **接口与状态处理**：
  - 扩展 `VlStreamDeviceController`，当流协议为 `cameraRTC` 时跳过 ZLM 代理，直接返回 `playMode: cameraRTC` 播放源。
  - 扩展 `VlStreamDeviceStateService` 状态同步服务，放行并保存 `cameraRTC` 类型的视频流。
- **单元测试保障**：为工具类、Controller 及 Service 补充完整单元测试，23 项测试用例全部通过。

### 模块二：数据库迁移与系统配置优化
- **Flyway 数据库基线**：开启 Flyway 迁移 baseline，补充 `V1_2_2__ensure_platform_user_id.sql` 脚本，保障旧表结构自动补充 `platform_user_id` 字段。
- **多环境配置调整**：
  - 更新 `application.yml` 中 VLStream MQTT 默认参数及 MinIO 固件仓库集成配置。
  - 优化 `application-druid.yml` 数据库密码占位符。

### 模块三：容器化部署与 CI/CD 自动化
- **自动化构建**：新增 `.github/workflows/release.yml`，支持标签/手动触发打包构建 Docker 镜像并发布 Release。
- **容器部署资产**：编写项目主 `Dockerfile`、`compose.yaml` 及外置 ZLM `compose.external.yaml`。
- **部署与发布文档**：编写 `DEPLOYMENT.md` 与 `RELEASE_NOTES.md`，规范化运维部署流程。

---

## 3. Git 提交记录 (Git Commit Log)

| 提交 Hash | 类型 (Type/Scope) | 提交信息 (Commit Summary) | 影响模块 |
| :--- | :--- | :--- | :--- |
| `7544efc` | `feat(vlstream)` | `feat(vlstream): add support for direct cameraRTC stream playback and filtering` | `ruoyi-vlstream` |
| `2c748a7` | `feat(config)` | `feat(config): configure Flyway migration baseline, MQTT options, and add platform user migration` | `ruoyi-admin` |
| `b4c6813` | `build(deploy)` | `build(deploy): add containerized deployment manifests, release workflow, and documentation` | Root / `deploy` / `.github` |

---

## 4. 未提交文件说明 (Uncommitted Files)
- `ruoyi-isup/win-lib/PictrueStorageServer.db`：本地测试生成的二进制 SQLite 数据库文件，不纳入版本控制。
- `.codex-worktrees/`：本地工作区 Worktree 缓存目录，属于开发环境文件。
