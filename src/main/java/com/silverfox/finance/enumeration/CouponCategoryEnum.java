package com.silverfox.finance.enumeration;

public enum CouponCategoryEnum {
	FIXATION(0, "固定红包", 1),
	PROBABILITY(1, "概率红包", 1),
	AGGREGATE(2, "邀请累计红包", 2),
	VOUCHER(3, "红包兑换券", 1),
	COUPON(4, "加息券", 1),
	COUPONVOUCHER(5, "加息兑换券", 1);
	
	private final int value;
	private final String msg;
	private final int category;
	
	CouponCategoryEnum(int value, String msg, int category){
		this.value = value;
		this.msg = msg;
		this.category = category;
	}
	
	public int getValue(){
		return this.value;
	}
	
	public String getMsg(){
		return this.msg;
	}
	
	public int getCategory(){
		return this.category;
	}
}
