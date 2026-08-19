package com.ruoyi.custom.mapper;

import com.ruoyi.custom.domain.CustomDevice;
import com.ruoyi.custom.domain.CustomRecordingPlan;
import com.ruoyi.custom.domain.CustomRecordingSession;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CustomDeviceMapper {
    List<CustomDevice> selectDeviceList(CustomDevice query);
    CustomDevice selectDeviceById(Long id);
    int countByDeviceCode(@Param("deviceCode") String deviceCode, @Param("excludeId") Long excludeId);
    int insertDevice(CustomDevice device);
    int updateDevice(CustomDevice device);
    int deleteDevices(Long[] ids);

    CustomRecordingPlan selectPlanByDeviceId(Long deviceId);
    List<CustomRecordingPlan> selectEnabledPlans();
    int insertPlan(CustomRecordingPlan plan);
    int updatePlan(CustomRecordingPlan plan);
    int deletePlansByDeviceIds(Long[] ids);

    CustomRecordingSession selectActiveSession(Long deviceId);
    int insertSession(CustomRecordingSession session);
    int stopSession(@Param("id") Long id, @Param("stopReason") String stopReason);
}
