package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.silverfox.finance.domain.Admin;
import com.silverfox.finance.domain.Merchant;
import com.silverfox.finance.domain.Resource;
import com.silverfox.finance.domain.Role;

public class SecurityEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private Admin admin;
	private Role role;
	private Map<Resource, Map<Resource, List<Resource>>> menu;
	private String serverPath;
	private UserEntity customer;
	private Merchant merchant;
	private Object object;

	public SecurityEntity() {

	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public UserEntity getCustomer() {
		return customer;
	}

	public void setCustomer(UserEntity customer) {
		this.customer = customer;
	}

	public Merchant getMerchant() {
		return merchant;
	}

	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Map<Resource, Map<Resource, List<Resource>>> getMenu() {
		return menu;
	}

	public void setMenu(Map<Resource, Map<Resource, List<Resource>>> menu) {
		this.menu = menu;
	}

	public String getServerPath() {
		return serverPath;
	}

	public void setServerPath(String serverPath) {
		this.serverPath = serverPath;
	}

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}
}