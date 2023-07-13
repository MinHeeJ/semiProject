package com.semi.mvc.order.model.vo;

public enum State {
	orderComplete("주문완료"),
	preparing("준비중"),
	complete("준비완료");

	private String state; // state선언

	State(String state) {
		this.state = state;
	}
	
	public String getState() {
		return this.state;
	}
	
}
