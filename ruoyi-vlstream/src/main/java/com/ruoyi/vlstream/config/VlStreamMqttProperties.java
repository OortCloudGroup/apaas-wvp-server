package com.ruoyi.vlstream.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "vlstream.mqtt")
public class VlStreamMqttProperties {
    private String host = "127.0.0.1";
    private int port = 1883;
    private String username;
    private String password;
    private String clientId = "wvp-vlstream-backend";
    private int qos = 1;
    private int keepAliveSeconds = 60;
    private int connectionTimeoutSeconds = 10;

    public String getHost() { return host; }
    public void setHost(String host) { this.host = host; }
    public int getPort() { return port; }
    public void setPort(int port) { this.port = port; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }
    public int getQos() { return qos; }
    public void setQos(int qos) { this.qos = qos; }
    public int getKeepAliveSeconds() { return keepAliveSeconds; }
    public void setKeepAliveSeconds(int keepAliveSeconds) { this.keepAliveSeconds = keepAliveSeconds; }
    public int getConnectionTimeoutSeconds() { return connectionTimeoutSeconds; }
    public void setConnectionTimeoutSeconds(int connectionTimeoutSeconds) { this.connectionTimeoutSeconds = connectionTimeoutSeconds; }
}
