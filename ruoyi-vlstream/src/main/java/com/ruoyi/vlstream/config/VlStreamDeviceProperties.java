package com.ruoyi.vlstream.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "vlstream.device")
public class VlStreamDeviceProperties {
    private long offlineTimeoutSeconds = 180L;
    private long messageRetentionHours = 24L;

    public long getOfflineTimeoutSeconds() { return offlineTimeoutSeconds; }
    public void setOfflineTimeoutSeconds(long offlineTimeoutSeconds) { this.offlineTimeoutSeconds = offlineTimeoutSeconds; }
    public long getMessageRetentionHours() { return messageRetentionHours; }
    public void setMessageRetentionHours(long messageRetentionHours) { this.messageRetentionHours = messageRetentionHours; }
}
