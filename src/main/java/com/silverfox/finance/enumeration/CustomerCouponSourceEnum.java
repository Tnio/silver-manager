package com.silverfox.finance.enumeration;

public enum  CustomerCouponSourceEnum {
    LOTTERY(1, "抽奖活动"),
    REBATE(2,"投资返利"),
    SILVERGOODS(3,"银子商城兑换"),
    CHANNEL(4, "渠道奖励"),
    COUPONGIVE(5, "系统赠送"),
    INVITATION(6, "邀请奖励"),
    REGISTER(7,"新用户注册"),
    FIRSTTRAD(8,"首次投资赠送"),
    SHARE(9,"分享奖励"),
    BIRTHDAY(10,"生日福利"),
    SIGNIN(11,"签到奖励"),
    VOUCHER(12,"兑换奖励"),
    GRABCOUPON (13,"抢红包活动"),
    /*FIRSTORDER (14,"首单"),
    ENDORDER(15,"尾单"),*/
    FRIENDSGIVE(14,"好友转赠"),
    GAME(15,"游戏奖励"),
    NEWYEAR(16,"新年红包"),
	INVITATION_NO_SHARE(17, "红包奖励"),
	PAYBACK_REWARD(18, "回款奖励"),
	OPEN_COUPON_ACTIVITY(19, "回款奖励"),
	VIP_BIRTHDAY_COUPON(20,"VIP生日红包"),
	VIP1_COUPON(21,"VIP1专享"),
	VIP2_COUPON(22,"VIP2专享"),
	VIP3_COUPON(23,"VIP3专享"),
	VIP4_COUPON(24,"VIP4专享"),
	VIP5_COUPON(25,"VIP5专享"),
	VIP6_COUPON(26,"VIP6专享"),
	VIP7_COUPON(27,"VIP7专享"),
	VIP8_COUPON(28,"VIP8专享");
	

    private final int value;
    private final String msg;


    CustomerCouponSourceEnum(int value, String msg){
        this.value = value;
        this.msg = msg;
    }

    public static String getMsgByValue(int value) {
        for (CustomerCouponSourceEnum source : CustomerCouponSourceEnum.values()) {
            if (source.getValue() == value) {
                return source.getMsg();
            }
        }
		/*if(value == 3){
			return INVITATION.getMsg();
		}*/
        return "未定义红包";
    }

    public int getValue(){
        return this.value;
    }

    public String getMsg(){
        return this.msg;
    }
}
