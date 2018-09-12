package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.VipLevelChangeLog;

public interface VipLevelChangeLogDao {
    public VipLevelChangeLog getVipLevelChangeLog(@Param("customerId")int customerId,@Param("vipLevel")int vipLevel);

	public int queryForCount(Map<String, Object> params);

	public List<VipLevelChangeLog> queryForList(Map<String, Object> params);
}
