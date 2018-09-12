package com.silverfox.finance.domain;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Faq implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	@NotNull
	@Size(min = 3, max = 20)
	private String ask;
	@NotNull
	@Size(min = 1, max = 500)
	private String question;
	private Integer sortNumber;
	private int enable;

	public Faq() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAsk() {
		return ask;
	}

	public void setAsk(String ask) {
		this.ask = ask;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public Integer getSortNumber() {
		return sortNumber;
	}

	public void setSortNumber(Integer sortNumber) {
		this.sortNumber = sortNumber;
	}

	public int getEnable() {
		return enable;
	}

	public void setEnable(int enable) {
		this.enable = enable;
	}

}