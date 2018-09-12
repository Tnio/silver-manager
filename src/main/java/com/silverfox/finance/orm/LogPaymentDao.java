package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.LogPayment;

public interface LogPaymentDao {
	public List<LogPayment> queryForList(Map<String, Object> params);
	public int queryForCount(Map<String, Object> params);
	public int insert(LogPayment logPayment);
	public void insertBatch(@Param("logPayments") LogPayment[] logPayments);
}
