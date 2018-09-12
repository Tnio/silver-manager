package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Admin;

public interface AdminDao {
	public List<Admin> queryForList(Map<String, Object> params);
	public int queryForCount();
	public Admin queryByName(String name);
	public int insert(Admin admin);
	public int update(Admin admin);
	public int delete(int id);
	public int enable(@Param("id")int id, @Param("status")short status);
	public int totp(@Param("id")int id, @Param("totp")int totp);
	public int countByName(@Param("id")int id, @Param("name")String name);
	public Admin selectById(int id);
	public int countByCellphone(@Param("id")int id, @Param("cellphone")String cellphone);
	
	public int locked(@Param("name")String name, @Param("status")short status);
}