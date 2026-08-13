package com.ruoyi.common.deviceclassification.domain;

/** 设备与分类节点关系。 */
public class DeviceCategoryRelation {
    private Long categoryId;
    private String categoryType;
    private String protocolType;
    private String deviceKey;
    private String createBy;

    public Long getCategoryId() { return categoryId; }
    public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    public String getCategoryType() { return categoryType; }
    public void setCategoryType(String categoryType) { this.categoryType = categoryType; }
    public String getProtocolType() { return protocolType; }
    public void setProtocolType(String protocolType) { this.protocolType = protocolType; }
    public String getDeviceKey() { return deviceKey; }
    public void setDeviceKey(String deviceKey) { this.deviceKey = deviceKey; }
    public String getCreateBy() { return createBy; }
    public void setCreateBy(String createBy) { this.createBy = createBy; }
}
