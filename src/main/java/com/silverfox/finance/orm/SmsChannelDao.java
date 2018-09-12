package com.silverfox.finance.orm;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.SmsChannel;

public interface SmsChannelDao {
	List<SmsChannel> selectByEnable(@Param("enable")short enable);

	SmsChannel selectById(int parseInt);

}
