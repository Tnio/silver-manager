package com.silverfox.finance.domain;

import java.io.Serializable;

public class SignInPrize implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private SignIn signIn;
	private int days;
	private String question;
	private String answerA;
	private String answerB;
	private String answerC;
	private String answerD;
	private int rightAnswer;
	private float giveNum;
	private int giveType;
	private Coupon coupon;

	public SignInPrize() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswerA() {
		return answerA;
	}

	public void setAnswerA(String answerA) {
		this.answerA = answerA;
	}

	public String getAnswerB() {
		return answerB;
	}

	public void setAnswerB(String answerB) {
		this.answerB = answerB;
	}

	public String getAnswerC() {
		return answerC;
	}

	public void setAnswerC(String answerC) {
		this.answerC = answerC;
	}

	public String getAnswerD() {
		return answerD;
	}

	public void setAnswerD(String answerD) {
		this.answerD = answerD;
	}

	public int getRightAnswer() {
		return rightAnswer;
	}

	public void setRightAnswer(int rightAnswer) {
		this.rightAnswer = rightAnswer;
	}

	public float getGiveNum() {
		return giveNum;
	}

	public void setGiveNum(float giveNum) {
		this.giveNum = giveNum;
	}

	public int getGiveType() {
		return giveType;
	}

	public void setGiveType(int giveType) {
		this.giveType = giveType;
	}

	public Coupon getCoupon() {
		return coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public SignIn getSignIn() {
		return signIn;
	}

	public void setSignIn(SignIn signIn) {
		this.signIn = signIn;
	}
}
