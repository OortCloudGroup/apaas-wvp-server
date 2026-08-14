package com.ruoyi.wvp.media.zlm;

import com.ruoyi.wvp.media.bean.MediaServer;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class ZLMRESTfulUtilsTest {

    @Test
    public void buildApiUrlUsesConfiguredHttpPort() {
        MediaServer mediaServer = new MediaServer();
        mediaServer.setIp("127.0.0.1");
        mediaServer.setHttpPort(8090);

        assertEquals("http://127.0.0.1:8090/index/api/getServerConfig",
                ZLMRESTfulUtils.buildApiUrl(mediaServer, "getServerConfig"));
    }
}
