package com.silverfox.finance.enumeration;

public enum TypeEnum {
	IN(0),
	OUT(1),
	HANDING(2),
	OVERDUE(3);
	
	int value;
	
	private TypeEnum(int value) {
		this.value = value;
	}
	
	public int value() {
		return this.value;
	}
	
	public String toString() {
		return String.valueOf(this.value);
	}
}