package com.silverfox.finance.domain;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Role implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	@NotNull
	@Size(min = 1)
	private String name;
	@Size(min = 0, max = 30)
	private String remark;
	private short status;
	private short privacy;

	public Role() {

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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public short getPrivacy() {
		return privacy;
	}

	public void setPrivacy(short privacy) {
		this.privacy = privacy;
	}
}