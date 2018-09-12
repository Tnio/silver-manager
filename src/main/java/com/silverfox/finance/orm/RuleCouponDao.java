package com.silverfox.finance.orm;

import java.util.List;

import com.silverfox.finance.domain.RuleCoupon;

public interface RuleCouponDao {
	public List<RuleCoupon> queryForList(int ruleId);
	public int delete(int ruleId);
	public int insert(RuleCoupon ruleCoupon);
}
