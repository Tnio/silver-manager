package com.silverfox.finance.orm;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.DispatchingCouponRule;

public interface DispatchingCouponRuleDao {
	List<DispatchingCouponRule> selectAll();
	DispatchingCouponRule selectById(int id);
	int enable(@Param("id")int id, @Param("status")int status);
	int update(DispatchingCouponRule dispatchingCouponRule);
}
