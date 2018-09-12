package com.silverfox.finance.domain;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class AppVersion implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	@NotNull
	@Size(min = 1, max = 10)
	private String version;
	@NotNull
	@Size(min = 1, max = 328)
	private String content;
	private short status;
	private String url;
	@NotNull
	private String type;
	private short patchNO;
	private String patchUrl;

	public AppVersion() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
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

	public void setStatus(short status) {
		this.status = status;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public short getPatchNO() {
		return patchNO;
	}

	public void setPatchNO(short patchNO) {
		this.patchNO = patchNO;
	}

	public String getPatchUrl() {
		return patchUrl;
	}

	public void setPatchUrl(String patchUrl) {
		this.patchUrl = patchUrl;
	}
}