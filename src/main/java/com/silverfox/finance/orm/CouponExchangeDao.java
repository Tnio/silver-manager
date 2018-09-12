package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.CouponExchange;

public interface CouponExchangeDao {
	List<CouponExchange> queryForList(Map<String, Object> params);
	int queryForCount(Map<String, Object> params);
	int insert(CouponExchange couponExchange);
	int update(CouponExchange couponExchange);
	CouponExchange selectById(int id);

}
