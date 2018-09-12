package com.silverfox.finance.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.silverfox.finance.domain.Admin;
import com.silverfox.finance.domain.LogLogin;
import com.silverfox.finance.domain.LogOperation;
import com.silverfox.finance.domain.LogPayment;
import com.silverfox.finance.domain.Resource;
import com.silverfox.finance.domain.Role;
import com.silverfox.finance.entity.ArrayObjectEntity;
import com.silverfox.finance.entity.TreeNodeEntity;
import com.silverfox.finance.service.SystemService;

@Controller
@RequestMapping("/system")
public class SystemController extends BaseController {
	@Autowired
	private SystemService systemService;
	
	@RequestMapping("/admin/list/{page:\\d+}")
	public String listAdmin(Integer size, @PathVariable("page")int page, Model model){
		int total = systemService.countAdmin();
		if(total > 0){
			model.addAttribute("total", total);
			model.addAttribute("admins", systemService.listAdmin(this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("admins", new Admin[0]);
		}
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "system/admin/list";
	}

	@RequestMapping(value="/admin/add/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String adminForwardToCreation(@PathVariable("page")int page, @PathVariable("size")int size, HttpServletRequest request){
		request.setAttribute("roleList", systemService.getUsingList());
		request.setAttribute("page", page);
		request.setAttribute("size", size);
		return "system/admin/add";
	}
	
	@RequestMapping(value="/admin/{id:\\d+}/edit/{page:\\d+}/{size:\\d+}", method=RequestMethod.GET)
	public String adminForwardToModification(@PathVariable("id")int id, @PathVariable("page")int page, @PathVariable("size")int size,HttpServletRequest request){
		request.setAttribute("admin", systemService.getAdmin(id)); 
		request.setAttribute("roleList", systemService.getUsingList());
		request.setAttribute("page", page);
		request.setAttribute("size", size);
		return "system/admin/edit";
	}
	
	@RequestMapping(value="/admin/save", method=RequestMethod.POST)
	public String saveAdmin(@Valid Admin admin, BindingResult result, int page, int size, Model model, HttpServletRequest request) {
		if(!result.hasErrors()) {
			systemService.saveAdmin(admin);
		} 
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/system/admin/list/"+page;
	}
	
	@RequestMapping(value="admin/{id:\\d+}/reset/totp", method=RequestMethod.POST)
	@ResponseBody
	public boolean resetTotp(@PathVariable("id")int id, HttpServletRequest request) throws IOException {
		Admin admin = systemService.getAdmin(id);
		if (admin != null && admin.getId() > 0) {
			return systemService.totp(id, 0);
		}
		return false;
	}
	
	@RequestMapping(value="/admin/{id:\\d+}/delete", method=RequestMethod.POST)
	@ResponseBody
	public boolean removeAdmin(@PathVariable("id")int id, HttpServletRequest request){
		Admin admin = systemService.getAdmin(id);
		if (admin != null && admin.getId() > 0) {
			return systemService.removeAdmin(id);
		}
		return false;
	}
	
	@RequestMapping(value="/admin/enable", method=RequestMethod.POST)
	@ResponseBody
	public void enableAdmin(int id, short status, HttpServletRequest request) throws IOException {
		if (id > 0) {
			systemService.enableAdmin(id, status);
		}
	}
	
	@RequestMapping(value="/admin/validate/name", method=RequestMethod.GET)
	@ResponseBody
	public String validateAdminName(int id, String fieldId, String fieldValue) {
		if (StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (systemService.validateAdminName(id, fieldValue)) {
				json.setObject(fieldId);
				json.setSuccess(false);
				json.setMessage(messageSource.getMessage("admin.occupy", null, Locale.getDefault())); 
			} else {
				json.setObject(fieldId);
				json.setSuccess(true);
				json.setMessage(messageSource.getMessage("admin.leisure", null, Locale.getDefault())); 
			}
			return json.toString(); 
		}
		return null;
	}
	
	@RequestMapping(value="/admin/validate/cellphone", method=RequestMethod.GET)
	@ResponseBody
	public String validateCellphone(String fieldId, String fieldValue, int id) {
		if (StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (systemService.validateAdminCellphone(id, fieldValue)){
				json.setObject(fieldId);
				json.setSuccess(false);
				json.setMessage(messageSource.getMessage("admin.cellphone.faire", null, Locale.getDefault())); 
			} else {
				json.setObject(fieldId);
				json.setSuccess(true);
				json.setMessage(messageSource.getMessage("admin.cellphone.success", null, Locale.getDefault())); 
			}
			return json.toString(); 
		}
		return null;
	}
	
	
	@RequestMapping("/role/list")
	public String listRole(Model model){
		List<Role> list = systemService.listRoleAll();
		if(list.size() > 0){
			model.addAttribute("roles", list);
		}else{
			model.addAttribute("roles", new Role[0]);
		}
		return "system/role/list";
	}

	@RequestMapping(value="/role/validate/name", method=RequestMethod.GET)
	@ResponseBody
	public String duplicate(String fieldId, String fieldValue, int id) {
		if (StringUtils.isNotBlank(fieldId) && StringUtils.isNotBlank(fieldValue)) {
			ArrayObjectEntity json = new ArrayObjectEntity();
			if (systemService.duplicateRole(id, StringUtils.trim(fieldValue))) {
				json.setObject(fieldId);
				json.setSuccess(false);
				json.setMessage(messageSource.getMessage("role.occupy", null, Locale.getDefault())); 
			} else {
				json.setObject(fieldId);
				json.setSuccess(true);
				json.setMessage(messageSource.getMessage("role.leisure", null, Locale.getDefault())); 
			}
			return json.toString(); 
		}
		return null;
	}
	
	@RequestMapping(value="/role/add", method=RequestMethod.GET)
	public String roleForwardToCreation(){
		return "system/role/add";
	} 
	
	@RequestMapping(value="/role/{id:\\d+}/edit")
	public String roleForwardToModification(@PathVariable("id")int id, HttpServletRequest request){
		request.setAttribute("role", systemService.getRole(id));
		return "system/role/edit";
	}
	
	@RequestMapping(value="/role/save", method=RequestMethod.POST)
	public String saveRole(@Valid Role role, BindingResult result, HttpServletRequest request, Model model){
		if (!result.hasErrors()) {
			boolean exist = systemService.duplicateRole(role.getId(), role.getName());
			if (!exist) {
				systemService.saveRole(role);
			}
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/system/role/list";
	}
	
	@RequestMapping(value="/role/{id:\\d+}/delete", method=RequestMethod.POST)
	public String removeRole(@PathVariable("id")int id,HttpServletRequest request, Model model){
		Role role = systemService.getRole(id);
		if (role != null && role.getId() > 0) {
			systemService.removeRole(id);
		}
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX+properties.getHttpsUrl()+"/system/role/list";
	}
	
	@RequestMapping("/role/{id:\\d+}")
	@ResponseBody
	public Role getRole(@PathVariable("id") int id) {
		return systemService.getRole(id);
	}
	
	@RequestMapping(value="/role/enable", method=RequestMethod.POST)
	@ResponseBody
	public void enableRole(int id, short status, HttpServletRequest request) throws IOException {
		if (id > 0) {
			systemService.enableRole(id, status);
		}
	}
	@RequestMapping(value="/resource/{roleId:\\d+}/all", method=RequestMethod.POST)
	@ResponseBody
	public List<TreeNodeEntity> getTreeAll(@PathVariable("roleId")int roleId){
		if (roleId > 0) {
			List<TreeNodeEntity> tree = new LinkedList<TreeNodeEntity>();
			List<Resource> parents = systemService.listResourceAll();
			if(parents != null && parents.size()>0) {
				for(Resource parent : parents) {
					TreeNodeEntity node = new TreeNodeEntity();
					node.setId(""+parent.getId());
					node.setName(parent.getName());
					node.setpId(""+parent.getParentId());
					node.setChecked(this.compare(roleId, parent.getId()));
					tree.add(node);
				}
			}
			return tree;
		}
		return new ArrayList<TreeNodeEntity>(0);
	}
	
	@RequestMapping(value="/resource/save/authorization", method=RequestMethod.POST)
	@ResponseBody
	public boolean saveAuthorization(int id, String resourceIds, HttpServletRequest request){
		if(id > 0 && StringUtils.isNotBlank(resourceIds)) {
			return systemService.saveAuthorization(id, resourceIds);
		} 
		return false;
	}
	private boolean compare(int roleId, int id){
		List<Resource> resources = systemService.getByRoleId(roleId);
		if(resources != null && resources.size() > 0){
			for(Resource resource : resources){
				if(resource.getId() == id){
					return true;
				}
			}
		}
		return false;
	}
	
	
	
	@RequestMapping("/log/login/{page:\\d+}")
	public String listLogLogin(String adminName, String loginIp, String loginBeginTime, String loginEndTime, Integer size, @PathVariable("page")int page, Model model){
		int total = systemService.countLogLogin(adminName, loginIp, loginBeginTime, loginEndTime);
		if(total > 0){
			model.addAttribute("total", total);
			model.addAttribute("logs", systemService.listLogLogin(adminName, loginIp, loginBeginTime, loginEndTime, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("logs", new LogLogin[0]);
		}
		model.addAttribute("adminName", StringUtils.trimToEmpty(adminName));
		model.addAttribute("loginIp", StringUtils.trimToEmpty(loginIp));
		model.addAttribute("loginBeginTime", StringUtils.trimToEmpty(loginBeginTime));
		model.addAttribute("loginEndTime", StringUtils.trimToEmpty(loginEndTime));
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "system/log/login";
	}
	
	@RequestMapping("/log/operation/{page:\\d+}")
	public String listLogOperation(String operateContent, String adminName, String beginTime, String endTime, Integer size, @PathVariable("page")int page, Model model){
		int total = systemService.countLogOperation(operateContent, adminName, beginTime, endTime);
		if(total > 0){
			model.addAttribute("total", total);
			List<LogOperation> list = systemService.listLogOperation(operateContent, adminName, beginTime, endTime, this.getOffset(page, size), this.getPageSize(size));
			model.addAttribute("logs", list);
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("logs", new LogOperation[0]);
		}
		model.addAttribute("operateContent", StringUtils.trimToEmpty(operateContent));
		model.addAttribute("adminName", StringUtils.trimToEmpty(adminName));
		model.addAttribute("beginTime", StringUtils.trimToEmpty(beginTime));
		model.addAttribute("endTime", StringUtils.trimToEmpty(endTime));
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "system/log/operation";
	}
	
	
	@RequestMapping("/log/payment/{page:\\d+}")
	public String listlogPayment(String orderNo, String productName, String customerName, Integer size, @PathVariable("page")int page, Model model){
		int total = systemService.countLogPayment(orderNo, productName, customerName);
		if(total > 0){
			model.addAttribute("total", total);
			model.addAttribute("logs", systemService.listLogPayment(orderNo, productName, customerName, this.getOffset(page, size), this.getPageSize(size)));
		}else{
			model.addAttribute("total", 0);
			model.addAttribute("logs", new LogPayment[0]);
		}
		model.addAttribute("orderNo", StringUtils.trimToEmpty(orderNo));
		model.addAttribute("productName", productName);
		model.addAttribute("customerName", customerName);
		model.addAttribute("size", this.getPageSize(size));
		model.addAttribute("page", this.getPage(page));
		model.addAttribute("pages", this.getTotalPage(total, size));
		return "system/log/payment";
	}
	
}
