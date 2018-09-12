package com.silverfox.finance.domain;

import java.io.Serializable;
import java.util.Date;

public class Lottery implements Serializable {
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String category;
	private int totalNumber;
	private String begin;
	private String end;
	private int status;
	private int frequency;
	private int silverCost;
	private String image;
	private int shareGetSilver;
	private int shareMaximumSilver;
	private int scene;
	private Date auditTime;

	public Lottery() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(Date auditTime) {
		this.auditTime = auditTime;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getTotalNumber() {
		return totalNumber;
	}

	public void setTotalNumber(int totalNumber) {
		this.totalNumber = totalNumber;
	}

	public int getShareGetSilver() {
		return shareGetSilver;
	}

	public void setShareGetSilver(int shareGetSilver) {
		this.shareGetSilver = shareGetSilver;
	}

	public int getShareMaximumSilver() {
		return shareMaximumSilver;
	}

	public void setShareMaximumSilver(int shareMaximumSilver) {
		this.shareMaximumSilver = shareMaximumSilver;
	}

	public int getScene() {
		return scene;
	}

	public void setScene(int scene) {
		this.scene = scene;
	}

	public String getBegin() {
		return begin;
	}

	public void setBegin(String begin) {
		this.begin = begin;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getFrequency() {
		return frequency;
	}

	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}

	public int getSilverCost() {
		return silverCost;
	}

	public void setSilverCost(int silverCost) {
		this.silverCost = silverCost;
	}
}