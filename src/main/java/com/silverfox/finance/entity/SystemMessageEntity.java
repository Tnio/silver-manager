package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

import com.silverfox.finance.domain.NewsMaterial;

public class SystemMessageEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String title;
	private NewsMaterial content;
	private Integer status;
	private String shareDesc;
	private Date createTime;

	public SystemMessageEntity() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public NewsMaterial getContent() {
		return content;
	}

	public void setContent(NewsMaterial content) {
		this.content = content;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public String getShareDesc() {
		return shareDesc;
	}

	public void setShareDesc(String shareDesc) {
		this.shareDesc = shareDesc;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}