package com.ruoyi.vlstream.mqtt;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.vlstream.config.VlStreamMqttProperties;
import com.ruoyi.vlstream.service.VlStreamDeviceStateService;
import com.ruoyi.vlstream.service.VlStreamFirmwareReplyHandler;
import com.ruoyi.common.exception.ServiceException;
import org.apache.commons.lang3.StringUtils;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.PreDestroy;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Component
public class VlStreamMqttBus {
    private static final Logger log = LoggerFactory.getLogger(VlStreamMqttBus.class);
    private final VlStreamMqttProperties properties;
    private final VlStreamDeviceStateService stateService;
    private final VlStreamFirmwareReplyHandler firmwareReplyHandler;
    private final ExecutorService executor = Executors.newSingleThreadExecutor(r -> new Thread(r, "wvp-vlstream-mqtt"));
    private volatile MqttClient client;

    public VlStreamMqttBus(VlStreamMqttProperties properties, VlStreamDeviceStateService stateService,
                           VlStreamFirmwareReplyHandler firmwareReplyHandler) {
        this.properties = properties;
        this.stateService = stateService;
        this.firmwareReplyHandler = firmwareReplyHandler;
    }

    @Scheduled(initialDelay = 1000L, fixedDelay = 10000L)
    public void ensureConnected() {
        if (!properties.isEnabled()) return;
        if (client != null && client.isConnected()) return;
        synchronized (this) {
            if (client != null && client.isConnected()) return;
            try {
                closeClient();
                // VLS and WVP may subscribe to the same ordinary topic, but they must use different client IDs.
                String clientId = StringUtils.defaultIfBlank(properties.getClientId(), "wvp-vlstream-backend");
                client = new MqttClient("tcp://" + properties.getHost() + ":" + properties.getPort(), clientId, new MemoryPersistence());
                client.setCallback(callback());
                client.connect(connectOptions());
                subscribe(client);
                log.info("VLStream MQTT connected: clientId={}, topic={}", clientId, VlStreamProtocol.TOPIC_FILTER);
            } catch (Exception ex) {
                log.warn("VLStream MQTT connect failed, retry in 10 seconds: {}", ex.getMessage());
                closeClient();
            }
        }
    }

    private MqttCallbackExtended callback() {
        return new MqttCallbackExtended() {
            @Override public void connectComplete(boolean reconnect, String serverURI) {
                if (reconnect && client != null) try { subscribe(client); } catch (Exception ex) { log.warn("VLStream MQTT resubscribe failed: {}", ex.getMessage()); }
            }
            @Override public void connectionLost(Throwable cause) { log.warn("VLStream MQTT connection lost: {}", cause == null ? "unknown" : cause.getMessage()); }
            @Override public void messageArrived(String topic, MqttMessage message) {
                String payload = new String(message.getPayload(), StandardCharsets.UTF_8);
                executor.submit(() -> handle(topic, payload));
            }
            @Override public void deliveryComplete(IMqttDeliveryToken token) { }
        };
    }

    void handle(String topic, String raw) {
        JSONObject source;
        try { source = JSON.parseObject(raw); }
        catch (Exception ex) { log.warn("Ignoring invalid VLStream MQTT JSON"); return; }
        if (!VlStreamProtocol.VERSION.equals(source.getString("protocolVersion"))
                || !VlStreamProtocol.DEVICE_TO_PLATFORM.equals(source.getString("msgDir"))) return;
        String deviceId = source.getString("deviceId");
        if (StringUtils.isBlank(deviceId) || !VlStreamProtocol.topic(deviceId).equals(topic)) {
            publishReply(topic, VlStreamProtocol.reply(source, 400, "Topic与deviceId不一致"));
            return;
        }
        JSONObject reply;
        try {
            reply = dispatchBusinessMessage(source);
        } catch (RuntimeException ex) {
            log.error("VLStream MQTT handling failed: deviceId={}, messageId={}, reason={}",
                    deviceId, source.getString("messageId"), ex.getMessage(), ex);
            reply = VlStreamProtocol.reply(source, 500, "平台处理失败");
        }
        publishReply(topic, reply);
    }

    JSONObject dispatchBusinessMessage(JSONObject source) {
        if (VlStreamProtocol.isDeviceState(source)) {
            return stateService.handle(source);
        }
        if (VlStreamProtocol.isFirmwareReply(source)) {
            firmwareReplyHandler.handle(source);
            return null;
        }
        log.debug("Ignoring VLStream MQTT business owned by another consumer: mainBizType={}, subBizType={}",
                source.getString("mainBizType"), source.getString("subBizType"));
        return null;
    }

    public void publish(String topic, JSONObject payload) {
        try {
            MqttClient current = client;
            if (current == null || !current.isConnected()) {
                throw new MqttException(MqttException.REASON_CODE_CLIENT_NOT_CONNECTED);
            }
            MqttMessage message = new MqttMessage(payload.toJSONString().getBytes(StandardCharsets.UTF_8));
            message.setQos(qos());
            message.setRetained(false);
            current.publish(topic, message);
        } catch (Exception ex) {
            throw new ServiceException("VLStream MQTT 固件指令发布失败：" + ex.getMessage());
        }
    }

    private void publishReply(String topic, JSONObject reply) {
        if (reply == null) return;
        try {
            MqttClient current = client;
            if (current == null || !current.isConnected()) throw new MqttException(MqttException.REASON_CODE_CLIENT_NOT_CONNECTED);
            MqttMessage message = new MqttMessage(reply.toJSONString().getBytes(StandardCharsets.UTF_8));
            message.setQos(qos());
            message.setRetained(false);
            current.publish(topic, message);
        } catch (Exception ex) {
            log.error("VLStream MQTT business reply failed: deviceId={}, sourceMsgId={}, reason={}",
                    reply.getString("deviceId"), reply.getJSONObject("payload").getString("sourceMsgId"), ex.getMessage());
        }
    }

    MqttConnectOptions connectOptions() {
        MqttConnectOptions options = new MqttConnectOptions();
        // The @Scheduled task is the single reconnect owner. Combining it with
        // Paho automatic reconnect creates competing clients with the same ID.
        options.setAutomaticReconnect(false);
        options.setCleanSession(false);
        options.setConnectionTimeout(Math.max(1, properties.getConnectionTimeoutSeconds()));
        options.setKeepAliveInterval(Math.max(5, properties.getKeepAliveSeconds()));
        if (StringUtils.isNotBlank(properties.getUsername())) options.setUserName(properties.getUsername());
        if (properties.getPassword() != null) options.setPassword(properties.getPassword().toCharArray());
        return options;
    }

    private void subscribe(MqttClient mqttClient) throws MqttException { mqttClient.subscribe(VlStreamProtocol.TOPIC_FILTER, qos()); }
    private int qos() { return 1; }

    @PreDestroy
    public void destroy() { closeClient(); executor.shutdownNow(); }

    private void closeClient() {
        MqttClient current = client; client = null;
        if (current == null) return;
        try { if (current.isConnected()) current.disconnectForcibly(500L, 500L); } catch (Exception ignored) { }
        try { current.close(); } catch (Exception ignored) { }
    }
}
