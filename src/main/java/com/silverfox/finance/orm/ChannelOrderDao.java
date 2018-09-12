package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.ChannelOrder;

public interface ChannelOrderDao {

	int queryRequestNoForCount(Map<String, Object> params);

	List<ChannelOrder> queryForList(Map<String, Object> params);
	
}
