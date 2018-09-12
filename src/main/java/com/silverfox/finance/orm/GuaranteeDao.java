package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Guarantee;

public interface GuaranteeDao {
	List<Guarantee> queryForList(Map<String, Object> params);
	int queryForCount(Map<String, Object> params);
	Guarantee selectById(int id);
	int insert(Guarantee guarantee);
	int update(Guarantee guarantee);
	int updateStatus(@Param("id")int id, @Param("status")int status);
	int duplicate(@Param("id")int id, @Param("name")String name);
}
