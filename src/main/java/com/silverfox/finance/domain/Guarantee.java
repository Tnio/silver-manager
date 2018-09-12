package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.List;

public class Guarantee implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private int status;
	private List<Attachment> attachments;

	public Guarantee() {

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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}
}
