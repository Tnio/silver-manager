package com.silverfox.finance.service.impl;

import static com.silverfox.finance.util.ConstantUtil.MAX_TIME;
import static com.silverfox.finance.util.ConstantUtil.MIN_TIME;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.silverfox.finance.domain.Channel;
import com.silverfox.finance.domain.ChannelVisitLog;
import com.silverfox.finance.orm.ChannelDao;
import com.silverfox.finance.service.ChannelService;
import com.silverfox.finance.util.LogRecord;

@Service
public class ChannelServiceImpl implements ChannelService{
	@Autowired
	private ChannelDao channelDao;

	@Override
	public int count(String channelName, Integer category) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(channelName)){
			params.put("channelName", channelName);
		}
		params.put("category", category);
		return channelDao.queryForCount(params);
	}

	@Override
	public List<Channel> list(String channelName, int category, String beginTime, String endTime, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(channelName)){
			params.put("channelName", channelName);
		}
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(beginTime)){
			params.put("beginTime", beginTime + MIN_TIME);
			params.put("endTime", endTime + MAX_TIME);
		}
		params.put("category", category);
		params.put("offset", offset);
		params.put("size", size);
		return channelDao.queryForList(params);
	}

	@Override
	public List<Channel> listForUsed() {
		return channelDao.queryUsedForList();
	}
	
	@Override
	public List<Channel> queryForChannellist(String channelName, int category, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(channelName)){
			params.put("channelName", channelName);
		}
		params.put("category", category);
		params.put("offset", offset);
		params.put("size", size);
		List<Channel> list = channelDao.queryForList(params);
		return list;
	}
	
	@Override
	public Channel get(int id) {
		return channelDao.selectById(id);
	}
	@Override
	public List<ChannelVisitLog> getVisit(int channelId) {
		return channelDao.selectByChannelId(channelId);
	}
	
	@Override
	@LogRecord(module=LogRecord.Module.CHANNEL, operation=LogRecord.Operation.CHANNELSAVE, id="", name="${channel.name}")
	public boolean saveChannel(Channel channel) {
		if(channel != null){
			//if(channel.getId() > 0){
			return channelDao.update(channel) > 0 ? true : false;
			/*}else{
				return channelDao.insert(channel) > 0 ? true : false;
			}*/
		}
		return false;
	}
	@Override
	public List<Channel> checkChannelName(int id, String channelName) {
		
		return channelDao.checkChannelName(id, channelName);
	}

	
	
	
	
	
	
	
	
}