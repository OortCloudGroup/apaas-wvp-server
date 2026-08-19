package com.ruoyi.custom.service;

import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class CustomMediaServiceTest {
    @Test
    public void acceptsOnlyStreamsThatNeedZlmProxy() {
        assertTrue(CustomMediaService.supportsZlmPreview("rtsp://camera/live"));
        assertTrue(CustomMediaService.supportsZlmPreview(" RTMP://camera/live "));
        assertFalse(CustomMediaService.supportsZlmPreview("http://camera/videocall/AETY-00-NJ"));
        assertFalse(CustomMediaService.supportsZlmPreview(null));
    }
}
