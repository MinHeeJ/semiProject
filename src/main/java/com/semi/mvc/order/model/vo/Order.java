package com.semi.mvc.order.model.vo;

import java.sql.Date;

import com.semi.mvc.cart.model.vo.Cart;

public class Order extends Cart {
	private int orderNo;
	private Date orderDate;
	private String state;
	
	public Order() {
		super();
	}
	
	public Order(int cartNo, String product, String memberId, int count, int price) {
		super(cartNo, product, memberId, count, price);
	}

	public Order(int orderNo, String memberId, int cartNo, String product, Date orderDate, String state, int count, int price) {
		super(cartNo, product, memberId, count, price);
		this.orderNo = orderNo;
		this.orderDate = orderDate;
		this.state = state;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", orderDate=" + orderDate + ", state=" + state + ", toString()="
				+ super.toString() + "]";
	}
	
}
