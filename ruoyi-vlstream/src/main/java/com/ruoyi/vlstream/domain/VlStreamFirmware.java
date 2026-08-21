package com.ruoyi.vlstream.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

public class VlStreamFirmware extends BaseEntity {
    private static final long serialVersionUID = 1L;
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;
    private String cameraModel;
    private String target;
    private String firmwareVersion;
    private String bucket;
    private String objectKey;
    private String originalFileName;
    private String contentType;
    private Long fileSize;
    private String sha256;
    private String uploadStatus;
    private Date uploadExpiresAt;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCameraModel() { return cameraModel; }
    public void setCameraModel(String cameraModel) { this.cameraModel = cameraModel; }
    public String getTarget() { return target; }
    public void setTarget(String target) { this.target = target; }
    public String getFirmwareVersion() { return firmwareVersion; }
    public void setFirmwareVersion(String firmwareVersion) { this.firmwareVersion = firmwareVersion; }
    public String getBucket() { return bucket; }
    public void setBucket(String bucket) { this.bucket = bucket; }
    public String getObjectKey() { return objectKey; }
    public void setObjectKey(String objectKey) { this.objectKey = objectKey; }
    public String getOriginalFileName() { return originalFileName; }
    public void setOriginalFileName(String originalFileName) { this.originalFileName = originalFileName; }
    public String getContentType() { return contentType; }
    public void setContentType(String contentType) { this.contentType = contentType; }
    public Long getFileSize() { return fileSize; }
    public void setFileSize(Long fileSize) { this.fileSize = fileSize; }
    public String getSha256() { return sha256; }
    public void setSha256(String sha256) { this.sha256 = sha256; }
    public String getUploadStatus() { return uploadStatus; }
    public void setUploadStatus(String uploadStatus) { this.uploadStatus = uploadStatus; }
    public Date getUploadExpiresAt() { return uploadExpiresAt; }
    public void setUploadExpiresAt(Date uploadExpiresAt) { this.uploadExpiresAt = uploadExpiresAt; }
}
