package com.silverfox.finance.orm;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.ProductCategory;

public interface ProductCategoryDao {
	List<ProductCategory> queryForList(@Param("status")int status);
	int queryForCountByProperty(String property);
	int insert(ProductCategory productCategory);
	int enable(@Param("id")int id, @Param("value")int value);
	int duplicate(@Param("id")int id, @Param("name")String name);
	ProductCategory selectById(int id);
	List<ProductCategory> selectByProperty(@Param("property")String property);
}