package com.silverfox.finance.enumeration;

public enum SilverGainSourceEnum {
	REGISTER(1,"注册赠送"),
	SIGNIN(2,"签到"),
	ACTIVITY(3,"活动赠送"),
	REBATE(4,"返利活动"),
	LOTTERY(5,"抽奖活动"),
	SHARE(6,"抽奖活动分享"),
	EVERYDAY_SHARE(7,"每日分享"),
	FIRST(8,"首单立返"),
	LAST(9,"尾单立返"),
	INVITE(10,"邀请奖励"),
	BIRTHDAY(11,"生日奖励"),
	FIRSTTRADE(12,"首次购买奖励"),
	SIGNINREWARD(13,"签到奖励"),
	SYSTEMGIVE(14,"系统赠送"),
	SIGNIN_PATCH(15, "补签"),
	
	DAILY(501,"日常活动"),
	BOARD_TURNING(502,"翻牌活动"),
	CHANNEL(503,"渠道活动"),
	SILVERGOODS(504,"银子商城");
	
	private int value;
	
	private String name;
	
	private SilverGainSourceEnum(int value, String name){
		this.name = name;
		this.value = value;
	}
	
	public int getValue(){
		return this.value;
	}
	
	public String getName(){
		return this.name;
	}
	
	public static String getChannelByValue(int value) {
		for (SilverGainSourceEnum c : SilverGainSourceEnum.values()) {
			if (c.value == value) {
				return c.name;
			}
		}
		return "";
	}
}
