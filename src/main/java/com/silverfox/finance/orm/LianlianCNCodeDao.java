package com.silverfox.finance.orm;

import com.silverfox.finance.domain.UnionPayCNCode;

import java.util.List;

public interface LianlianCNCodeDao {
    List<UnionPayCNCode> selectAll();
    List<UnionPayCNCode> selectProvince();
    List<UnionPayCNCode> selectCityByProvinceCode(String provinceCode);
}
