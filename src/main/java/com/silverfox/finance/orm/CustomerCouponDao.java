package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.CustomerCoupon;

public interface CustomerCouponDao {
//	public List<CustomerInviteCouponLog> selectInviteCouponByCellphone(Map<String, Object> params);
//	public int countInviteCouponByAccount(String account);
//	CustomerInviteCouponLog selectByOrderId(int orderId);
//	CustomerCoupon selectByAccountAndCouponId(@Param("account")String account, @Param("couponId")int couponId);
//	CustomerCoupon selectById(int customerCouponId);
//	List<CustomerCoupon> queryCustomerCouponsByAccount(@Param("account")String account, @Param("used")int used, @Param("offset")int offset, @Param("size")int size);
	//int countCouponLogByAccount(String account);
	//List<CustomerInviteCouponLog> queryCouponLogByAccount(Map<String, Object> params);
	int insertCustomerCoupon(CustomerCoupon customerCoupon);
//	int updateCustomerCoupon(CustomerCoupon customerCoupon);
//	public int insertCouponLog(CustomerInviteCouponLog couponLog);
//	int updateAmountByAccount(@Param("account")String account, @Param("amount")float amount);
//	public int consumeCoupons(@Param("customerCouponId")int customerCouponId, @Param("amount")double amount);
	List<CustomerCoupon> queryForListCustomerCoupons(Map<String, Object> params);
	int queryForCountCustomerCoupons(Map<String, Object> params);
	int insertCustomerCoupons(@Param("customerCoupons")List<CustomerCoupon> customerCoupons);
	//List<CustomerCoupon> queryForListCustomerCouponsByAccount(Map<String, Object> params);
	//List<CustomerCoupon> queryLatestCouponsByAccount(@Param("account")String account, @Param("publishDate")String publishDate);
	int queryForCountCouponExchange(Map<String, Object> params);
	List<CustomerCoupon> queryForListCouponExchange(Map<String, Object> params);
	List<CustomerCoupon> selectByDispatchingBonusLogId(Map<String, Object> params);
	int countByDispatchingBonusLogId(Map<String, Object> params);
	
	public int countCouponActivityRecord(Map<String, Object> params);
	public List<CustomerCoupon> selectCouponActivityRecord(Map<String, Object> params);
	public int countCouponsByCustomerId(@Param("customerId")int customerId, @Param("status")int status);
	public List<CustomerCoupon> queryCouponsByCustomerId(Map<String, Object> params);
	int queryForCountCustomerCouponsByUserId(Map<String, Object> params);
	CustomerCoupon selectByUserId(@Param("userId")int userId);

	public void updateInviteCouponCellphone(@Param("newCellphone")String newCellphone, @Param("oldCellphone")String oldCellphone);
	public void updateInviteCouponLogCellphone(@Param("newCellphone")String newCellphone, @Param("oldCellphone")String oldCellphone);
}
