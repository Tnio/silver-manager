package com.silverfox.finance.domain;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class Admin implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	@NotNull
	@Size(min = 4, max = 20)
	private String name;
	private String ip;
	@NotNull
	@Pattern(regexp = "(\\+\\d+)?1[345789]\\d{9}$")
	private String cellphone;
	@NotNull
	@Size(min = 2, max = 4)
	@Pattern(regexp = "^[\u4E00-\u9FA5]+$")
	private String realName;
	private Role role;
	private short status;
	private int totp;

	public Admin() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public int getTotp() {
		return totp;
	}

	public void setTotp(int totp) {
		this.totp = totp;
	}
}