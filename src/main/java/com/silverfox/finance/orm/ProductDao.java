package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Product;
import com.silverfox.finance.entity.ProductTradeEntity;
import com.silverfox.finance.entity.ReceivablesEntity;


public interface ProductDao{

	List<Product> queryForList(Map<String, Object> params);
	int queryForCount(Map<String, Object> params);
	int queryForCountTreasure(Map<String, Object> params);
	List<Product> queryForListTreasure(Map<String, Object> params);
	List<Product> selectProductByBonusId(@Param("bonusId")int bonusId);
	int selectAllByName(String name);

    Product selectById(int id);

	List<ReceivablesEntity> queryProductIncomeAmountByMonth(@Param("id")int id, @Param("systemMonth")String systemMonth, @Param("offset")int offset, @Param("size")int size);

	float queryProductIncomeById(@Param("id")int id, @Param("yesterday")String yesterday);

	List<ProductTradeEntity> queryInMoneys(@Param("beginTime")String beginTime, @Param("endTime")String endTime);
	List<ProductTradeEntity> queryOutMoneys(@Param("type")int type, @Param("beginTime")String beginTime, @Param("endTime")String endTime);
	List<ProductTradeEntity> queryInTotals(@Param("beginTime")String beginTime, @Param("endTime")String endTime);
	List<ProductTradeEntity> queryOutTotals(@Param("type")int type, @Param("beginTime")String beginTime, @Param("endTime")String endTime);
	List<ProductTradeEntity> queryInPeoples(@Param("beginTime")String beginTime, @Param("endTime")String endTime);
	List<ProductTradeEntity> queryOutPeoples(@Param("type")int type, @Param("beginTime")String beginTime, @Param("endTime")String endTime);
	int update(Product product);
	int insert(Product product);
	boolean updateDisplayPlatform(@Param("id")int id, @Param("displayPlatform")String displayPlatform);
	int queryForCountByCategoryProperty(String property);
	int updateSort(@Param("products") List<Product> products);
	int queryForMerchantLoanCount(int merchantIdData);
	int queryTotalNumberMark();
	int changeProductStatus(@Param("id")int id);
	String queryProductName(@Param("id")int id);
	List<Product> queryInTheSale();
	
}