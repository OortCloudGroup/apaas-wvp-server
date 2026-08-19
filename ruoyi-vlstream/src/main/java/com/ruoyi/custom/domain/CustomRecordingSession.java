package com.ruoyi.custom.domain;

import java.util.Date;

public class CustomRecordingSession {
    private Long id;
    private Long deviceId;
    private String mediaServerId;
    private String app;
    private String stream;
    private String proxyKey;
    private String status;
    private Date startTime;
    private Date stopTime;
    private String stopReason;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getDeviceId() { return deviceId; }
    public void setDeviceId(Long deviceId) { this.deviceId = deviceId; }
    public String getMediaServerId() { return mediaServerId; }
    public void setMediaServerId(String mediaServerId) { this.mediaServerId = mediaServerId; }
    public String getApp() { return app; }
    public void setApp(String app) { this.app = app; }
    public String getStream() { return stream; }
    public void setStream(String stream) { this.stream = stream; }
    public String getProxyKey() { return proxyKey; }
    public void setProxyKey(String proxyKey) { this.proxyKey = proxyKey; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }
    public Date getStopTime() { return stopTime; }
    public void setStopTime(Date stopTime) { this.stopTime = stopTime; }
    public String getStopReason() { return stopReason; }
    public void setStopReason(String stopReason) { this.stopReason = stopReason; }
}
