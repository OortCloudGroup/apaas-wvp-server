package com.ruoyi.vlstream.service;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.vlstream.config.VlStreamFirmwareProperties;
import io.minio.BucketExistsArgs;
import io.minio.GetObjectArgs;
import io.minio.GetPresignedObjectUrlArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.RemoveObjectArgs;
import io.minio.StatObjectArgs;
import io.minio.StatObjectResponse;
import io.minio.http.Method;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import java.io.InputStream;
import java.security.MessageDigest;
import java.util.concurrent.TimeUnit;

@Component
public class VlStreamFirmwareStorage {
    private final VlStreamFirmwareProperties properties;

    public VlStreamFirmwareStorage(VlStreamFirmwareProperties properties) {
        this.properties = properties;
    }

    public String presignedPut(String objectKey, int ttlSeconds) {
        ensureBucket();
        return presign(publicClient(), Method.PUT, objectKey, ttlSeconds);
    }

    public String presignedGet(String objectKey, int ttlSeconds) {
        return presign(publicClient(), Method.GET, objectKey, ttlSeconds);
    }

    public String verifyAndSha256(String objectKey, long expectedSize) {
        try {
            StatObjectResponse stat = internalClient().statObject(StatObjectArgs.builder()
                    .bucket(bucket()).object(objectKey).build());
            if (stat.size() != expectedSize) throw new ServiceException("MinIO 固件包大小不匹配");
            try (InputStream input = open(objectKey)) {
                MessageDigest digest = MessageDigest.getInstance("SHA-256");
                byte[] buffer = new byte[8192];
                int read;
                while ((read = input.read(buffer)) != -1) digest.update(buffer, 0, read);
                StringBuilder result = new StringBuilder(64);
                for (byte value : digest.digest()) result.append(String.format("%02x", value & 0xff));
                return result.toString();
            }
        } catch (ServiceException ex) {
            throw ex;
        } catch (Exception ex) {
            throw new ServiceException("校验 MinIO 固件包失败：" + rootMessage(ex));
        }
    }

    public InputStream open(String objectKey) {
        try {
            return internalClient().getObject(GetObjectArgs.builder().bucket(bucket()).object(objectKey).build());
        } catch (Exception ex) {
            throw new ServiceException("读取 MinIO 固件包失败：" + rootMessage(ex));
        }
    }

    public void delete(String objectKey) {
        try {
            internalClient().removeObject(RemoveObjectArgs.builder().bucket(bucket()).object(objectKey).build());
        } catch (Exception ex) {
            throw new ServiceException("删除 MinIO 固件包失败：" + rootMessage(ex));
        }
    }

    public String bucket() {
        String value = StringUtils.trimToEmpty(properties.getBucket());
        if (value.isEmpty()) throw new ServiceException("vlstream.firmware.bucket 未配置");
        return value;
    }

    private String presign(MinioClient client, Method method, String objectKey, int ttlSeconds) {
        try {
            return client.getPresignedObjectUrl(GetPresignedObjectUrlArgs.builder().method(method)
                    .bucket(bucket()).object(objectKey)
                    .expiry(Math.max(60, Math.min(ttlSeconds, 604800)), TimeUnit.SECONDS).build());
        } catch (Exception ex) {
            throw new ServiceException("生成 MinIO 临时地址失败：" + rootMessage(ex));
        }
    }

    private void ensureBucket() {
        try {
            MinioClient client = internalClient();
            if (!client.bucketExists(BucketExistsArgs.builder().bucket(bucket()).build())) {
                client.makeBucket(MakeBucketArgs.builder().bucket(bucket()).build());
            }
        } catch (Exception ex) {
            throw new ServiceException("初始化 MinIO 固件存储桶失败：" + rootMessage(ex));
        }
    }

    private MinioClient internalClient() { return client(properties.getEndpoint()); }
    private MinioClient publicClient() {
        return client(StringUtils.defaultIfBlank(properties.getPublicEndpoint(), properties.getEndpoint()));
    }

    private MinioClient client(String endpoint) {
        if (StringUtils.isAnyBlank(endpoint, properties.getAccessKey(), properties.getSecretKey())) {
            throw new ServiceException("WVP 固件 MinIO 地址或访问凭据未配置");
        }
        try {
            return MinioClient.builder().endpoint(endpoint.trim())
                    .credentials(properties.getAccessKey().trim(), properties.getSecretKey()).build();
        } catch (RuntimeException ex) {
            throw new ServiceException("WVP 固件 MinIO 地址无效：" + rootMessage(ex));
        }
    }

    private String rootMessage(Throwable throwable) {
        Throwable current = throwable;
        while (current.getCause() != null && current.getCause() != current) current = current.getCause();
        return StringUtils.defaultIfBlank(current.getMessage(), current.getClass().getSimpleName());
    }
}
