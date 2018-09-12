package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.CustomerGoodsOrder;

public interface CustomerGoodsOrderDao {
    List<CustomerGoodsOrder> queryForList(Map<String, Object> params);
    int queryForCount(Map<String, Object> params);
    int update(CustomerGoodsOrder customerGoodsOrder);
    int insert(CustomerGoodsOrder customerGoodsOrder);
    CustomerGoodsOrder selectByOrderNo(String orderNo);

    List<CustomerGoodsOrder> selectLatestGoodsOrder(int num);
}
