package com.silverfox.finance.service;

import java.util.List;

import com.silverfox.finance.domain.Channel;
import com.silverfox.finance.domain.ChannelVisitLog;

public interface ChannelService {
	public int count(String channelName, Integer category);
	public List<Channel> list(String channelName, int category, String beginTime, String endTime, int offset, int size);
	public List<Channel> listForUsed();
	public List<Channel> queryForChannellist(String channelName, int catgegory, int offset, int size);
	public Channel get(int id);
	public List<ChannelVisitLog> getVisit(int channelId);
	public boolean saveChannel(Channel channel);
	public List<Channel> checkChannelName(int id, String channelName);
}