package com.ruoyi.vlstream.service;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.vlstream.domain.VlStreamFirmwareTask;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@Service
public class VlStreamFirmwareReplyHandler {
    private static final Logger log = LoggerFactory.getLogger(VlStreamFirmwareReplyHandler.class);
    private static final Set<String> PROGRESS = new HashSet<>(Arrays.asList(
            "ACCEPTED", "DOWNLOADING", "VERIFYING", "INSTALLING", "REBOOTING"));
    private final VlStreamFirmwareTaskService taskService;

    public VlStreamFirmwareReplyHandler(VlStreamFirmwareTaskService taskService) { this.taskService = taskService; }

    public boolean handle(JSONObject message) {
        JSONObject payload = message.getJSONObject("payload");
        if (payload == null) return false;
        String sourceMsgId = StringUtils.trimToEmpty(payload.getString("sourceMsgId"));
        VlStreamFirmwareTask task = taskService.byMessageId(sourceMsgId);
        if (task == null) return false;
        JSONObject bizData = payload.getJSONObject("bizData");
        if (!matches(task, message, bizData)) {
            log.warn("Ignoring mismatched VLStream OTA reply: sourceMsgId={}, deviceId={}", sourceMsgId, message.getString("deviceId"));
            return true;
        }
        int code = payload.getIntValue("code");
        String reported = bizData == null ? null : StringUtils.upperCase(bizData.getString("status"));
        String status;
        if (code >= 400 || "FAILED".equals(reported)) status = "FAILED";
        else if (code == 200 || "SUCCESS".equals(reported)) status = "SUCCESS";
        else status = PROGRESS.contains(reported) ? reported : "ACCEPTED";
        String failure = "FAILED".equals(status)
                ? StringUtils.defaultIfBlank(payload.getString("errDetail"), payload.getString("msg")) : null;
        taskService.applyReply(task, status, failure, payload.toJSONString());
        return true;
    }

    private boolean matches(VlStreamFirmwareTask task, JSONObject message, JSONObject bizData) {
        if (!StringUtils.equals(task.getDeviceId(), message.getString("deviceId"))) return false;
        if (bizData == null) return true;
        return equalsIfPresent(task.getRequestId(), bizData.getString("requestId"))
                && equalsIfPresent(task.getDeviceModel(), bizData.getString("deviceModel"))
                && equalsIfPresent(task.getTarget(), bizData.getString("target"))
                && equalsIfPresent(task.getTargetVersion(), bizData.getString("version"))
                && equalsIfPresentIgnoreCase(task.getSha256(), bizData.getString("fileSha256"));
    }

    private boolean equalsIfPresent(String expected, String actual) {
        return StringUtils.isBlank(actual) || StringUtils.equals(expected, actual);
    }
    private boolean equalsIfPresentIgnoreCase(String expected, String actual) {
        return StringUtils.isBlank(actual) || StringUtils.equalsIgnoreCase(expected, actual);
    }
}
