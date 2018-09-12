package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class PictrueLibrary implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String url;
	private short linkCategory;
	private String content;
	private int status;
	private int sortNumber;
	private int displayPlatform;
	private Date createTime;
	private int category;
	private String shareDesc;
	private String remark;

	public PictrueLibrary() {

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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public short getLinkCategory() {
		return linkCategory;
	}

	public void setLinkCategory(short linkCategory) {
		this.linkCategory = linkCategory;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(int sortNumber) {
		this.sortNumber = sortNumber;
	}

	public int getDisplayPlatform() {
		return displayPlatform;
	}

	public void setDisplayPlatform(int displayPlatform) {
		this.displayPlatform = displayPlatform;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getShareDesc() {
		return shareDesc;
	}

	public void setShareDesc(String shareDesc) {
		this.shareDesc = shareDesc;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}