package com.silverfox.finance.enumeration;

public enum RechargeTypeEnum {
	FLOW800_104365("104365", "5M流量"),
	FLOW800_104366("104366", "10M流量"),
	FLOW800_104367("104367", "30M流量"),
	FLOW800_104368("104368", "50M流量"),
	FLOW800_104369("104369", "100M流量"),
	FLOW800_104370("104370", "200M流量"),
	FLOW800_104371("104371", "500M流量"),
	FLOW800_104372("104372", "1G流量"),
	FLOWQWT_10("10MB","10M流量"),
	FLOWQWT_30("30MB","30M流量"),
	FLOWQWT_50("50MB","50M流量"),
	FLOWQWT_70("70MB","70M流量"),
	FLOWQWT_100("100MB","100M流量"),
	FLOWQWT_150("150MB","150M流量"),
	FLOWQWT_200("200MB","200M流量"),
	FLOWQWT_500("500MB","500M流量"),
	FLOWQWT_1024("1024MB","1G流量"),
	UNKNOWN("999999","未知类型");
	
	private final String code;
	private final String value;
	
	private RechargeTypeEnum(String code, String msg) {
		this.code = code;
		this.value = msg;
	}
	
	public String getCode() {
		return code;
	}

	public String getValue() {
		return value;
	}
	
	public static boolean isRechargeType(String code) {
		for (RechargeTypeEnum v : RechargeTypeEnum.values()) {
			if (v.getCode().equals(code)) {
				return true;
			}
		}
		return false;
	}

	public static String getValueByCode(String code) {
		for (RechargeTypeEnum v : RechargeTypeEnum.values()) {
			if (v.getCode().equals(code)) {
				return v.getValue();
			}
		}
		return UNKNOWN.value;
	}
}
