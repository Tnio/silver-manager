package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.DispatchingLog;

public interface DispatchingLogDao {
   
	int delete(@Param("dispatchingBonusLogId")int dispatchingBonusLogId);

	int insertDispatchingLogBatch(@Param("dispatchingBonusLogId")int dispatchingBonusLogId, @Param("dispatchingLogs")List<DispatchingLog> dispatchingLogs);

	List<DispatchingLog> queryForList(Map<String, Object> params);
	int queryForCount(Map<String, Object> params);
	List<Integer> countCellphones(Map<String, Object> params);
	List<DispatchingLog> listCellphones(Map<String, Object> params);
//	int save(DispatchingLog dispatchingLog);
}
