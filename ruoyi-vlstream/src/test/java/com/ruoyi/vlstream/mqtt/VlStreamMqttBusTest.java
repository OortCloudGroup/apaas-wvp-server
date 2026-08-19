package com.ruoyi.vlstream.mqtt;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.vlstream.config.VlStreamMqttProperties;
import com.ruoyi.vlstream.service.VlStreamDeviceStateService;
import org.junit.Test;

import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertSame;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

public class VlStreamMqttBusTest {
    @Test
    public void ignoresFirmwareReplyOwnedByAnotherConsumer() {
        VlStreamDeviceStateService stateService = mock(VlStreamDeviceStateService.class);
        VlStreamMqttBus bus = new VlStreamMqttBus(new VlStreamMqttProperties(), stateService);
        JSONObject message = message("firmwareDeploy");

        assertNull(bus.dispatchBusinessMessage(message));
        verifyNoInteractions(stateService);
    }

    @Test
    public void continuesHandlingDeviceState() {
        VlStreamDeviceStateService stateService = mock(VlStreamDeviceStateService.class);
        VlStreamMqttBus bus = new VlStreamMqttBus(new VlStreamMqttProperties(), stateService);
        JSONObject message = message("state");
        JSONObject reply = new JSONObject();
        when(stateService.handle(message)).thenReturn(reply);

        assertSame(reply, bus.dispatchBusinessMessage(message));
        verify(stateService).handle(message);
    }

    private JSONObject message(String subBizType) {
        JSONObject message = new JSONObject();
        message.put("protocolVersion", "2.2");
        message.put("msgDir", "dev2platform");
        message.put("mainBizType", "device");
        message.put("subBizType", subBizType);
        return message;
    }
}
