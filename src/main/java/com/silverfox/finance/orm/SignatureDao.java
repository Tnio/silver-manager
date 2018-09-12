package com.silverfox.finance.orm;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Signature;

public interface SignatureDao {
	int insertInBatch(@Param("signatures")List<Signature> signatures);
	List<Signature> queryForList(@Param("productId")int productId);
}