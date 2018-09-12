package com.silverfox.finance.orm;

import com.silverfox.finance.domain.Bonus;
import com.silverfox.finance.domain.BonusStrategy;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BonusDao {
    List<Bonus> queryForList(Map<String, Object> params);
    List<Bonus> queryForListByEndTimeAndEnable(Map<String, Object> params);
    int queryForCount();
    Bonus selectById(int id);
    int insert(Bonus bonus);
    int update(Bonus bonus);
    int enable(@Param("id")int id, @Param("enable")short enable);
    int delete(int id);
    int duplicate(@Param("id")int id, @Param("name")String name);
    List<BonusStrategy> selectStrategiesByBonusId(int bonusId);
}
