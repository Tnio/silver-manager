package com.silverfox.finance.enumeration;

public enum GenericStatusEnum {
	DISABLED(2),	
	ENABLE(1);
	
	int value;
	
	private GenericStatusEnum(int value) {
		this.value = value;
	}
	
	public int value() {
		return value;
	}
}