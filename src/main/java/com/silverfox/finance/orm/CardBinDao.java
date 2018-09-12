package com.silverfox.finance.orm;

import com.silverfox.finance.domain.CardBin;
import org.apache.ibatis.annotations.Param;

public interface CardBinDao {
    CardBin selectByPrefix(@Param("prefix")String prefix);
}
