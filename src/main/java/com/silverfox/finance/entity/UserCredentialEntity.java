package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.List;

public class UserCredentialEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private String userName;
	private String secretKey;
	private int validationCode;
	private List<Integer> scratchCodes;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSecretKey() {
		return secretKey;
	}

	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}

	public int getValidationCode() {
		return validationCode;
	}

	public void setValidationCode(int validationCode) {
		this.validationCode = validationCode;
	}

	public List<Integer> getScratchCodes() {
		return scratchCodes;
	}

	public void setScratchCodes(List<Integer> scratchCodes) {
		this.scratchCodes = scratchCodes;
	}
}