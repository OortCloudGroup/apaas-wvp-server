package com.ruoyi.custom.domain;

import com.ruoyi.common.core.domain.BaseEntity;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class CustomRecordingPlan extends BaseEntity {
    private static final long serialVersionUID = 1L;
    private Long id;
    private Long deviceId;
    @NotNull(message = "是否启用录像计划不能为空")
    private Boolean enabled;
    private String weekDays;
    @NotBlank(message = "录像开始时间不能为空")
    @Pattern(regexp = "^(?:[01]\\d|2[0-3]):[0-5]\\d$", message = "录像开始时间格式必须为HH:mm")
    private String startTime;
    @NotBlank(message = "录像结束时间不能为空")
    @Pattern(regexp = "^(?:[01]\\d|2[0-3]):[0-5]\\d$", message = "录像结束时间格式必须为HH:mm")
    private String endTime;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getDeviceId() { return deviceId; }
    public void setDeviceId(Long deviceId) { this.deviceId = deviceId; }
    public Boolean getEnabled() { return enabled; }
    public void setEnabled(Boolean enabled) { this.enabled = enabled; }
    public String getWeekDays() { return weekDays; }
    public void setWeekDays(String weekDays) { this.weekDays = weekDays; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }
    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }
}
