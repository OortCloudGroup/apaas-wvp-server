package com.ruoyi.vlstream.service;

import com.ruoyi.vlstream.config.VlStreamFirmwareProperties;
import com.ruoyi.vlstream.domain.VlStreamDevice;
import com.ruoyi.vlstream.domain.VlStreamFirmware;
import com.ruoyi.vlstream.mapper.VlStreamDeviceMapper;
import com.ruoyi.vlstream.mqtt.VlStreamMqttBus;
import org.junit.Before;
import org.junit.Test;

import java.util.Map;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class VlStreamFirmwareDeploymentServiceTest {
    private VlStreamDeviceMapper deviceMapper;
    private VlStreamFirmwareService firmwareService;
    private VlStreamFirmwareTaskService taskService;
    private VlStreamFirmwareDeploymentService service;

    @Before
    public void setUp() {
        deviceMapper = mock(VlStreamDeviceMapper.class);
        firmwareService = mock(VlStreamFirmwareService.class);
        taskService = mock(VlStreamFirmwareTaskService.class);
        service = new VlStreamFirmwareDeploymentService(deviceMapper, firmwareService, taskService,
                mock(VlStreamMqttBus.class), new VlStreamFirmwareProperties());
    }

    @Test
    public void newerFirmwareIsShownButOfflineDeviceExplainsWhyDeploymentIsBlocked() {
        VlStreamDevice device = new VlStreamDevice();
        device.setId(10L);
        device.setDeviceModel("OORT-6600-2.5");
        device.setFirmwareVersion("1.0.1.20");
        device.setOnline(false);
        VlStreamFirmware firmware = new VlStreamFirmware();
        firmware.setId(20L);
        firmware.setFirmwareVersion("1.0.1.21");
        firmware.setOriginalFileName("rootfs-1.0.1.21.ota");
        firmware.setFileSize(1024L);
        firmware.setSha256("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        when(deviceMapper.selectById(10L)).thenReturn(device);
        when(firmwareService.latestReady("OORT-6600-2.5")).thenReturn(firmware);

        Map<String, Object> detail = service.detail(10L);

        assertTrue((Boolean) detail.get("hasNewFirmware"));
        assertFalse((Boolean) detail.get("canUpgrade"));
        assertEquals("设备离线，无法下发 OTA 指令", detail.get("upgradeBlockedReason"));
    }
}
