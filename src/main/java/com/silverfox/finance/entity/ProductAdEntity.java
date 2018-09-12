package com.silverfox.finance.entity;

import java.io.Serializable;
import javax.validation.constraints.NotNull;

public class ProductAdEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	@NotNull
	private String name;
	private String remark;
	private Short linkedCategory;
	private String content;
	private int status;

	public ProductAdEntity() {

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

	public Short getLinkedCategory() {
		return linkedCategory;
	}

	public void setLinkedCategory(Short linkedCategory) {
		this.linkedCategory = linkedCategory;
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

}
