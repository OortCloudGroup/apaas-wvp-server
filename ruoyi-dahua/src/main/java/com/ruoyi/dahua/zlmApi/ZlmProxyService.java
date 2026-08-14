package com.ruoyi.dahua.zlmApi;

import com.aizuda.zlm4j.callback.IMKProxyPlayerCallBack;
import com.aizuda.zlm4j.core.ZLMApi;
import com.aizuda.zlm4j.structure.*;
import com.ruoyi.common.config.ZlmApiProperties;
import com.sun.jna.Native;
import com.sun.jna.Pointer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import static com.ruoyi.common.service.ZlmService.ZLM_API;

@Service
@org.springframework.boot.autoconfigure.condition.ConditionalOnProperty(prefix = "dahua", name = "enabled", havingValue = "true")
public class ZlmProxyService {

    @Autowired
    private ZlmApiProperties zlmApiProperties;


    private final Map<String, MK_PROXY_PLAYER> activeProxies = new ConcurrentHashMap<>();

    private final Map<String, Map<String, String>> proxyPlayUrls = new ConcurrentHashMap<>();


    /**
     * 启动 RTSP 代理
     * @param proxyId 自定义唯一ID，用于后续控制
     * @param srcRtspUrl 源地址
     * @param app 应用名
     * @param stream 流名
     */
    public Map<String, String> startProxy(String proxyId, String srcRtspUrl, String app, String stream) {
        if (activeProxies.containsKey(proxyId)) {
            throw new RuntimeException("Proxy already exists: " + proxyId);
        }

        MK_INI option = ZLM_API.mk_ini_create();
        configIni(option);
        MK_PROXY_PLAYER proxy = ZLM_API.mk_proxy_player_create4("__defaultVhost__", app, stream, option, 3);
        ZLM_API.mk_ini_release(option);
        ZLM_API.mk_proxy_player_set_option(proxy, "rtp_type", "1");
        ZLM_API.mk_proxy_player_set_option(proxy, "protocol_timeout_ms", "2000");
        setupCallbacks(proxy, app, stream, proxyId);
        ZLM_API.mk_proxy_player_play(proxy, srcRtspUrl);
        activeProxies.put(proxyId, proxy);
        System.out.println("▶ 代理已启动: " + proxyId);
        return printPlayUrls(app, stream);
    }

    /**
     * 停止指定代理
     */
    public void stopProxy(String proxyId) {
        MK_PROXY_PLAYER proxy = activeProxies.remove(proxyId);
        if (proxy != null) {
            ZLM_API.mk_proxy_player_release(proxy);
            System.out.println("⏹️ 代理已停止: " + proxyId);
        } else {
            System.out.println("⚠️ 代理不存在: " + proxyId);
        }
    }

    /**
     * 列出所有代理
     */
    public java.util.List<String> listProxies() {
        return new java.util.ArrayList<>(activeProxies.keySet());
    }

    // 配置 INI
    private void configIni(MK_INI option) {
        ZLM_API.mk_ini_set_option_int(option, "enable_mp4", 0);
        ZLM_API.mk_ini_set_option_int(option, "enable_audio", 0);
        ZLM_API.mk_ini_set_option_int(option, "enable_fmp4", 1);
        ZLM_API.mk_ini_set_option_int(option, "enable_ts", 1);
        ZLM_API.mk_ini_set_option_int(option, "enable_hls", 1);
        ZLM_API.mk_ini_set_option_int(option, "enable_rtsp", 1);
        ZLM_API.mk_ini_set_option_int(option, "enable_rtmp", 1);
        ZLM_API.mk_ini_set_option_int(option, "add_mute_audio", 0);
        ZLM_API.mk_ini_set_option_int(option, "auto_close", 0);
    }

    // 设置回调
    private void setupCallbacks(MK_PROXY_PLAYER proxy, String app, String stream, String id) {
        IMKProxyPlayerCallBack onPlayResult = (pUser, err, what, sys_err) -> {
            if (err == 0) {
                System.out.println("✅ 代理播放成功: " + app + "/" + stream);
            } else {
                System.out.println("❌ 代理播放失败: " + what + " (错误码: " + sys_err + ")");
                throw new RuntimeException("代理播放失败");
            }
        };
        ZLM_API.mk_proxy_player_set_on_play_result(proxy, onPlayResult, proxy.getPointer(), null);

        // 关闭回调
        IMKProxyPlayerCallBack onClose = (pUser, err, what, sys_err) -> {
            String proxyId = findProxyIdByPointer(pUser);
            if (proxyId != null) {
                activeProxies.remove(proxyId);
            }
            System.out.println("🔌 代理流关闭: " + what);
        };
        ZLM_API.mk_proxy_player_set_on_close(proxy, onClose, proxy.getPointer());
    }

    // 打印播放地址
    private Map<String, String> printPlayUrls(String app, String stream) {
        System.out.println("🎬 播放地址：");
        System.out.println("  RTSP: rtsp://192.168.2.199:" + zlmApiProperties.getDhRtspPort() + "/" + app + "/" + stream);
        System.out.println("  RTMP: rtmp://192.168.2.199:" + zlmApiProperties.getDhRtmpPort() + "/" + app + "/" + stream);
        System.out.println("  FLV:  http://192.168.2.199:" + zlmApiProperties.getDhHttpPort() + "/" + app + "/" + stream + ".flv");
        System.out.println("  HLS:  http://192.168.2.199:" + zlmApiProperties.getDhHttpPort() + "/" + app + "/" + stream + "/hls.m3u8");
        Map<String, String> urls = new HashMap<>();
        urls.put("rtsp", "rtsp://192.168.2.199:" + zlmApiProperties.getDhRtspPort() + "/" + app + "/" + stream);
        urls.put("rtmp", "rtmp://192.168.2.199:" + zlmApiProperties.getDhRtmpPort() + "/" + app + "/" + stream);
        urls.put("flv", "http://192.168.2.199:" + zlmApiProperties.getDhHttpPort() + "/" + app + "/" + stream + ".flv");
        urls.put("hls", "http://192.168.2.199:" + zlmApiProperties.getDhHttpPort() + "/" + app + "/" + stream + "/hls.m3u8");
        return urls;
    }

    // 根据 Pointer 反查 proxyId（用于 onClose 回调）
    private String findProxyIdByPointer(Pointer pUser) {
        for (Map.Entry<String, MK_PROXY_PLAYER> entry : activeProxies.entrySet()) {
            if (entry.getValue().getPointer().equals(pUser)) {
                return entry.getKey();
            }
        }
        return null;
    }
}
