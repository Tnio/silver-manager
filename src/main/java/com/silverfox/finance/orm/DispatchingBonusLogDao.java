package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.DispatchingBonusLog;

public interface DispatchingBonusLogDao {

	int queryForCount(Map<String, Object> params);

	List<DispatchingBonusLog> queryForList(Map<String, Object> params);
	int update(DispatchingBonusLog dispatchingBonusLog);
	int insert(DispatchingBonusLog dispatchingBonusLog);
	DispatchingBonusLog selectById(int id);

	
	
	
	
}
