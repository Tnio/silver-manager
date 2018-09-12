package com.silverfox.finance.service;

import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.Admin;
import com.silverfox.finance.domain.AppVersion;
import com.silverfox.finance.domain.LogLogin;
import com.silverfox.finance.domain.LogOperation;
import com.silverfox.finance.domain.Resource;
import com.silverfox.finance.domain.Role;

public interface SystemService {
	public Admin getAdmin(String name);
	public int countAdmin();
	public List<Admin> listAdmin(int offset, int size);
	public Admin getAdmin(int id);
	public boolean saveAdmin(Admin admin);
	public boolean removeAdmin(int id);
	public boolean enableAdmin(int id, short status);
	public boolean validateAdminName(int id, String name);
	public boolean validateAdminCellphone(int id, String cellphone);
	
	public List<Role> listRoleAll();
	public boolean saveRole(Role role);
	public boolean removeRole(int id);
	public boolean enableRole(int id, short enable);
	

	public List<Role> getUsingList();
	public Role getRole(Integer roleId);
	public Map<Resource, Map<Resource, List<Resource>>> getMenu(int roleId);
	public List<Integer> getFunctions(int roleId); 
	public boolean totp(int id, int totp);
	
	public LogLogin saveLogLogin(LogLogin logLogin);
	
	public boolean duplicateRole(int id, String trim);
	public List<Resource> listResourceAll();
	public List<Resource> getByRoleId(int roleId);
	public boolean saveAuthorization(int id, String resourceIds);
	
	
	
	public int countLogLogin(String adminName, String loginIp, String loginBeginTime, String loginEndTime);
	public Object listLogLogin(String adminName, String loginIp, String loginBeginTime, String loginEndTime, int offset,
			int pageSize);
	
	
	public int countLogOperation(String operateContent, String adminName, String beginTime, String endTime);
	public List<LogOperation> listLogOperation(String operateContent, String adminName, String beginTime,
			String endTime, int offset, int pageSize);
	
	public boolean saveLogOperation(LogOperation logOperation);
	
	
	public int countLogPayment(String orderNo, String productName, String customerName);
	public Object listLogPayment(String orderNo, String productName, String customerName, int offset, int pageSize);
	
	
	
	public AppVersion getAppVersion(int id);
	public short getPatchNoByVersion(String version);
	public int countAppVersion(String version, String upgradeContent);
	public List<AppVersion> listAppVersion(String version, String upgradeContent, int offset, int size);
	public boolean saveAppVersion(AppVersion appVersion);
	public boolean saveAppVersionPatch(AppVersion appVersion);
	public boolean enableVersion(int id, short status);
	public boolean duplicateAppVersion(int id, String version);
}