package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.AbnormalOrder;

public interface AbnormalOrderDao {

	int queryForCount(Map<String, Object> param);

	List<AbnormalOrder> queryForOrderList(Map<String, Object> param);

	int queryForSum(Map<String, Object> param);

}
