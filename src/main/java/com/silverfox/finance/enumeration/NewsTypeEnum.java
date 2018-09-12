package com.silverfox.finance.enumeration;

public enum NewsTypeEnum {

	INNER(1), 
	OUTER(2);

	int value;

	NewsTypeEnum(int value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return String.valueOf(this.value);
	}
	
	public int value() {
		return this.value;
	}
}