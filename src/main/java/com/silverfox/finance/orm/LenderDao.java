package com.silverfox.finance.orm;

import com.silverfox.finance.domain.Lender;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface LenderDao {
    int queryForCount(Map<String, Object> params);
    List<Lender> queryForList(Map<String, Object> params);
    List<Lender> queryLenderForList(Map<String, Object> params);
    int queryLenderForCount(Map<String, Object> params);
    int insert(Lender lender);
    int updateLender(Lender lender);
    Lender selectById(@Param("id")int id);
    int update(@Param("productId")int productId, @Param("lenderIds")int[] lenderIds);
    int updateProductId(@Param("productId")int productId);
    List<Lender> selectByProductId(@Param("productId")int productId, @Param("projectType")int projectType);
    String selectNameByProductId(@Param("productId")int productId);
    List<Lender> selectAllByProductId(@Param("productId")int productId);
	int queryLenderLoanCount(Integer lenderId);
}
