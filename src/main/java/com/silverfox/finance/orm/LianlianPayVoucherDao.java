package com.silverfox.finance.orm;

import com.silverfox.finance.domain.UnionPayVoucher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LianlianPayVoucherDao {
    List<UnionPayVoucher> selectByBankCode(String bankCode);
    List<UnionPayVoucher> selectByCityCode(@Param("provinceCode")String provinceCode, @Param("city")String city);
    List<UnionPayVoucher> selectByCityCodeAndBankCode(@Param("provinceCode")String provinceCode, @Param("city")String city, @Param("bankCode")String bankCode);
    void insertBatch(@Param("vouchers")List<UnionPayVoucher> vouchers);
}
