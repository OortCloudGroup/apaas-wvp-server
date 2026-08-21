package com.ruoyi.vlstream.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class VlStreamFirmwareTask extends BaseEntity {
    private static final long serialVersionUID = 1L;
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;
    private String requestId;
    private String mqttMessageId;
    private Long deviceRowId;
    private String deviceId;
    private String deviceModel;
    private String target;
    private String currentVersion;
    private String targetVersion;
    private Long firmwareId;
    private String fileName;
    private Long fileSize;
    private String sha256;
    private Boolean rollbackEnable;
    private Boolean rebootAfter;
    private String deployStatus;
    private String mqttTopic;
    private Long downloadExpiresAt;
    private Date publishedAt;
    private Date lastReplyAt;
    private Date completedAt;
    private String failureReason;
    private String replyPayload;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getRequestId() { return requestId; }
    public void setRequestId(String requestId) { this.requestId = requestId; }
    public String getMqttMessageId() { return mqttMessageId; }
    public void setMqttMessageId(String mqttMessageId) { this.mqttMessageId = mqttMessageId; }
    public Long getDeviceRowId() { return deviceRowId; }
    public void setDeviceRowId(Long deviceRowId) { this.deviceRowId = deviceRowId; }
    public String getDeviceId() { return deviceId; }
    public void setDeviceId(String deviceId) { this.deviceId = deviceId; }
    public String getDeviceModel() { return deviceModel; }
    public void setDeviceModel(String deviceModel) { this.deviceModel = deviceModel; }
    public String getTarget() { return target; }
    public void setTarget(String target) { this.target = target; }
    public String getCurrentVersion() { return currentVersion; }
    public void setCurrentVersion(String currentVersion) { this.currentVersion = currentVersion; }
    public String getTargetVersion() { return targetVersion; }
    public void setTargetVersion(String targetVersion) { this.targetVersion = targetVersion; }
    public Long getFirmwareId() { return firmwareId; }
    public void setFirmwareId(Long firmwareId) { this.firmwareId = firmwareId; }
    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }
    public Long getFileSize() { return fileSize; }
    public void setFileSize(Long fileSize) { this.fileSize = fileSize; }
    public String getSha256() { return sha256; }
    public void setSha256(String sha256) { this.sha256 = sha256; }
    public Boolean getRollbackEnable() { return rollbackEnable; }
    public void setRollbackEnable(Boolean rollbackEnable) { this.rollbackEnable = rollbackEnable; }
    public Boolean getRebootAfter() { return rebootAfter; }
    public void setRebootAfter(Boolean rebootAfter) { this.rebootAfter = rebootAfter; }
    public String getDeployStatus() { return deployStatus; }
    public void setDeployStatus(String deployStatus) { this.deployStatus = deployStatus; }
    public String getMqttTopic() { return mqttTopic; }
    public void setMqttTopic(String mqttTopic) { this.mqttTopic = mqttTopic; }
    public Long getDownloadExpiresAt() { return downloadExpiresAt; }
    public void setDownloadExpiresAt(Long downloadExpiresAt) { this.downloadExpiresAt = downloadExpiresAt; }
    public Date getPublishedAt() { return publishedAt; }
    public void setPublishedAt(Date publishedAt) { this.publishedAt = publishedAt; }
    public Date getLastReplyAt() { return lastReplyAt; }
    public void setLastReplyAt(Date lastReplyAt) { this.lastReplyAt = lastReplyAt; }
    public Date getCompletedAt() { return completedAt; }
    public void setCompletedAt(Date completedAt) { this.completedAt = completedAt; }
    public String getFailureReason() { return failureReason; }
    public void setFailureReason(String failureReason) { this.failureReason = failureReason; }
    public String getReplyPayload() { return replyPayload; }
    public void setReplyPayload(String replyPayload) { this.replyPayload = replyPayload; }
}
