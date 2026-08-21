package com.ruoyi.vlstream.service;

import com.ruoyi.vlstream.config.VlStreamFirmwareProperties;
import com.ruoyi.vlstream.domain.VlStreamFirmwareTask;
import com.ruoyi.vlstream.mapper.VlStreamFirmwareTaskMapper;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class VlStreamFirmwareTaskServiceTest {
    private VlStreamFirmwareTaskMapper mapper;
    private VlStreamFirmwareTaskService service;
    private VlStreamFirmwareTask task;

    @Before
    public void setUp() {
        mapper = mock(VlStreamFirmwareTaskMapper.class);
        service = new VlStreamFirmwareTaskService(mapper, new VlStreamFirmwareProperties());
        task = new VlStreamFirmwareTask();
        task.setId(1L); task.setDeviceRowId(10L); task.setRequestId("request-1"); task.setDeployStatus("INSTALLING");
    }

    @Test
    public void cancelReleasesOnlyPlatformTaskLock() {
        when(mapper.selectByRequestId("request-1")).thenReturn(task, cancelled());
        when(mapper.cancelActive(eq(10L), eq("request-1"), any(), any())).thenReturn(1);
        VlStreamFirmwareTask result = service.cancel(10L, "request-1");
        assertNotNull(result);
        verify(mapper).cancelActive(eq(10L), eq("request-1"), any(),
                eq("管理员终止任务；仅解除平台任务锁，未向设备发送取消指令"));
    }

    @Test
    public void lateReplyCannotResurrectCancelledTask() {
        task.setDeployStatus("CANCELLED");
        assertFalse(service.applyReply(task, "SUCCESS", null, "{}"));
        verify(mapper, never()).updateReply(anyLong(), any(), any(), any(), any(), any());
    }

    @Test
    public void expiryCoversDownloadAndExecutionStages() {
        when(mapper.expireDownloadTasks(anyLong(), any())).thenReturn(1);
        when(mapper.expireExecutionTasks(any(), any())).thenReturn(1);
        service.expireStaleTasks();
        verify(mapper).expireDownloadTasks(anyLong(), any());
        verify(mapper).expireExecutionTasks(any(), any());
    }

    private VlStreamFirmwareTask cancelled() {
        VlStreamFirmwareTask value = new VlStreamFirmwareTask();
        value.setDeployStatus("CANCELLED");
        return value;
    }
}
