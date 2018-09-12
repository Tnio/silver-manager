package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class EBankLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private CustomerBank newBank;
	private CustomerBank oldBank;
	private String logoutImg;
	private String validateImg;
	private String idcardFacade;
	private String idcardBack;
	private int status;
	private Date createTime;
	private String remark;

	public EBankLog() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public CustomerBank getNewBank() {
		return newBank;
	}

	public void setNewBank(CustomerBank newBank) {
		this.newBank = newBank;
	}

	public CustomerBank getOldBank() {
		return oldBank;
	}

	public void setOldBank(CustomerBank oldBank) {
		this.oldBank = oldBank;
	}

	public String getLogoutImg() {
		return logoutImg;
	}

	public void setLogoutImg(String logoutImg) {
		this.logoutImg = logoutImg;
	}

	public String getValidateImg() {
		return validateImg;
	}

	public void setValidateImg(String validateImg) {
		this.validateImg = validateImg;
	}

	public String getIdcardFacade() {
		return idcardFacade;
	}

	public void setIdcardFacade(String idcardFacade) {
		this.idcardFacade = idcardFacade;
	}

	public String getIdcardBack() {
		return idcardBack;
	}

	public void setIdcardBack(String idcardBack) {
		this.idcardBack = idcardBack;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}