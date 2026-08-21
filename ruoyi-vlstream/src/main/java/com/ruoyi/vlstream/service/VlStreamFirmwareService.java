package com.ruoyi.vlstream.service;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.vlstream.config.VlStreamFirmwareProperties;
import com.ruoyi.vlstream.domain.VlStreamFirmware;
import com.ruoyi.vlstream.domain.dto.FirmwareUploadRequest;
import com.ruoyi.vlstream.mapper.VlStreamFirmwareMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import java.io.InputStream;
import java.time.Instant;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

@Service
public class VlStreamFirmwareService {
    private final VlStreamFirmwareMapper mapper;
    private final VlStreamFirmwareStorage storage;
    private final VlStreamFirmwareProperties properties;

    public VlStreamFirmwareService(VlStreamFirmwareMapper mapper, VlStreamFirmwareStorage storage,
                                   VlStreamFirmwareProperties properties) {
        this.mapper = mapper;
        this.storage = storage;
        this.properties = properties;
    }

    public Map<String, Object> page(long current, long size, String cameraModel, String firmwareVersion) {
        int pageSize = (int) Math.max(1, Math.min(size, 100));
        long pageNumber = Math.max(1, current);
        Map<String, Object> page = new LinkedHashMap<>();
        page.put("records", mapper.selectPage(trim(cameraModel), trim(firmwareVersion),
                (pageNumber - 1) * pageSize, pageSize));
        page.put("total", mapper.count(trim(cameraModel), trim(firmwareVersion)));
        page.put("current", pageNumber);
        page.put("size", pageSize);
        return page;
    }

    public Map<String, Object> issueUpload(FirmwareUploadRequest request) {
        ValidatedUpload upload = validate(request);
        if (mapper.selectByModelAndVersion(upload.cameraModel, upload.version) != null) {
            throw new ServiceException("相同摄像头型号和固件版本已存在");
        }
        int ttl = bounded(properties.getUploadUrlTtlSeconds(), 600, 60, 3600);
        Date now = new Date();
        String objectKey = "rootfs/" + safeSegment(upload.cameraModel) + "/" + upload.version + "/"
                + UUID.randomUUID() + ".ota";
        VlStreamFirmware firmware = new VlStreamFirmware();
        firmware.setCameraModel(upload.cameraModel);
        firmware.setTarget("rootfs");
        firmware.setFirmwareVersion(upload.version);
        firmware.setBucket(storage.bucket());
        firmware.setObjectKey(objectKey);
        firmware.setOriginalFileName(upload.fileName);
        firmware.setContentType(upload.contentType);
        firmware.setFileSize(upload.fileSize);
        firmware.setUploadStatus("UPLOADING");
        firmware.setUploadExpiresAt(Date.from(Instant.now().plusSeconds(ttl)));
        firmware.setCreateBy(currentUsername());
        firmware.setCreateTime(now);
        firmware.setUpdateTime(now);
        if (mapper.insert(firmware) != 1) throw new ServiceException("创建固件上传记录失败");
        Map<String, Object> grant = new LinkedHashMap<>();
        grant.put("firmwareId", firmware.getId());
        grant.put("uploadUrl", storage.presignedPut(objectKey, ttl));
        grant.put("contentType", upload.contentType);
        grant.put("expiresAt", firmware.getUploadExpiresAt());
        return grant;
    }

    public VlStreamFirmware complete(Long id) {
        VlStreamFirmware firmware = required(id);
        if ("READY".equals(firmware.getUploadStatus())) return firmware;
        if (firmware.getUploadExpiresAt() == null || firmware.getUploadExpiresAt().before(new Date())) {
            throw new ServiceException("固件上传地址已过期，请重新上传");
        }
        String sha256 = storage.verifyAndSha256(firmware.getObjectKey(), firmware.getFileSize());
        if (mapper.markReady(id, sha256) != 1) throw new ServiceException("固件上传状态更新失败");
        return required(id);
    }

    public Map<String, Object> downloadUrl(Long id) {
        VlStreamFirmware firmware = ready(id);
        int ttl = bounded(properties.getDownloadUrlTtlSeconds(), 1800, 60, 86400);
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("url", storage.presignedGet(firmware.getObjectKey(), ttl));
        result.put("expiresAt", Date.from(Instant.now().plusSeconds(ttl)));
        return result;
    }

    public void remove(Long id) {
        VlStreamFirmware firmware = required(id);
        storage.delete(firmware.getObjectKey());
        if (mapper.deleteById(id) != 1) throw new ServiceException("固件记录删除失败");
    }

    public VlStreamFirmware required(Long id) {
        if (id == null) throw new ServiceException("固件 ID 不能为空");
        VlStreamFirmware firmware = mapper.selectById(id);
        if (firmware == null) throw new ServiceException("固件记录不存在");
        return firmware;
    }

    public VlStreamFirmware ready(Long id) {
        VlStreamFirmware firmware = required(id);
        if (!"READY".equals(firmware.getUploadStatus()) || StringUtils.length(firmware.getSha256()) != 64) {
            throw new ServiceException("固件包尚未完成校验");
        }
        return firmware;
    }

    public VlStreamFirmware latestReady(String cameraModel) {
        List<VlStreamFirmware> candidates = mapper.selectReadyByModel(cameraModel);
        VlStreamFirmware latest = null;
        for (VlStreamFirmware candidate : candidates) {
            if (latest == null || FirmwareVersion.isGreater(candidate.getFirmwareVersion(), latest.getFirmwareVersion())) {
                latest = candidate;
            }
        }
        return latest;
    }

    public InputStream open(VlStreamFirmware firmware) { return storage.open(firmware.getObjectKey()); }

    private ValidatedUpload validate(FirmwareUploadRequest request) {
        if (request == null) throw new ServiceException("固件上传参数不能为空");
        String cameraModel = trim(request.getCameraModel());
        if (StringUtils.isBlank(cameraModel) || cameraModel.length() > 128
                || cameraModel.indexOf('/') >= 0 || cameraModel.indexOf('\\') >= 0) {
            throw new ServiceException("摄像头型号不能为空、不能超过 128 个字符且不能包含路径分隔符");
        }
        String version = trim(request.getFirmwareVersion());
        if (!FirmwareVersion.isValid(version)) throw new ServiceException("固件版本号必须使用至少三段的纯数字点分格式，例如 1.0.1.14");
        String fileName = normalizeFileName(request.getFileName());
        if (!fileName.toLowerCase(Locale.ROOT).endsWith(".ota")) throw new ServiceException("仅支持包含 manifest 的 .ota 固件包");
        long fileSize = request.getFileSize() == null ? 0L : request.getFileSize();
        if (fileSize <= 0 || fileSize > properties.getMaxPackageBytes()) throw new ServiceException("固件包大小必须大于 0 且不超过 " + properties.getMaxPackageBytes() + " 字节");
        String contentType = StringUtils.defaultIfBlank(trim(request.getContentType()), "application/octet-stream");
        return new ValidatedUpload(cameraModel, version, fileName, contentType, fileSize);
    }

    private String normalizeFileName(String value) {
        String fileName = StringUtils.defaultString(value).replace('\\', '/');
        fileName = fileName.substring(fileName.lastIndexOf('/') + 1).trim();
        if (fileName.isEmpty() || fileName.length() > 255) throw new ServiceException("固件包文件名不能为空且不能超过 255 个字符");
        return fileName;
    }

    private String currentUsername() {
        try { return SecurityUtils.getUsername(); } catch (RuntimeException ignored) { return "vlstream"; }
    }
    private String safeSegment(String value) { return value.trim().replace(' ', '_'); }
    private String trim(String value) { return StringUtils.trimToNull(value); }
    private int bounded(int value, int fallback, int min, int max) {
        int actual = value <= 0 ? fallback : value;
        return Math.max(min, Math.min(actual, max));
    }

    private static class ValidatedUpload {
        private final String cameraModel, version, fileName, contentType;
        private final long fileSize;
        private ValidatedUpload(String cameraModel, String version, String fileName, String contentType, long fileSize) {
            this.cameraModel = cameraModel; this.version = version; this.fileName = fileName;
            this.contentType = contentType; this.fileSize = fileSize;
        }
    }
}
