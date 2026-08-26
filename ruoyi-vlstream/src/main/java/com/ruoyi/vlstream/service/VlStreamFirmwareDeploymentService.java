package com.ruoyi.vlstream.service;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.vlstream.config.VlStreamFirmwareProperties;
import com.ruoyi.vlstream.domain.VlStreamDevice;
import com.ruoyi.vlstream.domain.VlStreamFirmware;
import com.ruoyi.vlstream.domain.VlStreamFirmwareTask;
import com.ruoyi.vlstream.mapper.VlStreamDeviceMapper;
import com.ruoyi.vlstream.mqtt.VlStreamMqttBus;
import com.ruoyi.vlstream.mqtt.VlStreamProtocol;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import java.io.InputStream;
import java.net.URI;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class VlStreamFirmwareDeploymentService {
    private final VlStreamDeviceMapper deviceMapper;
    private final VlStreamFirmwareService firmwareService;
    private final VlStreamFirmwareTaskService taskService;
    private final VlStreamMqttBus mqttBus;
    private final VlStreamFirmwareProperties properties;

    public VlStreamFirmwareDeploymentService(VlStreamDeviceMapper deviceMapper,
            VlStreamFirmwareService firmwareService, VlStreamFirmwareTaskService taskService,
            VlStreamMqttBus mqttBus, VlStreamFirmwareProperties properties) {
        this.deviceMapper = deviceMapper;
        this.firmwareService = firmwareService;
        this.taskService = taskService;
        this.mqttBus = mqttBus;
        this.properties = properties;
    }

    public Map<String, Object> detail(Long deviceRowId) {
        taskService.expireStaleTasks();
        VlStreamDevice device = requiredDevice(deviceRowId);
        List<Map<String, Object>> upgrades = new ArrayList<>();
        VlStreamFirmware latest = null;
        if (StringUtils.isNotBlank(device.getDeviceModel()) && FirmwareVersion.isValid(device.getFirmwareVersion())) {
            latest = firmwareService.latestReady(device.getDeviceModel());
            if (latest != null && FirmwareVersion.isGreater(latest.getFirmwareVersion(), device.getFirmwareVersion())) {
                Map<String, Object> candidate = new LinkedHashMap<>();
                candidate.put("firmwareId", latest.getId());
                candidate.put("target", "rootfs");
                candidate.put("currentVersion", device.getFirmwareVersion());
                candidate.put("latestVersion", latest.getFirmwareVersion());
                candidate.put("fileName", latest.getOriginalFileName());
                candidate.put("fileSize", latest.getFileSize());
                candidate.put("sha256", latest.getSha256());
                upgrades.add(candidate);
            }
        }
        VlStreamFirmwareTask latestTask = taskService.latest(deviceRowId);
        boolean active = latestTask != null && taskService.isActive(latestTask.getDeployStatus());
        String blockedReason = null;
        if (StringUtils.isBlank(device.getDeviceModel())) blockedReason = "设备尚未上报型号";
        else if (!FirmwareVersion.isValid(device.getFirmwareVersion())) blockedReason = "设备尚未上报有效的 RootFS 版本";
        else if (active) blockedReason = "设备存在进行中的 OTA 任务，请等待完成或先终止任务";
        else if (!Boolean.TRUE.equals(device.getOnline())) blockedReason = "设备离线，无法下发 OTA 指令";
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("device", device);
        result.put("hasNewFirmware", !upgrades.isEmpty());
        result.put("canUpgrade", !upgrades.isEmpty() && !active && Boolean.TRUE.equals(device.getOnline()));
        result.put("upgradeBlockedReason", blockedReason);
        result.put("availableUpgrades", upgrades);
        result.put("latestTask", latestTask);
        return result;
    }

    public VlStreamFirmwareTask deploy(Long deviceRowId, Long firmwareId) {
        taskService.expireStaleTasks();
        VlStreamDevice device = requiredDevice(deviceRowId);
        if (!Boolean.TRUE.equals(device.getOnline())) throw new ServiceException("设备不在线，不能下发固件");
        if (StringUtils.isBlank(device.getDeviceModel())) throw new ServiceException("设备尚未上报型号");
        if (!FirmwareVersion.isValid(device.getFirmwareVersion())) throw new ServiceException("设备尚未上报有效的 RootFS 版本");
        if (taskService.hasActive(deviceRowId)) throw new ServiceException("该设备的 rootfs OTA 任务仍在处理中");
        VlStreamFirmware firmware = firmwareService.ready(firmwareId);
        if (!StringUtils.equals(device.getDeviceModel(), firmware.getCameraModel())) throw new ServiceException("固件型号与设备型号不匹配");
        if (!FirmwareVersion.isGreater(firmware.getFirmwareVersion(), device.getFirmwareVersion())) throw new ServiceException("目标固件版本必须高于设备当前 RootFS 版本");

        String requestId = UUID.randomUUID().toString();
        String messageId = "fw-" + UUID.randomUUID();
        long expiresAt = Instant.now().plusSeconds(Math.max(300, properties.getOtaDownloadUrlTtlSeconds())).getEpochSecond();
        String topic = VlStreamProtocol.topic(device.getDeviceId());
        VlStreamFirmwareTask task = new VlStreamFirmwareTask();
        task.setRequestId(requestId); task.setMqttMessageId(messageId); task.setDeviceRowId(deviceRowId);
        task.setDeviceId(device.getDeviceId()); task.setDeviceModel(device.getDeviceModel()); task.setTarget("rootfs");
        task.setCurrentVersion(device.getFirmwareVersion()); task.setTargetVersion(firmware.getFirmwareVersion());
        task.setFirmwareId(firmware.getId()); task.setFileName(firmware.getOriginalFileName());
        task.setFileSize(firmware.getFileSize()); task.setSha256(firmware.getSha256());
        task.setRollbackEnable(true); task.setRebootAfter(true); task.setDeployStatus("CREATED");
        task.setMqttTopic(topic); task.setDownloadExpiresAt(expiresAt); task.setCreateBy(currentUsername());
        task.setCreateTime(new Date()); task.setUpdateTime(task.getCreateTime());
        taskService.create(task);

        JSONObject payload = new JSONObject();
        payload.put("requestId", requestId); payload.put("deviceModel", device.getDeviceModel());
        payload.put("target", "rootfs"); payload.put("version", firmware.getFirmwareVersion());
        payload.put("packageUrl", platformDownloadUrl(requestId, messageId));
        payload.put("urlExpiresAt", Instant.ofEpochSecond(expiresAt).toString());
        payload.put("fileName", firmware.getOriginalFileName()); payload.put("fileSize", firmware.getFileSize());
        payload.put("sha256", firmware.getSha256()); payload.put("rollbackEnable", true); payload.put("rebootAfter", true);
        JSONObject envelope = new JSONObject();
        envelope.put("protocolVersion", VlStreamProtocol.VERSION); envelope.put("messageId", messageId);
        envelope.put("deviceId", device.getDeviceId()); envelope.put("sentAt", Instant.now().toString());
        envelope.put("msgDir", VlStreamProtocol.PLATFORM_TO_DEVICE); envelope.put("mainBizType", "device");
        envelope.put("subBizType", "firmwareDeploy"); envelope.put("payload", payload); envelope.put("extend", new JSONObject());
        try {
            mqttBus.publish(topic, envelope);
            taskService.markPublished(task.getId());
        } catch (RuntimeException ex) {
            taskService.markPublishFailed(task.getId(), rootMessage(ex));
            throw ex;
        }
        return taskService.byRequestId(requestId);
    }

    public VlStreamFirmwareTask cancel(Long deviceRowId, String requestId) {
        requiredDevice(deviceRowId);
        return taskService.cancel(deviceRowId, requestId);
    }

    public Download openDownload(String requestId, String messageId) {
        VlStreamFirmwareTask task = taskService.byRequestId(StringUtils.trimToEmpty(requestId));
        if (task == null || !StringUtils.equals(task.getMqttMessageId(), StringUtils.trim(messageId))
                || task.getDownloadExpiresAt() == null || task.getDownloadExpiresAt() < Instant.now().getEpochSecond()) {
            throw new ServiceException("OTA 下载地址无效或已过期");
        }
        VlStreamFirmware firmware = firmwareService.ready(task.getFirmwareId());
        if (!task.getFileSize().equals(firmware.getFileSize()) || !StringUtils.equalsIgnoreCase(task.getSha256(), firmware.getSha256())) {
            throw new ServiceException("OTA 固件元数据与下发任务不一致");
        }
        return new Download(firmwareService.open(firmware), firmware.getOriginalFileName(), firmware.getContentType(), firmware.getFileSize());
    }

    private VlStreamDevice requiredDevice(Long id) {
        VlStreamDevice device = id == null ? null : deviceMapper.selectById(id);
        if (device == null) throw new ServiceException("设备不存在");
        return device;
    }

    private String platformDownloadUrl(String requestId, String messageId) {
        String base = StringUtils.removeEnd(StringUtils.trimToEmpty(properties.getPlatformBaseUrl()), "/");
        try {
            URI uri = URI.create(base);
            if (!("http".equalsIgnoreCase(uri.getScheme()) || "https".equalsIgnoreCase(uri.getScheme()))
                    || StringUtils.isBlank(uri.getHost()) || uri.getQuery() != null || uri.getFragment() != null) {
                throw new IllegalArgumentException("invalid URL");
            }
        } catch (RuntimeException ex) {
            throw new ServiceException("vlstream.firmware.platform-base-url 必须是摄像头可访问的 WVP HTTP(S) 根地址");
        }
        return base + "/vlstream/firmware/ota/" + requestId + "/" + messageId;
    }

    private String currentUsername() {
        try { return SecurityUtils.getUsername(); } catch (RuntimeException ignored) { return "vlstream"; }
    }
    private String rootMessage(Throwable throwable) {
        Throwable current = throwable;
        while (current.getCause() != null && current.getCause() != current) current = current.getCause();
        return StringUtils.defaultIfBlank(current.getMessage(), current.getClass().getSimpleName());
    }

    public static class Download {
        private final InputStream input; private final String fileName; private final String contentType; private final long size;
        public Download(InputStream input, String fileName, String contentType, long size) {
            this.input = input; this.fileName = fileName; this.contentType = contentType; this.size = size;
        }
        public InputStream getInput() { return input; }
        public String getFileName() { return fileName; }
        public String getContentType() { return contentType; }
        public long getSize() { return size; }
    }
}
