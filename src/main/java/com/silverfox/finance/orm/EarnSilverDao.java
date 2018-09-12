package com.silverfox.finance.orm;

import com.silverfox.finance.domain.EarnSilver;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EarnSilverDao {
    List<EarnSilver> selectByEnable(@Param("enable")short enable);
    EarnSilver selectById(int id);
    int update(EarnSilver earnSilver);
    int enable(@Param("id")int id, @Param("enable")short enable);

}
