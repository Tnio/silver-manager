package com.silverfox.finance.enumeration;

public enum CustomerMessageEnum {
	PAY_SUCCESS(1, "购买成功"),
	PRODUCT_INTEREST(2, "产品起息"),
	PRODUCT_EXPIRED(3, "产品到期"),
	PAYBACK_SUCCESS(4, "回款成功"),
	BAOBAO_PAY_SUCCESS(5, "购买成功"),
	ROLL_OUT(6, "转出"),
	ROLL_OUT_SUCCESS(7, "转出成功"),
	BONUS(8, "理财返利");
	
	
	private int scene;
	private String title;
	
	private CustomerMessageEnum(int scene, String title) {
		this.scene = scene;
		this.title = title;
	}
	
	public int getScene() {
		return scene;
	}
	
	public String getTitle() {
		return title;
	}
	
	public static String getTitle(int scene) {
		for (CustomerMessageEnum v : CustomerMessageEnum.values()) {
			if (v.getScene() == scene) {
				return v.getTitle();
			}
		}
		return "";
	}
}