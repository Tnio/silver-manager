package com.silverfox.finance.entity;

import java.io.Serializable;
import java.util.List;

public class DekaronTaskConfEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	private Control control;
	private List<Tasks> Tasks;
	private List<Trade> trades;
	private List<QA> QAs;
	private String keys;

	public static class Control {
		private String beginTime;
		private int quantity;

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
	}

	public static class Tasks {
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

	public static class Trade {
		private int number;
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
	}

	public static class QA {
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

	public Control getControl() {
		return control;
	}

	public void setControl(Control control) {
		this.control = control;
	}

	public List<Tasks> getTasks() {
		return Tasks;
	}

	public void setTasks(List<Tasks> tasks) {
		Tasks = tasks;
	}

	public List<Trade> getTrades() {
		return trades;
	}

	public void setTrades(List<Trade> trades) {
		this.trades = trades;
	}

	public List<QA> getQAs() {
		return QAs;
	}

	public void setQAs(List<QA> qAs) {
		QAs = qAs;
	}

	public String getKeys() {
		return keys;
	}

	public void setKeys(String keys) {
		this.keys = keys;
	}
}
