package com.silverfox.finance.orm;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.silverfox.finance.domain.Resource;
import com.silverfox.finance.domain.RoleResource;

public interface ResourceDao {
	List<Resource> selectByRoleId(@Param("roleId")int roleId);
	List<Resource> selectAll();
	int deleteRoleResource(int id);
	int insertRoleResource(@Param("roleResources")List<RoleResource> roleResources);
	List<Resource> selectByParentIdAndRoleId(@Param("parentId")int parentId, @Param("roleId")int roleId);
	boolean saveAuthorization(int id, String ids);
	List<RoleResource> listRoleResource(@Param("roleId") int roleId);
}