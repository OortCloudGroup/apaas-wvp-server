package com.ruoyi.vlstream.controller;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.vlstream.domain.VlStreamDevice;
import com.ruoyi.vlstream.domain.dto.VlStreamInternalDeviceView;
import com.ruoyi.vlstream.mapper.VlStreamDeviceMapper;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class VlStreamInternalDeviceControllerTest {

    @Test
    public void returnsRegisteredOfflineDevice() {
        VlStreamDeviceMapper mapper = mock(VlStreamDeviceMapper.class);
        VlStreamDevice device = new VlStreamDevice();
        device.setId(7L);
        device.setDeviceId("CAM-1");
        device.setDeviceName("WVP Camera");
        device.setOnline(false);
        when(mapper.selectByDeviceId("CAM-1")).thenReturn(device);

        AjaxResult result = new VlStreamInternalDeviceController(mapper).get("CAM-1");

        assertEquals(200, result.get(AjaxResult.CODE_TAG));
        VlStreamInternalDeviceView data = (VlStreamInternalDeviceView) result.get(AjaxResult.DATA_TAG);
        assertEquals("CAM-1", data.getDeviceId());
        assertFalse(data.getOnline());
    }

    @Test
    public void returnsNotFoundForUnknownDevice() {
        VlStreamDeviceMapper mapper = mock(VlStreamDeviceMapper.class);

        AjaxResult result = new VlStreamInternalDeviceController(mapper).get("UNKNOWN");

        assertEquals(404, result.get(AjaxResult.CODE_TAG));
    }
}
