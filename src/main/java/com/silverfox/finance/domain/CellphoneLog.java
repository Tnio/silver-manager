package com.silverfox.finance.domain;

import java.io.Serializable;

public class CellphoneLog implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String newCellphone;
	private String oldCellphone;
	private int userId;
	private String idcardFacade;
	private String idcardBack;
	private String idcardPhoto;
	private short status;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getNewCellphone() {
		return newCellphone;
	}

	public void setNewCellphone(String newCellphone) {
		this.newCellphone = newCellphone;
	}

	public String getOldCellphone() {
		return oldCellphone;
	}

	public void setOldCellphone(String oldCellphone) {
		this.oldCellphone = oldCellphone;
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

	public String getIdcardPhoto() {
		return idcardPhoto;
	}

	public void setIdcardPhoto(String idcardPhoto) {
		this.idcardPhoto = idcardPhoto;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}
}