package com.silverfox.finance.enumeration;

public enum OrderNOPrefixEnum {
	SILVERFOX_MERCHANT("SFM");
	
	private String prefix;
	
	private OrderNOPrefixEnum(String prefix) {
		this.prefix = prefix;
	}
	
	@Override
	public String toString() {
		return this.prefix;
	}
}