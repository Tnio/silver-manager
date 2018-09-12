package com.silverfox.finance.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.silverfox.finance.domain.Admin;
import com.silverfox.finance.domain.AppVersion;
import com.silverfox.finance.domain.LogLogin;
import com.silverfox.finance.domain.LogOperation;
import com.silverfox.finance.domain.Resource;
import com.silverfox.finance.domain.Role;
import com.silverfox.finance.domain.RoleResource;
import com.silverfox.finance.orm.AdminDao;
import com.silverfox.finance.orm.AppVersionDao;
import com.silverfox.finance.orm.LogLoginDao;
import com.silverfox.finance.orm.LogOperationDao;
import com.silverfox.finance.orm.LogPaymentDao;
import com.silverfox.finance.orm.ResourceDao;
import com.silverfox.finance.orm.RoleDao;
import com.silverfox.finance.service.SystemService;
import com.silverfox.finance.util.LogRecord;
import com.silverfox.finance.util.ValidatorUtil;

@Service
public class SystemServiceImpl implements SystemService {
	@Autowired
	private AdminDao adminDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private ResourceDao resourceDao;
	@Autowired
	private LogLoginDao logLoginDao;
	@Autowired
	private LogOperationDao logOperationDao;
	@Autowired
	private LogPaymentDao logPaymentDao;
	@Autowired
	private AppVersionDao appVersionDao;

	@Override
	public Admin getAdmin(String name) {
		return adminDao.queryByName(name);
	}

	@Override
	@LogRecord(module=LogRecord.Module.ADMIN, operation=LogRecord.Operation.TOTP, id="${id}", name="")
	public boolean totp(int id, int totp) {
		if(id > 0){
			return adminDao.totp(id, totp) > 0 ? true : false;
		}
		return false;
	}
	
	@Override
	public Role getRole(Integer roleId) {
		return roleDao.selectById(roleId);
	}

	@Override
	public Map<Resource, Map<Resource, List<Resource>>> getMenu(int roleId) {
		Map<Resource, Map<Resource, List<Resource>>> menusAndFunctions = new LinkedHashMap<Resource, Map<Resource, List<Resource>>>();
		List<Resource> tops = resourceDao.selectByParentIdAndRoleId(0 ,roleId);
		if(tops != null && tops.size() > 0){
			for(Resource top : tops){
				List<Resource> menu = resourceDao.selectByParentIdAndRoleId(top.getId(), roleId);
				Map<Resource, List<Resource>> menus = new LinkedHashMap<Resource, List<Resource>>();
				for (Resource me : menu) {
					List<Resource> functions = resourceDao.selectByParentIdAndRoleId(me.getId(), roleId);
					if(functions != null && functions.size()>0) {
						menus.put(me, functions);
					} else {
						menus.put(me, new ArrayList<Resource>(0));
					}
				}
				if (menus.size() > 0) {
					menusAndFunctions.put(top, menus);
				} 
			}
		}
		return menusAndFunctions;
	}

	@Override
	public List<Integer> getFunctions(int roleId) {
		List<Integer> functionIds = new ArrayList<Integer>();
 		List<Resource> tops = resourceDao.selectByParentIdAndRoleId(0 ,roleId);
		if(tops != null && tops.size() > 0){
			for(Resource top : tops){
				List<Resource> menu = resourceDao.selectByParentIdAndRoleId(top.getId(), roleId);
				for (Resource me : menu) {
					List<Resource> functions = resourceDao.selectByParentIdAndRoleId(me.getId(), roleId);
					for (Resource function : functions) {
						functionIds.add(function.getId());
					}
				}
			}
		}
		return functionIds;
	}
	
	@Override
	public LogLogin saveLogLogin(LogLogin logLogin) {
		boolean result = false;
		if (logLogin != null) {
			if (logLogin.getId() > 0) {
				result = logLoginDao.update(logLogin) > 0 ? true : false;
			} else {
				result = logLoginDao.insert(logLogin) > 0 ? true : false;
			}
		}
		if(result){
			return logLogin;
		}
		return null;
	}

	@Override
	public int countAdmin() {
		return adminDao.queryForCount();
	}

	@Override
	public List<Admin> listAdmin(int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("size", size);
		return adminDao.queryForList(params);
	}

	@Override
	public Admin getAdmin(int id) {
		return adminDao.selectById(id);
	}

	@Override
	@LogRecord(module=LogRecord.Module.ADMIN, operation=LogRecord.Operation.ADMINSAVE, id="", name="${admin.name}")
	public boolean saveAdmin(Admin admin) {
		boolean checkedReslut = this.checkedParam(admin);
		if(checkedReslut){
			if (admin.getId() > 0) {
				return adminDao.update(admin) > 0 ? true : false;
			} else {
				return adminDao.insert(admin) > 0 ? true : false;
			}
		}else{
			return false;
		}
	}

	@Override
	@LogRecord(module=LogRecord.Module.ADMIN, operation=LogRecord.Operation.REMOVE, id="${id}", name="")
	public boolean removeAdmin(int id) {
		return adminDao.delete(id) > 0 ? true : false;
	}

	@Override
	@LogRecord(module=LogRecord.Module.ADMIN, operation=LogRecord.Operation.ENABLE, id="${id}", name="")
	public boolean enableAdmin(int id, short status) {
		if(id > 0){
			return adminDao.enable(id, status) > 0 ? true : false;
		}
		return false;
	}

	@Override
	public boolean validateAdminName(int id, String name) {
		return adminDao.countByName(id, name) > 0 ? true : false;
	}

	@Override
	public boolean validateAdminCellphone(int id, String cellphone) {
		return adminDao.countByCellphone(id, cellphone) > 0 ? true : false;
	}

	@Override
	public List<Role> getUsingList() {
		return roleDao.selectUsingList();
	}
	
	private boolean checkedParam(Admin admin){
		if(admin != null){
			if(!ValidatorUtil.StrNotNullAndMinAndMax(admin.getName(), 4, 20)){
				return false;
			}
			if(!ValidatorUtil.isPhone(admin.getCellphone())){
				return false;
			}
			if(!ValidatorUtil.StrNotNullAndMinAndMax(admin.getRealName(), 2, 4) || !ValidatorUtil.isChinese(admin.getRealName())){
				return false;
			}
			return true;
		}else{
			return false;
		}
	}

	@Override
	public List<Role> listRoleAll() {
		return roleDao.listAll();
	}

	@Override
	@LogRecord(module=LogRecord.Module.ROLE, operation=LogRecord.Operation.ROLESAVE, id="", name="${role.name}")
	public boolean saveRole(Role role){
		boolean checkResult = checkedParam(role);
		if(checkResult){
			if(role.getId() > 0){
				return roleDao.update(role) > 0 ? true : false;
			}else{
				return roleDao.insert(role) > 0 ? true : false;
			}
		}else{
			return false;
		}
		
	}

	
	
		@Override
		public boolean enableRole(int id, short status) {
			if(id > 0){
				return roleDao.enable(id, status) > 0 ? true : false;
			}
			return false;
		}
	

	@Override
	public boolean duplicateRole(int id, String name) {
		return roleDao.duplicate(id, name) > 0 ? true : false;
		
	}

	@Override
	@LogRecord(module=LogRecord.Module.ROLE, operation=LogRecord.Operation.REMOVE, id="${id}", name="")
	public boolean removeRole(int id){
		return roleDao.delete(id) > 0 ? true : false;
	}
	
	private boolean checkedParam(Role role){
		if(role != null){
			/*if(!ValidatorUtil.StrNotNullAndMinAndMax(role.getName(), 1, 6)){
				return false;
			}*/
			if(!ValidatorUtil.isEmpty(role.getRemark()) && !ValidatorUtil.StrNotNullAndMinAndMax(role.getRemark(), 0, 30)){
				return false;
			}
			return true;
		}else{
			return false;
		}
	}

	@Override
	@LogRecord(module=LogRecord.Module.ROLE, operation=LogRecord.Operation.AUTHORIZATION, id="${id}", name="")
	public boolean saveAuthorization(int id, String ids){
		List<RoleResource> roleResources = new ArrayList<RoleResource>();
		if(id > 0){
			String[] resourceIds = StringUtils.split(ids, ",");
			if(resourceIds != null && resourceIds.length > 0 ){
				for(String resourceId : resourceIds ){
					RoleResource roleResource = new RoleResource();
					roleResource.setRoleId(id);
					roleResource.setResourceId(Integer.parseInt(resourceId));
					roleResources.add(roleResource);
				}
				resourceDao.deleteRoleResource(id);
				return resourceDao.insertRoleResource(roleResources) > 0 ? true : false;
			}else{
				resourceDao.deleteRoleResource(id);
				return true;
			}
					
		}
		return false;
	}
	


	@Override
	public List<Resource> getByRoleId(int roleId) {
		return resourceDao.selectByRoleId(roleId);
	}

	@Override
	public List<Resource> listResourceAll() {
		return resourceDao.selectAll();
	}
	

	@Override
	public int countLogLogin(String adminName, String loginIp, String loginBeginTime, String loginEndTime) {
		Map<String, Object> params = this.getParams(adminName, loginIp, loginBeginTime, loginEndTime);
		return logLoginDao.queryForCount(params);
	}
	
	
	private Map<String, Object> getParams(String adminName, String loginIp, String loginBeginTime, String loginEndTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(adminName)) {
			params.put("adminName", adminName);
		}
		if(StringUtils.isNotBlank(loginIp)) {
			params.put("loginIp", loginIp);
		}
		if(StringUtils.isNotBlank(loginBeginTime) && StringUtils.isNotBlank(loginEndTime)) {
			params.put("loginBeginTime", loginBeginTime);
			params.put("loginEndTime", loginEndTime);
		}
		return params;
	}

	@Override
	public Object listLogLogin(String adminName, String loginIp, String loginBeginTime, String loginEndTime, int offset,
			int size) {
		Map<String, Object> params = this.getParams(adminName, loginIp, loginBeginTime, loginEndTime);
		params.put("offset", offset);
		params.put("size", size);
		return logLoginDao.queryForList(params);
	}

	@Override
	public int countLogOperation(String operateContent, String adminName, String beginTime, String endTime) {
		Map<String, Object> params = this.getParam(operateContent, adminName, beginTime, endTime);
		return logOperationDao.queryForCount(params);
		
	}

	@Override
	public boolean saveLogOperation(LogOperation logOperation) {
		return logOperationDao.insert(logOperation)>0? true :false;
	}
	
	@Override
	public List<LogOperation> listLogOperation(String operateContent, String adminName, String beginTime,
			String endTime, int offset, int size) {
		Map<String, Object> params = this.getParam(operateContent, adminName, beginTime, endTime);
		params.put("offset", offset);
		params.put("size", size);
		return logOperationDao.queryForList(params);
	}

	private Map<String, Object> getParam(String operateContent, String adminName, String beginTime, String endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(operateContent)) {
			params.put("operateContent", operateContent);
		}
		if(StringUtils.isNotBlank(adminName)) {
			params.put("adminName", adminName);
		}
		if(StringUtils.isNotBlank(beginTime) && StringUtils.isNotBlank(endTime)) {
			params.put("beginTime", beginTime);
			params.put("endTime", endTime);
		}
		return params;
	}

	@Override
	public int countLogPayment(String orderNo, String productName, String customerName) {
		Map<String, Object> params = this.getParams(orderNo, productName, customerName);
		return logPaymentDao.queryForCount(params);
		
	}
	
	private Map<String, Object> getParams(String orderNo, String productName, String customerName) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(StringUtils.isNotBlank(orderNo)) {
			params.put("orderNo", orderNo);
		}
		if(StringUtils.isNotBlank(productName)) {
			params.put("productName", productName);
		}
		if(StringUtils.isNotBlank(customerName)) {
			params.put("customerName", customerName);
		}
		return params;
	}

	@Override
	public Object listLogPayment(String orderNo, String productName, String customerName, int offset, int size) {
		Map<String, Object> params = this.getParams(orderNo, productName, customerName);
		params.put("offset", offset);
		params.put("size", size);
		return logPaymentDao.queryForList(params);
	}

	@Override
	public AppVersion getAppVersion(int id) {
		
		return appVersionDao.selectById(id);
	}

	@Override
	public short getPatchNoByVersion(String version) {
		
		return appVersionDao.selectPatchNoByVersion(version);
	}

	@Override
	public int countAppVersion(String version, String upgradeContent) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(!StringUtils.isBlank(version)){
			params.put("version", version);
		}
		if(!StringUtils.isBlank(upgradeContent)){
			params.put("upgradeContent", upgradeContent);
		}
		return appVersionDao.queryForCount(params);
	}

	@Override
	
	public List<AppVersion> listAppVersion(String version, String upgradeContent, int offset, int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(!StringUtils.isBlank(version)){
			params.put("version", version);
		}
		if(!StringUtils.isBlank(upgradeContent)){
			params.put("upgradeContent", upgradeContent);
		}
		params.put("offset", offset);
		params.put("size", size);
		return appVersionDao.queryForList(params);
	}

	
	@Override
	@LogRecord(module=LogRecord.Module.APPVERSION, operation=LogRecord.Operation.APPVERSIONSAVE, id="", name="${appVersion.version}")
	public boolean saveAppVersion(AppVersion appVersion) {
		boolean checkedReslut = checkedParam(appVersion);
		if(checkedReslut){
			if (appVersion != null) {
				if (appVersion.getId() > 0) {
					return appVersionDao.update(appVersion) > 0 ? true : false;
				} else {
					return appVersionDao.insert(appVersion) > 0 ? true : false;
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
	}
	
	private boolean checkedParam(AppVersion appVersion){
		if(appVersion != null){
			if(!ValidatorUtil.StrNotNullAndMinAndMax(appVersion.getVersion(), 1, 10)){
				return false;
			}
			if(!ValidatorUtil.StrNotNullAndMinAndMax(appVersion.getContent(), 1, 328)){
				return false;
			}
			if(!ValidatorUtil.StrNotNull(appVersion.getType())){
				return false;
			}
			return true;
		}else{
			return false;
		}
	}

	@Override
	public boolean saveAppVersionPatch(AppVersion appVersion) {
		
		if(appVersion != null && appVersion.getId() > 0 && StringUtils.isNotBlank(appVersion.getPatchUrl())){
			AppVersion version = appVersionDao.selectById(appVersion.getId());
			version.setPatchNO(appVersion.getPatchNO());
			version.setPatchUrl(appVersion.getPatchUrl());
			return appVersionDao.insert(version) > 0 ? true : false;
		}
		return false;
	}

	@Override
	public boolean enableVersion(int id, short status) {
		return appVersionDao.enable(id, status) > 0 ? true : false;
		
	}

	@Override
	public boolean duplicateAppVersion(int id, String version) {
		return appVersionDao.duplicate(id, version) < 1 ? true : false;
	}


}