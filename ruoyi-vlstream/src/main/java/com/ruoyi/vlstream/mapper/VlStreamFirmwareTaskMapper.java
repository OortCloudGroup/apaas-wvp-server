package com.ruoyi.vlstream.mapper;

import com.ruoyi.vlstream.domain.VlStreamFirmwareTask;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.Date;

@Mapper
public interface VlStreamFirmwareTaskMapper {
    VlStreamFirmwareTask selectByRequestId(String requestId);
    VlStreamFirmwareTask selectByMessageId(String mqttMessageId);
    VlStreamFirmwareTask selectLatestByDevice(Long deviceRowId);
    int countActive(@Param("deviceRowId") Long deviceRowId, @Param("target") String target);
    int insert(VlStreamFirmwareTask task);
    int markPublished(@Param("id") Long id, @Param("publishedAt") Date publishedAt);
    int markPublishFailed(@Param("id") Long id, @Param("failureReason") String failureReason,
                          @Param("completedAt") Date completedAt);
    int updateReply(@Param("id") Long id, @Param("deployStatus") String deployStatus,
                    @Param("lastReplyAt") Date lastReplyAt, @Param("completedAt") Date completedAt,
                    @Param("failureReason") String failureReason, @Param("replyPayload") String replyPayload);
    int cancelActive(@Param("deviceRowId") Long deviceRowId, @Param("requestId") String requestId,
                     @Param("completedAt") Date completedAt, @Param("failureReason") String failureReason);
    int expireDownloadTasks(@Param("nowEpoch") long nowEpoch, @Param("now") Date now);
    int expireExecutionTasks(@Param("deadline") Date deadline, @Param("now") Date now);
}
