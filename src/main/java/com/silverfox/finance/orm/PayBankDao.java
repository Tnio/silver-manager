package com.silverfox.finance.orm;

import com.silverfox.finance.domain.PayBank;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PayBankDao {
    List<PayBank> queryForListByBankNO(@Param("payChannel")int payChannel, @Param("bankNOs")List<String> bankNOs);
    List<PayBank> selectBank(@Param("payChannel")int payChannel, @Param("enable")int enable);
    PayBank selectByBankNO( @Param("payChannel")int payChannel, @Param("bankNO")String bankNO);
    PayBank selectById(int id);
    int insert(PayBank payBank);
    int update(PayBank payBank);
    int enable(@Param("id")int id, @Param("value")int value);
    int duplicate(@Param("id")int id, @Param("name")String name);
    void updateBatch(@Param("banks")List<PayBank> banks);
}
