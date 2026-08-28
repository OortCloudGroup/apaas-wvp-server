package com.ruoyi.vlstream.controller;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.vlstream.domain.VlStreamDevice;
import com.ruoyi.vlstream.domain.VlStreamDeviceStream;
import com.ruoyi.vlstream.mapper.VlStreamDeviceMapper;
import com.ruoyi.vlstream.mapper.VlStreamDeviceStreamMapper;
import com.ruoyi.vlstream.service.VlStreamFirmwareDeploymentService;
import com.ruoyi.wvp.media.service.IMediaServerService;
import org.junit.Test;

import java.util.Map;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class VlStreamDeviceControllerTest {
    @Test
    public void returnsCameraRtcUrlWithoutCreatingZlmProxy() {
        VlStreamDeviceMapper deviceMapper = mock(VlStreamDeviceMapper.class);
        VlStreamDeviceStreamMapper streamMapper = mock(VlStreamDeviceStreamMapper.class);
        IMediaServerService mediaServerService = mock(IMediaServerService.class);
        VlStreamDevice device = new VlStreamDevice();
        device.setId(10L);
        VlStreamDeviceStream stream = new VlStreamDeviceStream();
        stream.setId(20L);
        stream.setDeviceRowId(10L);
        stream.setProtocol("http");
        stream.setSourceUrl("http://146.56.220.167:8082/videocall/AETY-00-XOKU-L1A2-00000002");
        stream.setAvailable(true);
        when(deviceMapper.selectById(10L)).thenReturn(device);
        when(streamMapper.selectById(20L)).thenReturn(stream);
        VlStreamDeviceController controller = new VlStreamDeviceController(deviceMapper, streamMapper,
                mediaServerService, mock(VlStreamFirmwareDeploymentService.class));
        VlStreamDeviceController.PreviewRequest request = new VlStreamDeviceController.PreviewRequest();
        request.setStreamId(20L);

        AjaxResult result = controller.preview(10L, request);

        assertEquals(200, result.get(AjaxResult.CODE_TAG));
        Map<?, ?> data = (Map<?, ?>) result.get(AjaxResult.DATA_TAG);
        assertEquals("cameraRTC", data.get("playMode"));
        assertEquals(stream.getSourceUrl(), data.get("url"));
        verify(mediaServerService, never()).getDefaultMediaServer();
    }
}
