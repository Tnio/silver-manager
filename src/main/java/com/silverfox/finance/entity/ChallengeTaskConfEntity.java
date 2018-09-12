package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

public class ChallengeTaskConfEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private Control control;
	private LinkedList<Tasks> Tasks;
	private LinkedList<Trade> trades;
	private LinkedList<QA> QAs;
	private String keys;

	public static class Control {
		private String beginTime;
		private int quantity;
		private int TaskSilver;
		private int changeSilver;

		public String getBeginTime() {
			return beginTime;
		}

		public void setBeginTime(String beginTime) {
			this.beginTime = beginTime;
		}

		public int getQuantity() {
			return quantity;
		}

		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}

		public int getTaskSilver() {
			return TaskSilver;
		}

		public void setTaskSilver(int taskSilver) {
			TaskSilver = taskSilver;
		}

		public int getChangeSilver() {
			return changeSilver;
		}

		public void setChangeSilver(int changeSilver) {
			this.changeSilver = changeSilver;
		}
	}

	public static class Tasks implements Serializable {
		private static final long serialVersionUID = 1L;
		private int number;
		private String describe;

		public int getNumber() {
			return number;
		}

		public void setNumber(int number) {
			this.number = number;
		}

		public String getDescribe() {
			return describe;
		}

		public void setDescribe(String describe) {
			this.describe = describe;
		}
	}

	public static class Trade implements Serializable {
		private static final long serialVersionUID = 1L;
		private int number;
		private String describe;
		private int financePeriod;
		private int tradeMoney;

		public int getNumber() {
			return number;
		}

		public void setNumber(int number) {
			this.number = number;
		}

		public int getFinancePeriod() {
			return financePeriod;
		}

		public void setFinancePeriod(int financePeriod) {
			this.financePeriod = financePeriod;
		}

		public int getTradeMoney() {
			return tradeMoney;
		}

		public void setTradeMoney(int tradeMoney) {
			this.tradeMoney = tradeMoney;
		}

		public String getDescribe() {
			return describe;
		}

		public void setDescribe(String describe) {
			this.describe = describe;
		}
	}

	public static class QA implements Serializable {
		private static final long serialVersionUID = 1L;
		private int number;
		private String questions;
		private String answers;
		private String rightKey;

		public int getNumber() {
			return number;
		}

		public void setNumber(int number) {
			this.number = number;
		}

		public String getQuestions() {
			return questions;
		}

		public void setQuestions(String questions) {
			this.questions = questions;
		}

		public String getAnswers() {
			return answers;
		}

		public void setAnswers(String answers) {
			this.answers = answers;
		}

		public String getRightKey() {
			return rightKey;
		}

		public void setRightKey(String rightKey) {
			this.rightKey = rightKey;
		}

	}

	public static class CustomerTasks {
		int number;
		String Type;
		String describe;
		String remark;
		int status;
		String beginTime;

		public CustomerTasks() {

		}

		public CustomerTasks(int number, String type, String describe, String remark, int status, String beginTime) {
			this.number = number;
			this.Type = type;
			this.describe = describe;
			this.remark = remark;
			this.status = status;
			this.beginTime = beginTime;
		}

		public int getNumber() {
			return number;
		}

		public void setNumber(int number) {
			this.number = number;
		}

		public String getDescribe() {
			return describe;
		}

		public void setDescribe(String describe) {
			this.describe = describe;
		}

		public String getType() {
			return Type;
		}

		public void setType(String type) {
			Type = type;
		}

		public String getRemark() {
			return remark;
		}

		public void setRemark(String remark) {
			this.remark = remark;
		}

		public int getStatus() {
			return status;
		}

		public void setStatus(int status) {
			this.status = status;
		}

		public String getBeginTime() {
			return beginTime;
		}

		public void setBeginTime(String beginTime) {
			this.beginTime = beginTime;
		}
	}

	public Control getControl() {
		return control;
	}

	public void setControl(Control control) {
		this.control = control;
	}

	public List<Tasks> getTasks() {
		return Tasks;
	}

	public LinkedList<Trade> getTrades() {
		return trades;
	}

	public void setTrades(LinkedList<Trade> trades) {
		this.trades = trades;
	}

	public LinkedList<QA> getQAs() {
		return QAs;
	}

	public void setQAs(LinkedList<QA> qAs) {
		QAs = qAs;
	}

	public void setTasks(LinkedList<Tasks> tasks) {
		Tasks = tasks;
	}

	public String getKeys() {
		return keys;
	}

	public void setKeys(String keys) {
		this.keys = keys;
	}
}
