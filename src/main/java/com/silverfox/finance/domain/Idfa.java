package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class Idfa implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String idfa;
	private Date createTime;

	public Idfa() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getIdfa() {
		return idfa;
	}

	public void setIdfa(String idfa) {
		this.idfa = idfa;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}