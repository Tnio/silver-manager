package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.SmsTemplate;

public interface SmsTemplateDao {
	public List<SmsTemplate> queryForList(Map<String, Object> params);
	public SmsTemplate selectById(int templateId);
	public int queryForCount(Map<String, Object> params);
	public int insert(SmsTemplate smsTemplate);
	public int update(SmsTemplate smsTemplate);
}