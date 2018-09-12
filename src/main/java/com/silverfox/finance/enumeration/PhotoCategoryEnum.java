package com.silverfox.finance.enumeration;

public enum PhotoCategoryEnum {
    ALBUM(0),
    START(1),
    LOGIN(2),
    NAVIGATION(3),
	VIPPICTURE(8);   
    private int type;

    private PhotoCategoryEnum(int type){
        this.type = type;
    }

    public int value(){

        return this.type;
    }
}
