package com.ruoyi.vlstream.service;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.vlstream.config.VlStreamFirmwareProperties;
import com.ruoyi.vlstream.domain.VlStreamFirmware;
import com.ruoyi.vlstream.domain.dto.FirmwareUploadRequest;
import com.ruoyi.vlstream.mapper.VlStreamFirmwareMapper;
import org.junit.Before;
import org.junit.Test;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class VlStreamFirmwareServiceTest {
    private VlStreamFirmwareMapper mapper;
    private VlStreamFirmwareStorage storage;
    private VlStreamFirmwareService service;

    @Before
    public void setUp() {
        mapper = mock(VlStreamFirmwareMapper.class);
        storage = mock(VlStreamFirmwareStorage.class);
        service = new VlStreamFirmwareService(mapper, storage, new VlStreamFirmwareProperties());
    }

    @Test(expected = ServiceException.class)
    public void uploadGrantDoesNotLeaveRecordWhenStorageInitializationFails() {
        FirmwareUploadRequest request = new FirmwareUploadRequest();
        request.setCameraModel("OORT-6600-2.5");
        request.setFirmwareVersion("1.0.1.21");
        request.setFileName("rootfs-1.0.1.21.ota");
        request.setFileSize(1024L);
        when(storage.presignedPut(anyString(), anyInt())).thenThrow(new ServiceException("bucket unavailable"));

        try {
            service.issueUpload(request);
        } finally {
            verify(mapper, never()).insert(any(VlStreamFirmware.class));
        }
    }

    @Test
    public void removeDeletesDatabaseRecordWhenObjectIsAlreadyAbsent() {
        VlStreamFirmware firmware = new VlStreamFirmware();
        firmware.setId(1L);
        firmware.setObjectKey("rootfs/OORT-6600-2.5/1.0.1.21/file.ota");
        when(mapper.selectById(1L)).thenReturn(firmware);
        when(mapper.deleteById(1L)).thenReturn(1);

        service.remove(1L);

        verify(storage).deleteIfExists(firmware.getObjectKey());
        verify(mapper).deleteById(1L);
    }
}
