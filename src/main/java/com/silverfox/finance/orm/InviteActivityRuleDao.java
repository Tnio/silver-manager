package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.InviteActivityLog;
import com.silverfox.finance.domain.InviteActivityRule;

public interface InviteActivityRuleDao {

	public int updateInviteRule(InviteActivityRule rule);
	public void insertInviteRuleBatch(@Param("rules")List<InviteActivityRule> rules);
	public List<InviteActivityRule> selectRuleByActivityId(int activityId);
	public int queryForLogCount(Map<String, Object> params);
	public List<InviteActivityLog> queryForLogList(Map<String, Object> params);
	
	
}
