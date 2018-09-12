package com.silverfox.finance.orm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Project;


public interface ProjectDao {
	List<Project> queryForList(Map<String, Object> params);
	Project selectById(@Param("id")int id);
	int insert(Project project);
	int update(Project project);
	int updateStatus(@Param("id")int id, @Param("status")int status);
	int queryForCount();
}