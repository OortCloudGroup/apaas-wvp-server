package com.ruoyi.vlstream.service;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.vlstream.domain.VlStreamFirmwareTask;
import org.junit.Test;
import static org.junit.Assert.assertTrue;
import static org.mockito.ArgumentMatchers.contains;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class VlStreamFirmwareReplyHandlerTest {
    @Test
    public void appliesMatchedSuccessfulHardwareReply() {
        VlStreamFirmwareTaskService taskService = mock(VlStreamFirmwareTaskService.class);
        VlStreamFirmwareTask task = task();
        when(taskService.byMessageId("message-1")).thenReturn(task);
        JSONObject biz = new JSONObject();
        biz.put("requestId", "request-1"); biz.put("deviceModel", "OORT-6600-2.5");
        biz.put("target", "rootfs"); biz.put("version", "1.0.1.20"); biz.put("status", "SUCCESS");
        biz.put("fileSha256", task.getSha256());
        JSONObject payload = new JSONObject();
        payload.put("sourceMsgId", "message-1"); payload.put("code", 200); payload.put("bizData", biz);
        JSONObject message = new JSONObject();
        message.put("deviceId", "device-1"); message.put("payload", payload);

        assertTrue(new VlStreamFirmwareReplyHandler(taskService).handle(message));
        verify(taskService).applyReply(eq(task), eq("SUCCESS"), eq(null), contains("sourceMsgId"));
    }

    private VlStreamFirmwareTask task() {
        VlStreamFirmwareTask task = new VlStreamFirmwareTask();
        task.setDeviceId("device-1"); task.setDeviceModel("OORT-6600-2.5"); task.setTarget("rootfs");
        task.setRequestId("request-1"); task.setMqttMessageId("message-1"); task.setTargetVersion("1.0.1.20");
        task.setSha256("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        return task;
    }
}
