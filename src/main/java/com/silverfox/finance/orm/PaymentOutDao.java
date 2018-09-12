package com.silverfox.finance.orm;

import com.silverfox.finance.domain.PaymentOut;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PaymentOutDao {
    List<PaymentOut> selectByDate(String payDate);
    PaymentOut selectByOrderNO(String orderNO);
    int insert(PaymentOut payment);
    int delete(String orderNO);
    int deleteBatch(@Param("payments")List<PaymentOut> payments);
    List<PaymentOut> selectEBankMsg(@Param("customerId")int customerId);
}
