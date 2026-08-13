package com.ruoyi.vlstream.mapper;

import com.ruoyi.vlstream.domain.VlStreamDeviceStream;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.Date;
import java.util.List;

@Mapper
public interface VlStreamDeviceStreamMapper {
    VlStreamDeviceStream selectById(Long id);
    VlStreamDeviceStream selectByKey(@Param("deviceRowId") Long deviceRowId,
                                     @Param("channelId") String channelId,
                                     @Param("streamType") String streamType);
    List<VlStreamDeviceStream> selectAvailableByDeviceId(Long deviceRowId);
    int markUnavailable(@Param("deviceRowId") Long deviceRowId, @Param("updateTime") Date updateTime);
    int insert(VlStreamDeviceStream stream);
    int update(VlStreamDeviceStream stream);
}
