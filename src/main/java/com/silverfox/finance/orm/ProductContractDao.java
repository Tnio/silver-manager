package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.ProductContract;

public interface ProductContractDao {
	ProductContract selectById(int id);
	int queryForCount(Map<String, Object> params);
	List<ProductContract> queryForList(Map<String, Object> params);
	int update(ProductContract productContract);
	int insert(ProductContract productContract);
	int duplicate(@Param("id")int id, @Param("name")String name);
}
