package com.ruoyi.vlstream.service;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.vlstream.domain.VlStreamDevice;
import com.ruoyi.vlstream.domain.VlStreamDeviceStream;
import com.ruoyi.vlstream.mapper.VlStreamDeviceMapper;
import com.ruoyi.vlstream.mapper.VlStreamDeviceStreamMapper;
import com.ruoyi.vlstream.mapper.VlStreamMessageMapper;
import com.ruoyi.vlstream.mqtt.VlStreamProtocol;
import com.ruoyi.vlstream.util.VlStreamPlaybackUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Service
public class VlStreamDeviceStateService {
    private final VlStreamDeviceMapper deviceMapper;
    private final VlStreamDeviceStreamMapper streamMapper;
    private final VlStreamMessageMapper messageMapper;

    public VlStreamDeviceStateService(VlStreamDeviceMapper deviceMapper,
                                      VlStreamDeviceStreamMapper streamMapper,
                                      VlStreamMessageMapper messageMapper) {
        this.deviceMapper = deviceMapper;
        this.streamMapper = streamMapper;
        this.messageMapper = messageMapper;
    }

    @Transactional(rollbackFor = Exception.class)
    public synchronized JSONObject handle(JSONObject message) {
        String deviceId = StringUtils.trimToEmpty(message.getString("deviceId"));
        String messageId = StringUtils.trimToEmpty(message.getString("messageId"));
        if (StringUtils.isAnyBlank(deviceId, messageId)) {
            return VlStreamProtocol.reply(message, 400, "deviceId和messageId不能为空");
        }
        JSONObject payload = message.getJSONObject("payload");
        if (payload == null) {
            return VlStreamProtocol.reply(message, 400, "payload不能为空");
        }

        Date receivedAt = new Date();
        Date reportedAt = parseDate(message.getString("sentAt"), receivedAt);
        if (messageMapper.insertIgnore(deviceId, messageId, reportedAt, receivedAt) == 0) {
            return VlStreamProtocol.reply(message, 200, "重复消息已确认");
        }

        VlStreamDevice device = deviceMapper.selectByDeviceId(deviceId);
        if (device != null && device.getLastReportedAt() != null && reportedAt.before(device.getLastReportedAt())) {
            return VlStreamProtocol.reply(message, 200, "过期状态快照已忽略");
        }
        if (device == null) {
            device = new VlStreamDevice();
            device.setDeviceId(deviceId);
            device.setCreateTime(receivedAt);
        }
        device.setDeviceName(payload.getString("deviceName"));
        device.setDeviceSerial(payload.getString("deviceSerial"));
        device.setDeviceModel(payload.getString("deviceModel"));
        device.setFirmwareVersion(payload.getString("version"));
        device.setFaceVersion(payload.getString("deviceFaceVer"));
        device.setIpAddr(payload.getString("ipAddr"));
        device.setMac(payload.getString("mac"));
        device.setOnline(Boolean.TRUE.equals(payload.getBoolean("online")));
        device.setOnlineReason(payload.getString("reason"));
        device.setHeartbeatIndex(payload.getLong("heartbeatIndex"));
        device.setLastMessageId(messageId);
        device.setLastReportedAt(reportedAt);
        device.setLastHeartbeatTime(receivedAt);
        device.setTelemetryJson(json(payload.get("telemetry")));
        device.setServiceStatusJson(json(payload.get("serviceStatus")));
        device.setUpdateTime(receivedAt);
        if (device.getId() == null) deviceMapper.insert(device); else deviceMapper.update(device);

        synchronizeStreams(device.getId(), payload.getJSONArray("streams"), receivedAt);
        return VlStreamProtocol.reply(message, 200, "状态已接收");
    }

    private void synchronizeStreams(Long deviceRowId, JSONArray streams, Date now) {
        streamMapper.markUnavailable(deviceRowId, now);
        if (streams == null) return;
        Set<String> keys = new HashSet<>();
        boolean defaultAssigned = false;
        for (Object item : streams) {
            JSONObject source = item instanceof JSONObject ? (JSONObject) item : JSON.parseObject(String.valueOf(item));
            String channelId = StringUtils.trimToEmpty(source.getString("channelId"));
            String streamType = StringUtils.defaultIfBlank(source.getString("streamType"), "main");
            String protocol = StringUtils.lowerCase(StringUtils.trimToEmpty(source.getString("protocol")));
            String url = StringUtils.trimToEmpty(source.getString("url"));
            boolean proxyStream = "rtsp".equals(protocol) || "rtmp".equals(protocol);
            if (StringUtils.isAnyBlank(channelId, url)
                    || !(proxyStream || VlStreamPlaybackUtils.isCameraRtc(protocol, url))) continue;
            if (!keys.add(channelId + "\n" + streamType)) continue;

            VlStreamDeviceStream stream = streamMapper.selectByKey(deviceRowId, channelId, streamType);
            if (stream == null) {
                stream = new VlStreamDeviceStream();
                stream.setDeviceRowId(deviceRowId);
                stream.setChannelId(channelId);
                stream.setStreamType(streamType);
                stream.setCreateTime(now);
            }
            stream.setStreamName(source.getString("name"));
            stream.setProtocol(protocol);
            stream.setSourceUrl(url);
            boolean requestedDefault = Boolean.TRUE.equals(source.getBoolean("default"));
            stream.setDefaultStream(requestedDefault && !defaultAssigned);
            defaultAssigned = defaultAssigned || requestedDefault;
            Boolean available = source.getBoolean("available");
            stream.setAvailable(available == null || available);
            stream.setLastReportTime(now);
            stream.setUpdateTime(now);
            if (stream.getId() == null) streamMapper.insert(stream); else streamMapper.update(stream);
        }
    }

    private Date parseDate(String value, Date fallback) {
        try { return Date.from(Instant.parse(value)); } catch (Exception ignored) { return fallback; }
    }

    private String json(Object value) { return value == null ? null : JSON.toJSONString(value); }
}
