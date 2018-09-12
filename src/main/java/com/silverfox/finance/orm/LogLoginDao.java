package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.LogLogin;

public interface LogLoginDao {
	public List<LogLogin> queryForList(Map<String, Object> params);
	public int queryForCount(Map<String, Object> params);
	public int insert(LogLogin logLogin);
	public int update(LogLogin logLogin);
}