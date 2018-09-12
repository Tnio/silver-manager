package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class SmsTemplate implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String content;
	private Date createTime;
	private short status;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}
}