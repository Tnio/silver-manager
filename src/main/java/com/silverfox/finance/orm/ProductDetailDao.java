package com.silverfox.finance.orm;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.ProductDetail;

public interface ProductDetailDao{
	ProductDetail selectById(@Param("id")int id);
	int insert(ProductDetail productDetail);
	int update(ProductDetail productDetail);
}   