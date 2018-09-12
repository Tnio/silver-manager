package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.ProductProtocol;

public interface ProductProtocolDao {
	List<ProductProtocol> queryForList(Map<String, Object> params);
	int queryForCount(Map<String, Object> params);
	ProductProtocol selectById(int id);
	int insert(ProductProtocol protocol);
	int update(ProductProtocol protocol);
	int updateStatus(@Param("id")int id, @Param("status")int status);
	int duplicate(@Param("id")int id, @Param("name")String name);
	List<ProductProtocol> selectByIds(@Param("protocolIds")String protocolIds);
	ProductProtocol selectSignatureProtocolByProductId(@Param("productId")int productId);
}
