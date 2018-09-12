package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.CustomerBalanceLog;

public interface CustomerBalanceLogDao {

	int queryForCount(Map<String, Object> params);

	List<CustomerBalanceLog> queryForList(Map<String, Object> params);

	List<Map<String, Object>> queryForSum(Map<String, Object> params);
	int queryForUserCount(Map<String, Object> params);
	List<CustomerBalanceLog> queryForUserList(Map<String, Object> params);
}
