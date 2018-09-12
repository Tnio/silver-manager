package com.silverfox.finance.enumeration;

public enum PlatformEnum {
	WEB(1),
	IOS(2),
	ANDROID(3),
	ANVEST(6),
	WAP(4),
	EBANK(5);
	
	private int type;
	
	private PlatformEnum(int type) {
		this.type = type;
	}
	
	public int value() {
		return this.type;
	}
}