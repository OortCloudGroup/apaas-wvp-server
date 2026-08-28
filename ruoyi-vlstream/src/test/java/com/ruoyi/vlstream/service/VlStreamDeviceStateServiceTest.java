package com.ruoyi.vlstream.service;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.vlstream.domain.VlStreamDevice;
import com.ruoyi.vlstream.domain.VlStreamDeviceStream;
import com.ruoyi.vlstream.mapper.VlStreamDeviceMapper;
import com.ruoyi.vlstream.mapper.VlStreamDeviceStreamMapper;
import com.ruoyi.vlstream.mapper.VlStreamMessageMapper;
import org.junit.Test;
import org.mockito.ArgumentCaptor;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class VlStreamDeviceStateServiceTest {
    @Test
    public void persistsReportedHttpCameraRtcStream() {
        VlStreamDeviceMapper deviceMapper = mock(VlStreamDeviceMapper.class);
        VlStreamDeviceStreamMapper streamMapper = mock(VlStreamDeviceStreamMapper.class);
        VlStreamMessageMapper messageMapper = mock(VlStreamMessageMapper.class);
        when(messageMapper.insertIgnore(eq("AETY-1"), eq("m1"), any(), any())).thenReturn(1);
        when(deviceMapper.insert(any())).thenAnswer(invocation -> {
            VlStreamDevice device = invocation.getArgument(0);
            device.setId(10L);
            return 1;
        });
        VlStreamDeviceStateService service = new VlStreamDeviceStateService(deviceMapper, streamMapper, messageMapper);
        JSONObject message = JSON.parseObject("{\"protocolVersion\":\"2.2\",\"messageId\":\"m1\","
                + "\"deviceId\":\"AETY-1\",\"sentAt\":\"2026-08-28T09:37:03Z\","
                + "\"payload\":{\"online\":true,\"streams\":[{\"channelId\":\"CH-1\","
                + "\"streamType\":\"main\",\"protocol\":\"http\","
                + "\"url\":\"http://146.56.220.167:8082/videocall/AETY-1\","
                + "\"default\":true,\"available\":true}]}}");

        service.handle(message);

        ArgumentCaptor<VlStreamDeviceStream> captor = ArgumentCaptor.forClass(VlStreamDeviceStream.class);
        verify(streamMapper).insert(captor.capture());
        assertEquals("http", captor.getValue().getProtocol());
        assertEquals("http://146.56.220.167:8082/videocall/AETY-1", captor.getValue().getSourceUrl());
    }
}
