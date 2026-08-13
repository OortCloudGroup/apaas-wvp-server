package com.ruoyi.vlstream.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class VlStreamDeviceStream extends BaseEntity {
    private static final long serialVersionUID = 1L;
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;
    @JsonSerialize(using = ToStringSerializer.class)
    private Long deviceRowId;
    private String channelId;
    private String streamName;
    private String streamType;
    private String protocol;
    @JsonIgnore
    private String sourceUrl;
    private Boolean defaultStream;
    private Boolean available;
    private String zlmApp;
    private String zlmStream;
    @JsonIgnore
    private String zlmProxyKey;
    private Date lastReportTime;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getDeviceRowId() { return deviceRowId; }
    public void setDeviceRowId(Long deviceRowId) { this.deviceRowId = deviceRowId; }
    public String getChannelId() { return channelId; }
    public void setChannelId(String channelId) { this.channelId = channelId; }
    public String getStreamName() { return streamName; }
    public void setStreamName(String streamName) { this.streamName = streamName; }
    public String getStreamType() { return streamType; }
    public void setStreamType(String streamType) { this.streamType = streamType; }
    public String getProtocol() { return protocol; }
    public void setProtocol(String protocol) { this.protocol = protocol; }
    public String getSourceUrl() { return sourceUrl; }
    public void setSourceUrl(String sourceUrl) { this.sourceUrl = sourceUrl; }
    public Boolean getDefaultStream() { return defaultStream; }
    public void setDefaultStream(Boolean defaultStream) { this.defaultStream = defaultStream; }
    public Boolean getAvailable() { return available; }
    public void setAvailable(Boolean available) { this.available = available; }
    public String getZlmApp() { return zlmApp; }
    public void setZlmApp(String zlmApp) { this.zlmApp = zlmApp; }
    public String getZlmStream() { return zlmStream; }
    public void setZlmStream(String zlmStream) { this.zlmStream = zlmStream; }
    public String getZlmProxyKey() { return zlmProxyKey; }
    public void setZlmProxyKey(String zlmProxyKey) { this.zlmProxyKey = zlmProxyKey; }
    public Date getLastReportTime() { return lastReportTime; }
    public void setLastReportTime(Date lastReportTime) { this.lastReportTime = lastReportTime; }
}
