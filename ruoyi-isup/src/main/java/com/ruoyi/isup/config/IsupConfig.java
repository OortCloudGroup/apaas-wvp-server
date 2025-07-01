package com.ruoyi.isup.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/***
 * isup配置
 *
 * @author fengcheng
 */
@Configuration
@Data
public class IsupConfig {

    @Value("${isup.IP}")
    private String ip;

    @Value("${media.http-port}")
    private String zlmHttpPort;

    @Value("${isup.route}")
    private String route;

    @Value("${isup.cmsServer.Port}")
    private int cmsServerPort;

    @Value("${isup.smsServer.Port}")
    private int smsServerPort;

    @Value("${isup.smsServer.ListenIP}")
    private String smsServerListenIP;

    @Value("${isup.smsServer.ListenPort}")
    private int smsServerListenPort;

    @Value("${isup.isupKey}")
    private String isupKey;
}
