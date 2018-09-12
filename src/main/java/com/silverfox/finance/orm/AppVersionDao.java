package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.AppVersion;

public interface AppVersionDao {
	public List<AppVersion> queryForList(Map<String, Object> params);
	public int queryForCount(Map<String, Object> params);
	public AppVersion selectById(int id);
	public AppVersion selectLatestAppVersion(@Param("appExtension")String appExtension);
	public AppVersion selectLatestVestAppVersion(@Param("appExtension")String appExtension);
	public int insert(AppVersion appVersion);
	public int update(AppVersion appVersion);
	public int duplicate(@Param("id")int id, @Param("version")String version);
	public int enable(@Param("id")int id, @Param("status")short status);
	public int countByVersionAndType(@Param("type")String type, @Param("version")int version);
	public int countVestByVersionAndType(@Param("type")String type, @Param("version")int version);
	public short selectPatchNoByVersion(@Param("version")String version);
}