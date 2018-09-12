package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Channel;
import com.silverfox.finance.domain.ChannelVisitLog;

public interface ChannelDao {
	List<Channel> queryUsedForList();
	List<Channel> queryForList(Map<String, Object> params);
	int queryForCount(Map<String, Object> params);
	List<Channel> selectByChannelIds(@Param("ids")List<Channel> ids, @Param("beginTime")String beginTime, @Param("endTime")String endTime);
	Channel selectById(int  id);
	List<ChannelVisitLog>  selectByChannelId(@Param("channelId")int channelId);
	int update(Channel channel);
	List<Channel> checkChannelName(@Param("id") int id, @Param("channelName")String channelName);

	
	
	
	
	
	
	
	
	
	
	
}