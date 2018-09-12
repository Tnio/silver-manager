package com.silverfox.finance.orm;

import com.silverfox.finance.domain.RaceLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RaceLogDao {
    int queryForCount(Map<String, Object> params);
    List<RaceLog> queryForList(Map<String, Object> params);
    int update(@Param("goodsId") int goodsId, @Param("winCode")Long winCode);
}
