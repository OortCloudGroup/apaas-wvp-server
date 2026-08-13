package com.ruoyi.vlstream.mqtt;

import com.alibaba.fastjson2.JSONObject;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class VlStreamProtocolTest {
    @Test
    public void acceptsCurrentAndLegacyDeviceBusinessType() {
        JSONObject message = new JSONObject();
        message.put("subBizType", "state");
        message.put("mainBizType", "device");
        assertTrue(VlStreamProtocol.isDeviceState(message));
        message.put("mainBizType", "deviceBiz");
        assertTrue(VlStreamProtocol.isDeviceState(message));
    }

    @Test
    public void replyCorrelatesOriginalMessage() {
        JSONObject source = new JSONObject();
        source.put("messageId", "up-heartbeat-1");
        source.put("deviceId", "DEV-1");
        source.put("mainBizType", "device");
        source.put("subBizType", "state");
        JSONObject reply = VlStreamProtocol.reply(source, 200, "状态已接收");
        assertEquals("platform2dev", reply.getString("msgDir"));
        assertEquals("up-heartbeat-1", reply.getJSONObject("payload").getString("sourceMsgId"));
        assertEquals(200, reply.getJSONObject("payload").getIntValue("code"));
    }
}
