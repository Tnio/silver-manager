package com.silverfox.finance.orm;

import com.silverfox.finance.domain.CouponActivity;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CouponActivityDao {
    public List<CouponActivity> queryForList(Map<String, Object> params);
    public int queryForCount(@Param("status")int status);
    public int insert(CouponActivity activity);
    public int update(CouponActivity activity);
    public CouponActivity selectById(int id);
    public int selectByName(@Param("id")int id, @Param("name")String name);
    public int updateStatus(@Param("id")int id ,@Param("status")int status);
    public int selectOverlapTime(@Param("beginTime")String beginTime, @Param("endTime")String endTime);
}
