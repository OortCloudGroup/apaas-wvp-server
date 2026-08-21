package com.ruoyi.vlstream.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "vlstream.firmware")
public class VlStreamFirmwareProperties {
    private String endpoint;
    private String publicEndpoint;
    private String accessKey;
    private String secretKey;
    private String bucket = "vlstream-firmware";
    private String platformBaseUrl;
    private int uploadUrlTtlSeconds = 600;
    private int downloadUrlTtlSeconds = 1800;
    private int otaDownloadUrlTtlSeconds = 7200;
    private int otaTaskInactivityTimeoutMinutes = 30;
    private long maxPackageBytes = 160L * 1024L * 1024L;

    public String getEndpoint() { return endpoint; }
    public void setEndpoint(String endpoint) { this.endpoint = endpoint; }
    public String getPublicEndpoint() { return publicEndpoint; }
    public void setPublicEndpoint(String publicEndpoint) { this.publicEndpoint = publicEndpoint; }
    public String getAccessKey() { return accessKey; }
    public void setAccessKey(String accessKey) { this.accessKey = accessKey; }
    public String getSecretKey() { return secretKey; }
    public void setSecretKey(String secretKey) { this.secretKey = secretKey; }
    public String getBucket() { return bucket; }
    public void setBucket(String bucket) { this.bucket = bucket; }
    public String getPlatformBaseUrl() { return platformBaseUrl; }
    public void setPlatformBaseUrl(String platformBaseUrl) { this.platformBaseUrl = platformBaseUrl; }
    public int getUploadUrlTtlSeconds() { return uploadUrlTtlSeconds; }
    public void setUploadUrlTtlSeconds(int uploadUrlTtlSeconds) { this.uploadUrlTtlSeconds = uploadUrlTtlSeconds; }
    public int getDownloadUrlTtlSeconds() { return downloadUrlTtlSeconds; }
    public void setDownloadUrlTtlSeconds(int downloadUrlTtlSeconds) { this.downloadUrlTtlSeconds = downloadUrlTtlSeconds; }
    public int getOtaDownloadUrlTtlSeconds() { return otaDownloadUrlTtlSeconds; }
    public void setOtaDownloadUrlTtlSeconds(int otaDownloadUrlTtlSeconds) { this.otaDownloadUrlTtlSeconds = otaDownloadUrlTtlSeconds; }
    public int getOtaTaskInactivityTimeoutMinutes() { return otaTaskInactivityTimeoutMinutes; }
    public void setOtaTaskInactivityTimeoutMinutes(int value) { this.otaTaskInactivityTimeoutMinutes = value; }
    public long getMaxPackageBytes() { return maxPackageBytes; }
    public void setMaxPackageBytes(long maxPackageBytes) { this.maxPackageBytes = maxPackageBytes; }
}
