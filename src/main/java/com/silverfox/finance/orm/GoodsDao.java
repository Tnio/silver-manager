package com.silverfox.finance.orm;

import com.silverfox.finance.domain.Goods;
import com.silverfox.finance.domain.GoodsExchangeOrder;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface GoodsDao {
    List<Goods> queryForList(Map<String, Object> params);
    List<Goods> queryForListGoodsRecord(Map<String, Object> params);
    List<Goods> queryOnSaleList();
    Goods selectById(int id);
    int queryForCount(Map<String, Object> params);
    int queryForCountGoodsRecord(Map<String, Object> params);
    int insert(Goods goods);
    int update(Goods goods);
    int updateSort(@Param("goodes")List<Goods> goodes);
    int decrease(@Param("id")int id);
    //List<GoodsExchangeOrder> selectGoodsExchangeOrder(@Param("account")String account, @Param("beginDate")String beginDate, @Param("endDate")String endDate, @Param("financePeriod")short financePeriod);
    List<GoodsExchangeOrder> selectByOrders(@Param("orders")String orders);
    int insertGoodsExchangeOrder(GoodsExchangeOrder goodsExchangeOrder);
    void updateCellone(@Param("newCellphone")String newCellphone, @Param("oldCellphone")String oldCellphone);
	
}
