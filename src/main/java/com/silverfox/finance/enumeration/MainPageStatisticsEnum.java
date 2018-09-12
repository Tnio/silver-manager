package com.silverfox.finance.enumeration;

public enum MainPageStatisticsEnum {
    ALL("all"),
    CURRENT("current"),
    YESTODAY("yestoday"),
    TODAY("today");

    private String strategy;

    private MainPageStatisticsEnum(String strategy){

        this.strategy = strategy;
    }

    public String toString(){

        return this.strategy.toString();
    }
}
