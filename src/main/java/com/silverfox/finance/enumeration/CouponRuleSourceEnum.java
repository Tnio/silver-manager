package com.silverfox.finance.enumeration;

public enum CouponRuleSourceEnum {
	REGISTERED(1, "注册赠送", 0),
	FIRSTTRADE(2, "首次购买赠送", 0),
	INVITATION(3, "邀请好友赠送", 0),
	BEINVITE(4, "被邀请赠送", 0),
	ACTIVITY(5, "活动红包", 20),
	SHARE(6, "分享赠送", 1),
	HOLIDAY(7, "节日赠送", 1),
	BIRTHDAY(8, "生日赠送" , 1),
	VOUCHER(9, "红包兑换券", 3),
	PAYBACK_COUPON(10, "回款奖励", 0),
	CHANNEL_ONE(11, "一类渠道注册赠送", 0),
	CHANNEL_TWO(12, "二类渠道注册赠送", 0),
	CHANNEL_THREE(13, "三类渠道首投赠送", 0),
	VIP_EXCLUSIVE(14, "VIP专属优惠券", 1);
	
	private final int value;
	private final String msg;
	private final int category;
	
	CouponRuleSourceEnum(int value, String msg, int category){
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
