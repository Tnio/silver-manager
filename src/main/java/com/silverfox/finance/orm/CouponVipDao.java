package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.CouponVip;
import com.silverfox.finance.entity.CouponVipEntity;

public interface CouponVipDao {

	List<CouponVip> selectByType(int couponType);

	int  savecouponVip(CouponVip couponVip);

	CouponVip selectByVipLevel(Map<String, Integer> params);

	int updatecouponVip(CouponVip couponVip);

	int deleteByCouponType(int couponType);

    int insertcouponVips(@Param("couponVips") List<CouponVip> couponVips);
    
    List<CouponVipEntity> selectByCouponType(int couponType);
}
