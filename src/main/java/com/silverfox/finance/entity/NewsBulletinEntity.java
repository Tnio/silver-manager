package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.Date;

import com.silverfox.finance.domain.NewsMaterial;

public class NewsBulletinEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private short type;
	private short status;
	private Date createTime;
	private Integer sortNumber;
	private int hits;
	private String title;
	private NewsMaterial news;
	private String shareDesc;

	public NewsBulletinEntity() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public short getType() {
		return type;
	}

	public void setType(short type) {
		this.type = type;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public NewsMaterial getNews() {
		return news;
	}

	public void setNews(NewsMaterial news) {
		this.news = news;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getShareDesc() {
		return shareDesc;
	}

	public void setShareDesc(String shareDesc) {
		this.shareDesc = shareDesc;
	}
}