package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.InviteActivity;

public interface InviteActivityDao {

	int queryForCount();

	List<InviteActivity> queryForList(Map<String, Object> params);
  
	public int update(InviteActivity inviteActivity);
	public int insert(InviteActivity inviteActivity);
	public InviteActivity selectById(int id);
	public int selectOverlapDate(@Param("beginDate")String beginDate, @Param("endDate")String endDate);
	public int audit(@Param("id")int id, @Param("status")int status);
	public int duplicateInviteActivityName(@Param("id")int id, @Param("name")String name);

	
	
	
	
	
}
