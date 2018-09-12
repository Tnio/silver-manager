package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class LogOperation implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String adminName;
	private Date operateTime;
	private String operateContent;
	private Date createTime;

	public LogOperation() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getOperateContent() {
		return operateContent;
	}

	public void setOperateContent(String operateContent) {
		this.operateContent = operateContent;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
