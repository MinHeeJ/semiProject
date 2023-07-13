package com.semi.mvc.order.model.vo;

public enum State {
	orderComplete("주문접수완료"),
	complete("주문처리완료");

	private String state; // state선언

	State(String state) {
		this.state = state;
	}
	
	public String getState() {
		return this.state;
	}
	
}
