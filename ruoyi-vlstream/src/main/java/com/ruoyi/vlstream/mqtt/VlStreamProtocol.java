package com.ruoyi.vlstream.mqtt;

import com.alibaba.fastjson2.JSONObject;
import java.time.Instant;
import java.util.UUID;

public final class VlStreamProtocol {
    public static final String VERSION = "2.2";
    public static final String TOPIC_FILTER = "vlstream/v2.2/dev/+/bus";
    public static final String DEVICE_TO_PLATFORM = "dev2platform";
    public static final String PLATFORM_TO_DEVICE = "platform2dev";

    private VlStreamProtocol() { }

    public static String topic(String deviceId) {
        return "vlstream/v2.2/dev/" + deviceId + "/bus";
    }

    public static boolean isDeviceState(JSONObject message) {
        String main = message.getString("mainBizType");
        return ("device".equals(main) || "deviceBiz".equals(main))
                && "state".equals(message.getString("subBizType"));
    }

    public static JSONObject reply(JSONObject source, int code, String msg) {
        JSONObject payload = new JSONObject();
        payload.put("sourceMsgId", source.getString("messageId"));
        payload.put("code", code);
        payload.put("msg", msg);
        payload.put("errCode", code == 200 ? 0 : 1001);
        payload.put("errDetail", code == 200 ? "" : msg);
        payload.put("bizData", new JSONObject());

        JSONObject reply = new JSONObject();
        reply.put("protocolVersion", VERSION);
        reply.put("messageId", UUID.randomUUID().toString());
        reply.put("deviceId", source.getString("deviceId"));
        reply.put("sentAt", Instant.now().toString());
        reply.put("msgDir", PLATFORM_TO_DEVICE);
        reply.put("mainBizType", source.getString("mainBizType"));
        reply.put("subBizType", source.getString("subBizType"));
        reply.put("payload", payload);
        reply.put("extend", new JSONObject());
        return reply;
    }
}
