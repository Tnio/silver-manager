package com.silverfox.finance.orm;

import java.util.List;

import com.silverfox.finance.domain.CustomerMessage;

public interface CustomerMessageDao {
	//public List<CustomerMessage> queryForList(Map<String, Object> params);
	//public int queryForCount(Map<String, Object> params);
	public int insert(CustomerMessage message);
	public List<CustomerMessage> queryExpiredList();
	public int updateById(int id);
	//public int updateByAccount(String account);
}