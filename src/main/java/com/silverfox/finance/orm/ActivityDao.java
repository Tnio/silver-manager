package com.silverfox.finance.orm;

import com.silverfox.finance.domain.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ActivityDao {
    public List<Activity> queryForList(Map<String, Object> params);
    public int queryForCount(@Param("status")int status);
    public int insert(Activity activity);
    public int update(Activity activity);
    public int delete(int id);
    public Activity selectById(int id);
    public int selectByTitle(@Param("id")int id, @Param("title")String title);
    public int updateStatus(@Param("id")int id ,@Param("status")int status);
    public int updateRecommend(@Param("id")int id,@Param("recommend")int recommend);
    public boolean updateSort(@Param("activitys") List<Activity> activitys);
}
