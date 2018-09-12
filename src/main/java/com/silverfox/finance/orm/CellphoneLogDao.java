package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.CellphoneLog;

public interface CellphoneLogDao {
	List<CellphoneLog> queryForList(Map<String, Object> params);
	CellphoneLog selectById(@Param("id")int id);
	CellphoneLog selectHandlingLog(@Param("cellphone")String cellphone);
	CellphoneLog selectNewCellphone(@Param("cellphone")String cellphone);
	int queryForCount(Map<String, Object> params);
	int insert(CellphoneLog cellphoneLog);
	int update(CellphoneLog cellphoneLog);
	
}