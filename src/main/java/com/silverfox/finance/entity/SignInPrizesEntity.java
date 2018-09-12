package com.silverfox.finance.entity;

import java.io.Serializable;

public class SignInPrizesEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private Integer[] signInPrizesId;
	private Integer[] signInId;
	private Integer[] days;
	private String[] question;
	private String[] answerA;
	private String[] answerB;
	private String[] answerC;
	private String[] answerD;
	private Integer[] rightAnswer;
	private Integer[] giveSilver;
	private Integer[] giveBonus;
	private Float[] giveCoupon;
	private Float[] giveNum;
	private Integer[] giveType;
	private Integer[] couponId;

	public SignInPrizesEntity() {

	}

	public Integer[] getSignInPrizesId() {
		return signInPrizesId;
	}

	public void setSignInPrizesId(Integer[] signInPrizesId) {
		this.signInPrizesId = signInPrizesId;
	}

	public Integer[] getSignInId() {
		return signInId;
	}

	public void setSignInId(Integer[] signInId) {
		this.signInId = signInId;
	}

	public Integer[] getDays() {
		return days;
	}

	public void setDays(Integer[] days) {
		this.days = days;
	}

	public String[] getQuestion() {
		return question;
	}

	public void setQuestion(String[] question) {
		this.question = question;
	}

	public String[] getAnswerA() {
		return answerA;
	}

	public void setAnswerA(String[] answerA) {
		this.answerA = answerA;
	}

	public String[] getAnswerB() {
		return answerB;
	}

	public void setAnswerB(String[] answerB) {
		this.answerB = answerB;
	}

	public String[] getAnswerC() {
		return answerC;
	}

	public void setAnswerC(String[] answerC) {
		this.answerC = answerC;
	}

	public String[] getAnswerD() {
		return answerD;
	}

	public void setAnswerD(String[] answerD) {
		this.answerD = answerD;
	}

	public Integer[] getRightAnswer() {
		return rightAnswer;
	}

	public void setRightAnswer(Integer[] rightAnswer) {
		this.rightAnswer = rightAnswer;
	}

	public Integer[] getGiveSilver() {
		return giveSilver;
	}

	public void setGiveSilver(Integer[] giveSilver) {
		this.giveSilver = giveSilver;
	}

	public Integer[] getGiveBonus() {
		return giveBonus;
	}

	public void setGiveBonus(Integer[] giveBonus) {
		this.giveBonus = giveBonus;
	}

	public Float[] getGiveCoupon() {
		return giveCoupon;
	}

	public void setGiveCoupon(Float[] giveCoupon) {
		this.giveCoupon = giveCoupon;
	}

	public Float[] getGiveNum() {
		return giveNum;
	}

	public void setGiveNum(Float[] giveNum) {
		this.giveNum = giveNum;
	}

	public Integer[] getGiveType() {
		return giveType;
	}

	public void setGiveType(Integer[] giveType) {
		this.giveType = giveType;
	}

	public Integer[] getCouponId() {
		return couponId;
	}

	public void setCouponId(Integer[] couponId) {
		this.couponId = couponId;
	}
}
