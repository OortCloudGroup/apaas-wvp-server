package com.ruoyi.vlstream.mapper;

import com.ruoyi.vlstream.domain.VlStreamFirmware;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface VlStreamFirmwareMapper {
    VlStreamFirmware selectById(Long id);
    VlStreamFirmware selectByModelAndVersion(@Param("cameraModel") String cameraModel,
                                             @Param("firmwareVersion") String firmwareVersion);
    List<VlStreamFirmware> selectReadyByModel(String cameraModel);
    List<VlStreamFirmware> selectPage(@Param("cameraModel") String cameraModel,
                                      @Param("firmwareVersion") String firmwareVersion,
                                      @Param("offset") long offset, @Param("limit") int limit);
    long count(@Param("cameraModel") String cameraModel, @Param("firmwareVersion") String firmwareVersion);
    int insert(VlStreamFirmware firmware);
    int markReady(@Param("id") Long id, @Param("sha256") String sha256);
    int deleteById(Long id);
}
