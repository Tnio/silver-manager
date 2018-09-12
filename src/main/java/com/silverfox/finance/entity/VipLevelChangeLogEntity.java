package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

public class VipLevelChangeLogEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private int customerId;
	private int beforeVipLevel;
	private int afterVipLevel;
	private Date createTime;

	public VipLevelChangeLogEntity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getBeforeVipLevel() {
		return beforeVipLevel;
	}

	public void setBeforeVipLevel(int beforeVipLevel) {
		this.beforeVipLevel = beforeVipLevel;
	}

	public int getAfterVipLevel() {
		return afterVipLevel;
	}

	public void setAfterVipLevel(int afterVipLevel) {
		this.afterVipLevel = afterVipLevel;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
