package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.NotNull;

public class PhotoGalleryEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	@NotNull
	private String title;
	private String url;
	private int sortNumber;
	private int status;
	private Date createTime;
	private int category;
	private int linkCategory;
	private String link;

	public PhotoGalleryEntity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
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

	public int getLinkCategory() {
		return linkCategory;
	}

	public void setLinkCategory(int linkCategory) {
		this.linkCategory = linkCategory;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

}
