package com.ruoyi.vlstream.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import java.util.Date;

public class VlStreamDevice extends BaseEntity {
    private static final long serialVersionUID = 1L;
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;
    private String deviceId;
    private String deviceName;
    private String deviceSerial;
    private String firmwareVersion;
    private String faceVersion;
    private String ipAddr;
    private String mac;
    private Boolean online;
    private String onlineReason;
    private Long heartbeatIndex;
    private String lastMessageId;
    private Date lastReportedAt;
    private Date lastHeartbeatTime;
    private String telemetryJson;
    private String serviceStatusJson;
    private String keyword;
    private String categoryType;
    private Long categoryId;
    private Boolean unclassified;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getDeviceId() { return deviceId; }
    public void setDeviceId(String deviceId) { this.deviceId = deviceId; }
    public String getDeviceName() { return deviceName; }
    public void setDeviceName(String deviceName) { this.deviceName = deviceName; }
    public String getDeviceSerial() { return deviceSerial; }
    public void setDeviceSerial(String deviceSerial) { this.deviceSerial = deviceSerial; }
    public String getFirmwareVersion() { return firmwareVersion; }
    public void setFirmwareVersion(String firmwareVersion) { this.firmwareVersion = firmwareVersion; }
    public String getFaceVersion() { return faceVersion; }
    public void setFaceVersion(String faceVersion) { this.faceVersion = faceVersion; }
    public String getIpAddr() { return ipAddr; }
    public void setIpAddr(String ipAddr) { this.ipAddr = ipAddr; }
    public String getMac() { return mac; }
    public void setMac(String mac) { this.mac = mac; }
    public Boolean getOnline() { return online; }
    public void setOnline(Boolean online) { this.online = online; }
    public String getOnlineReason() { return onlineReason; }
    public void setOnlineReason(String onlineReason) { this.onlineReason = onlineReason; }
    public Long getHeartbeatIndex() { return heartbeatIndex; }
    public void setHeartbeatIndex(Long heartbeatIndex) { this.heartbeatIndex = heartbeatIndex; }
    public String getLastMessageId() { return lastMessageId; }
    public void setLastMessageId(String lastMessageId) { this.lastMessageId = lastMessageId; }
    public Date getLastReportedAt() { return lastReportedAt; }
    public void setLastReportedAt(Date lastReportedAt) { this.lastReportedAt = lastReportedAt; }
    public Date getLastHeartbeatTime() { return lastHeartbeatTime; }
    public void setLastHeartbeatTime(Date lastHeartbeatTime) { this.lastHeartbeatTime = lastHeartbeatTime; }
    public String getTelemetryJson() { return telemetryJson; }
    public void setTelemetryJson(String telemetryJson) { this.telemetryJson = telemetryJson; }
    public String getServiceStatusJson() { return serviceStatusJson; }
    public void setServiceStatusJson(String serviceStatusJson) { this.serviceStatusJson = serviceStatusJson; }
    public String getKeyword() { return keyword; }
    public void setKeyword(String keyword) { this.keyword = keyword; }
    public String getCategoryType() { return categoryType; }
    public void setCategoryType(String categoryType) { this.categoryType = categoryType; }
    public Long getCategoryId() { return categoryId; }
    public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    public Boolean getUnclassified() { return unclassified; }
    public void setUnclassified(Boolean unclassified) { this.unclassified = unclassified; }
}
