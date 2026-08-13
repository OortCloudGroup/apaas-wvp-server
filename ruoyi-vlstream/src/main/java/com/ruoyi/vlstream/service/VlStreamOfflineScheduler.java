package com.ruoyi.vlstream.service;

import com.ruoyi.vlstream.config.VlStreamDeviceProperties;
import com.ruoyi.vlstream.mapper.VlStreamDeviceMapper;
import com.ruoyi.vlstream.mapper.VlStreamMessageMapper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.util.Date;

@Component
public class VlStreamOfflineScheduler {
    private final VlStreamDeviceMapper deviceMapper;
    private final VlStreamMessageMapper messageMapper;
    private final VlStreamDeviceProperties properties;

    public VlStreamOfflineScheduler(VlStreamDeviceMapper deviceMapper, VlStreamMessageMapper messageMapper,
                                    VlStreamDeviceProperties properties) {
        this.deviceMapper = deviceMapper; this.messageMapper = messageMapper; this.properties = properties;
    }

    @Scheduled(initialDelay = 60000L, fixedDelay = 30000L)
    public void markOffline() {
        Date now = new Date();
        deviceMapper.markOfflineBefore(new Date(now.getTime() - properties.getOfflineTimeoutSeconds() * 1000L), now);
    }

    @Scheduled(initialDelay = 300000L, fixedDelay = 3600000L)
    public void cleanMessages() {
        messageMapper.deleteBefore(new Date(System.currentTimeMillis() - properties.getMessageRetentionHours() * 3600000L));
    }
}
