package com.ruoyi.vlstream.service;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.vlstream.config.VlStreamFirmwareProperties;
import com.ruoyi.vlstream.domain.VlStreamFirmwareTask;
import com.ruoyi.vlstream.mapper.VlStreamFirmwareTaskMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.time.Instant;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Service
public class VlStreamFirmwareTaskService {
    private static final Set<String> ACTIVE = new HashSet<>(Arrays.asList(
            "CREATED", "PUBLISHED", "ACCEPTED", "DOWNLOADING", "VERIFYING", "INSTALLING", "REBOOTING"));
    private static final Set<String> TERMINAL = new HashSet<>(Arrays.asList("SUCCESS", "FAILED", "CANCELLED", "TIMED_OUT"));
    private static final Map<String, Integer> ORDER = new HashMap<>();
    static {
        ORDER.put("CREATED", 0); ORDER.put("PUBLISHED", 1); ORDER.put("ACCEPTED", 2);
        ORDER.put("DOWNLOADING", 3); ORDER.put("VERIFYING", 4); ORDER.put("INSTALLING", 5);
        ORDER.put("REBOOTING", 6); ORDER.put("SUCCESS", 7); ORDER.put("FAILED", 7);
    }

    private final VlStreamFirmwareTaskMapper mapper;
    private final VlStreamFirmwareProperties properties;

    public VlStreamFirmwareTaskService(VlStreamFirmwareTaskMapper mapper, VlStreamFirmwareProperties properties) {
        this.mapper = mapper;
        this.properties = properties;
    }

    public boolean isActive(String status) { return ACTIVE.contains(StringUtils.upperCase(status)); }
    public boolean hasActive(Long deviceRowId) { return mapper.countActive(deviceRowId, "rootfs") > 0; }
    public VlStreamFirmwareTask latest(Long deviceRowId) { return mapper.selectLatestByDevice(deviceRowId); }
    public VlStreamFirmwareTask byRequestId(String requestId) { return mapper.selectByRequestId(requestId); }
    public VlStreamFirmwareTask byMessageId(String messageId) { return mapper.selectByMessageId(messageId); }
    public void create(VlStreamFirmwareTask task) {
        if (mapper.insert(task) != 1) throw new ServiceException("创建 OTA 任务失败");
    }
    public void markPublished(Long id) {
        Date now = new Date();
        if (mapper.markPublished(id, now) != 1) throw new ServiceException("OTA 任务发布状态更新失败");
    }
    public void markPublishFailed(Long id, String reason) { mapper.markPublishFailed(id, abbreviate(reason), new Date()); }

    public VlStreamFirmwareTask cancel(Long deviceRowId, String requestId) {
        VlStreamFirmwareTask task = mapper.selectByRequestId(StringUtils.trimToEmpty(requestId));
        if (task == null || !deviceRowId.equals(task.getDeviceRowId())) throw new ServiceException("OTA 任务不存在");
        if (!isActive(task.getDeployStatus())) throw new ServiceException("OTA 任务已结束，无需终止");
        String reason = "管理员终止任务；仅解除平台任务锁，未向设备发送取消指令";
        if (mapper.cancelActive(deviceRowId, task.getRequestId(), new Date(), reason) != 1) {
            throw new ServiceException("OTA 任务状态已变化，请刷新后重试");
        }
        return mapper.selectByRequestId(task.getRequestId());
    }

    public boolean applyReply(VlStreamFirmwareTask task, String status, String failureReason, String rawPayload) {
        String current = StringUtils.upperCase(task.getDeployStatus());
        String next = StringUtils.upperCase(status);
        if (!ACTIVE.contains(current) || (!ACTIVE.contains(next) && !TERMINAL.contains(next))) return false;
        if (!TERMINAL.contains(next) && ORDER.get(next) < ORDER.get(current)) return false;
        Date now = new Date();
        Date completedAt = TERMINAL.contains(next) ? now : null;
        return mapper.updateReply(task.getId(), next, now, completedAt, abbreviate(failureReason), rawPayload) == 1;
    }

    public int expireStaleTasks() {
        Date now = new Date();
        int expired = mapper.expireDownloadTasks(Instant.now().getEpochSecond(), now);
        int timeoutMinutes = Math.max(5, properties.getOtaTaskInactivityTimeoutMinutes());
        expired += mapper.expireExecutionTasks(new Date(now.getTime() - timeoutMinutes * 60_000L), now);
        return expired;
    }

    @Scheduled(initialDelay = 30000L, fixedDelayString = "${vlstream.firmware.ota-task-timeout-scan-millis:30000}")
    public void scheduledExpiry() { expireStaleTasks(); }

    private String abbreviate(String value) { return StringUtils.abbreviate(StringUtils.trimToNull(value), 2000); }
}
