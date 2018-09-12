package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;







import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.CustomerOrder;
import com.silverfox.finance.entity.EarningEntity;
import com.silverfox.finance.entity.EsignEntity;
import com.silverfox.finance.entity.LoanEntity;
import com.silverfox.finance.entity.OpexEntity;
import com.silverfox.finance.entity.PaybackCalenderEntity;
import com.silverfox.finance.entity.ReinvestEntity;

public interface CustomerOrderDao {
	Integer sumOrderInSomeday(String systemDate);
	ReinvestEntity selectReinvest(@Param("beginTime")String beginTime, @Param("endTime")String endTime);
	ReinvestEntity selectNotReinvest(@Param("beginTime")String beginTime, @Param("endTime")String endTime);
	List<EarningEntity> oldEarning(@Param("beginDate")String beginDate, @Param("endDate")String endDate);
	List<EarningEntity> newEarning(@Param("beginDate")String beginDate, @Param("endDate")String endDate);
	List<PaybackCalenderEntity> paybackCalender(@Param("type")int type, @Param("backChannel")int backChannel, @Param("beginDate")String beginDate, @Param("endDate")String endDate);
	List<OpexEntity> listOpex(Map<String, Object> params);
	int countOrderInSomeday(String systemDate);
	int countOpex(Map<String, Object> params);
	Map<String, Object> getOrderInfo(Map<String, Object> params);
	List<CustomerOrder> queryForList(Map<String, Object> params);
	int selectfreezingAmountByCustomerId(int id);
	List<CustomerOrder> queryByProductId(int productId);
	int queryTradeDetailCount(Map<String, Object> params);
	List<CustomerOrder> queryTradeDetailList(Map<String, Object> params);
	int queryForCount(Map<String, Object> params);
	List<Map<String, Object>> countOrderInSometime(String systemDate);
	List<Map<String, Object>> sumOrderInSometime(String systemDate);
	
	List<EsignEntity> queryOrderByProductId(@Param("productId")int productId);
	List<LoanEntity> queryLoanList(@Param("productId")Integer productId);
}
