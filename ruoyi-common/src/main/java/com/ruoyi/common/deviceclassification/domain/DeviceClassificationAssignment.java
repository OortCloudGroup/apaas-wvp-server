package com.ruoyi.common.deviceclassification.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import java.util.ArrayList;
import java.util.List;

/** 单台或批量设备的完整分类设置。 */
public class DeviceClassificationAssignment {
    private String protocolType;
    private List<String> deviceKeys = new ArrayList<>();
    @JsonSerialize(using = ToStringSerializer.class)
    private Long regionId;
    @JsonSerialize(using = ToStringSerializer.class)
    private Long groupId;
    @JsonSerialize(contentUsing = ToStringSerializer.class)
    private List<Long> tagIds = new ArrayList<>();

    public String getProtocolType() { return protocolType; }
    public void setProtocolType(String protocolType) { this.protocolType = protocolType; }
    public List<String> getDeviceKeys() { return deviceKeys; }
    public void setDeviceKeys(List<String> deviceKeys) { this.deviceKeys = deviceKeys; }
    public Long getRegionId() { return regionId; }
    public void setRegionId(Long regionId) { this.regionId = regionId; }
    public Long getGroupId() { return groupId; }
    public void setGroupId(Long groupId) { this.groupId = groupId; }
    public List<Long> getTagIds() { return tagIds; }
    public void setTagIds(List<Long> tagIds) { this.tagIds = tagIds; }
}
