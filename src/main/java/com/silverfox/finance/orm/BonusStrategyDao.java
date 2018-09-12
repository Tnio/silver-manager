package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.BonusStrategy;


public interface BonusStrategyDao {
	public List<BonusStrategy> queryForList(Map<String, Object> params);
	public int insert(BonusStrategy rebateStrategy);
	public int delete(int bonusId);
}
