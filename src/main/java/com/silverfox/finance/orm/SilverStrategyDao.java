package com.silverfox.finance.orm;

import com.silverfox.finance.domain.SilverStrategy;
import org.apache.ibatis.annotations.Param;

public interface SilverStrategyDao {
    int update(SilverStrategy silverStrategy);
    int enable(@Param("id")int id, @Param("enable")short enable);
    SilverStrategy selectById(int id);
}
