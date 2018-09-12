package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Coupon;
import com.silverfox.finance.entity.BonusRecordEntity;
import com.silverfox.finance.entity.CouponStatisticsEntity;
import com.silverfox.finance.entity.InviterRecordEntity;
import com.silverfox.finance.entity.StatisticsEntity;

public interface CouponDao {
	int queryForCount(Map<String, Object> params);
	List<Coupon> queryForList(Map<String, Object> params);
	int insert(Coupon coupon);
	int update(Coupon coupon);
	Coupon select(int id);
	List<StatisticsEntity> selectIncreaseCoupon(Map<String, Object> params);

	List<StatisticsEntity> statisticsCouponsDetail(Map<String, Object> params);

	List<StatisticsEntity> statisticsCoupons(Map<String, Object> params);
	
	int queryForCountCustomerAggregate(Map<String, Object> params);
	
	List<CouponStatisticsEntity> queryForListCustomerAggregate(Map<String, Object> params);

	int queryForCountBonusRecord(Map<String, Object> params);
	List<BonusRecordEntity> queryForListBonusRecord(Map<String, Object> params);
	int queryForCountInviterRecord(Map<String, Object> params);
	List<InviterRecordEntity> queryForListInviterRecord(Map<String, Object> params);
	List<Coupon> selectDispatchingBonusLogCoupon(@Param("dispatchingBonusLogId")int dispatchingBonusLogId);
	List<Coupon> queryCoupons(@Param("couponIds")String couponIds, @Param("category")int category, @Param("status")int status);
	List<Integer> canDisable(@Param("couponId")int couponId);
}