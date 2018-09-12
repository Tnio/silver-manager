package com.silverfox.finance.enumeration;

public enum SilverUsedSourceEnum {
    RACE(50,"0元夺宝消耗"),
    TELEPHONEFARE(51,"兑换话费消耗"),
    GAME(52,"玩游戏消耗"),
    LOTTERY(53,"抽奖消耗"),
    MALLEXCHANGE(54,"银子商城兑换"),

    EXCHANGEENTITY(5401,"银子商城兑换-实物"),
    EXCHANGEINVENTED(5402,"银子商城兑换-虚拟"),
    EXCHANGETHIRD(5403,"银子商城兑换-第三方");

    private int value;
    private String name;

    private SilverUsedSourceEnum(int value, String name){
        this.value = value;
        this.name = name;
    }

    public int getValue(){
        return this.value;
    }

    public String getName(){
        return this.name;
    }

    public static String getChannelByValue(int value) {
        for (SilverUsedSourceEnum c : SilverUsedSourceEnum.values()) {
            if (c.value == value) {
                return c.name;
            }
        }
        return "";
    }
}
