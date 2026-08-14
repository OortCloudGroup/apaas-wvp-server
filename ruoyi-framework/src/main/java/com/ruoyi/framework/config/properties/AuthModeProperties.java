package com.ruoyi.framework.config.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * WVP 登录鉴权模式配置。
 */
@Component
@ConfigurationProperties(prefix = "wvp.auth")
public class AuthModeProperties
{
    public enum Mode
    {
        SSO,
        LOCAL
    }

    /**
     * 默认保持现有 SSO 模式，避免未配置环境变量时改变部署行为。
     */
    private Mode mode = Mode.SSO;

    public Mode getMode()
    {
        return mode;
    }

    public void setMode(Mode mode)
    {
        this.mode = mode;
    }

    public boolean isLocal()
    {
        return Mode.LOCAL == mode;
    }

    public String getModeValue()
    {
        return mode.name().toLowerCase();
    }
}
