package com.ruoyi.custom.service;

import com.ruoyi.custom.domain.CustomRecordingPlan;
import com.ruoyi.custom.mapper.CustomDeviceMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@Component
public class CustomRecordingScheduler {
    private static final Logger log = LoggerFactory.getLogger(CustomRecordingScheduler.class);
    private final CustomDeviceMapper mapper;
    private final CustomMediaService mediaService;

    public CustomRecordingScheduler(CustomDeviceMapper mapper, CustomMediaService mediaService) {
        this.mapper = mapper;
        this.mediaService = mediaService;
    }

    @Scheduled(fixedDelayString = "${custom.recording.schedule-delay-ms:30000}")
    public void reconcile() {
        LocalDateTime now = LocalDateTime.now();
        for (CustomRecordingPlan plan : mapper.selectEnabledPlans()) {
            try {
                boolean shouldRecord = matches(plan, now);
                boolean recording = mediaService.getRecordingStatus(plan.getDeviceId()) != null;
                if (shouldRecord && !recording) mediaService.startRecording(plan.getDeviceId());
                if (!shouldRecord && recording) mediaService.stopRecording(plan.getDeviceId(), "schedule");
            } catch (RuntimeException ex) {
                log.warn("Custom device recording schedule failed: deviceId={}, reason={}", plan.getDeviceId(), ex.getMessage());
            }
        }
    }

    static boolean matches(CustomRecordingPlan plan, LocalDateTime now) {
        if (!Boolean.TRUE.equals(plan.getEnabled()) || plan.getStartTime() == null || plan.getEndTime() == null) return false;
        Set<String> days = new HashSet<>(Arrays.asList(plan.getWeekDays() == null ? new String[0] : plan.getWeekDays().split(",")));
        LocalTime start = LocalTime.parse(plan.getStartTime());
        LocalTime end = LocalTime.parse(plan.getEndTime());
        LocalTime current = now.toLocalTime();
        DayOfWeek today = now.getDayOfWeek();
        if (start.equals(end)) return days.contains(String.valueOf(today.getValue()));
        if (start.isBefore(end)) return days.contains(String.valueOf(today.getValue())) && !current.isBefore(start) && current.isBefore(end);
        if (!current.isBefore(start)) return days.contains(String.valueOf(today.getValue()));
        int yesterday = today.minus(1).getValue();
        return current.isBefore(end) && days.contains(String.valueOf(yesterday));
    }
}
