package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.GoodsCouponCode;

public interface GoodsCouponCodeDao {
	int deleteByCouponExchangeId(@Param("couponExchangeId")int couponExchangeId);
	int insertGoodsCouponCodes(@Param("goodsCouponCodes")List<GoodsCouponCode> goodsCouponCodes, @Param("goodsId")int goodsId, @Param("couponExchangeId")int couponExchangeId);
	List<GoodsCouponCode> queryForList(Map<String, Object> params);
	int queryForCount(Map<String, Object> params);

	int deleteByGoodsId(@Param("goodsId")int goodsId);
	int update(GoodsCouponCode couponCode);
	int checkExchangeCode(@Param("id")int id, @Param("code")String code);

}
