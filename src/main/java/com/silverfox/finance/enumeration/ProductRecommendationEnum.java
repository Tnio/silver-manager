package com.silverfox.finance.enumeration;

public enum ProductRecommendationEnum {
	CANCELED(0),
	RECOMMEND(1);
	
	int value;
	
	private ProductRecommendationEnum(int value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return String.valueOf(value);
	}
}