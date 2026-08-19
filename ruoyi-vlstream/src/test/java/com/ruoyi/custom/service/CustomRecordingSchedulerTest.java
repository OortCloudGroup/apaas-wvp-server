package com.ruoyi.custom.service;

import com.ruoyi.custom.domain.CustomRecordingPlan;
import org.junit.Test;

import java.time.LocalDateTime;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class CustomRecordingSchedulerTest {
    @Test
    public void matchesSameDayWindow() {
        CustomRecordingPlan plan = plan("1", "08:00", "18:00");
        assertTrue(CustomRecordingScheduler.matches(plan, LocalDateTime.of(2026, 8, 17, 9, 0)));
        assertFalse(CustomRecordingScheduler.matches(plan, LocalDateTime.of(2026, 8, 17, 19, 0)));
    }

    @Test
    public void matchesCrossMidnightWindowByStartDay() {
        CustomRecordingPlan plan = plan("1", "22:00", "02:00");
        assertTrue(CustomRecordingScheduler.matches(plan, LocalDateTime.of(2026, 8, 17, 23, 0)));
        assertTrue(CustomRecordingScheduler.matches(plan, LocalDateTime.of(2026, 8, 18, 1, 0)));
        assertFalse(CustomRecordingScheduler.matches(plan, LocalDateTime.of(2026, 8, 18, 3, 0)));
    }

    private CustomRecordingPlan plan(String days, String start, String end) {
        CustomRecordingPlan plan = new CustomRecordingPlan();
        plan.setEnabled(true);
        plan.setWeekDays(days);
        plan.setStartTime(start);
        plan.setEndTime(end);
        return plan;
    }
}
