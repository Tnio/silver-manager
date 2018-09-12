package com.silverfox.finance.enumeration;

public enum GenericEnableEnum {
	ALL(-1),
	DISABLED(0),	
	ENABLE(1);
	
	int value;
	
	private GenericEnableEnum(int value) {
		this.value = value;
	}

	public int value() {
		return value;
	}
}