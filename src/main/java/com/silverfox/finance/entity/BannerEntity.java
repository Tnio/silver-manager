package com.silverfox.finance.entity;

import java.io.Serializable;

public class BannerEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String url;
	private int sortNumber;
	private int outerLinked;
	private int status;
	private String remark;
	private short displayPlatform;
	private String shareDesc;

	public BannerEntity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public short getDisplayPlatform() {
		return displayPlatform;
	}

	public void setDisplayPlatform(short displayPlatform) {
		this.displayPlatform = displayPlatform;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(int sortNumber) {
		this.sortNumber = sortNumber;
	}

	public int getOuterLinked() {
		return outerLinked;
	}

	public void setOuterLinked(int outerLinked) {
		this.outerLinked = outerLinked;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getShareDesc() {
		return shareDesc;
	}

	public void setShareDesc(String shareDesc) {
		this.shareDesc = shareDesc;
	}
}