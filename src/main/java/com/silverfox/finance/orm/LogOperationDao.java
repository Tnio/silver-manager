package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;


import com.silverfox.finance.domain.LogOperation;

public interface LogOperationDao {
	public List<LogOperation> queryForList(Map<String, Object> params);
	public int queryForCount(Map<String, Object> params);
	public int insert(LogOperation logOperation);
}
