package com.ruoyi.vlstream.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.Date;

@Mapper
public interface VlStreamMessageMapper {
    int insertIgnore(@Param("deviceId") String deviceId, @Param("messageId") String messageId,
                     @Param("reportedAt") Date reportedAt, @Param("receivedAt") Date receivedAt);
    int deleteBefore(Date deadline);
}
