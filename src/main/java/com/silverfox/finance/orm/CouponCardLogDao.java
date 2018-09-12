package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.CouponCardLog;

public interface CouponCardLogDao {
	int queryForCount(Map<String, Object> params);
	List<CouponCardLog> queryForList(Map<String, Object> params);
	int insertCouponCardLogs(@Param("couponCardLogs")List<CouponCardLog> couponCardLogs) throws Exception;
	int queryForRecordCount(Map<String, Object> params);
	List<CouponCardLog> queryForRecordList(Map<String, Object> params);
	CouponCardLog selectById(int id);
	int update(CouponCardLog couponCardLog);

	
	
	
	

}
