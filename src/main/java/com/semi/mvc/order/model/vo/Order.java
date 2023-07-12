package com.semi.mvc.order.model.vo;

import java.sql.Date;

import com.semi.mvc.cart.model.vo.Cart;

public class Order extends Cart {
	private int orderNo;
	private Date orderDate;
	private State state;
	private int orderSerialNo;
	
	public Order() {
		super();
	}
	
	public Order(int cartNo, String product, String memberId, int count, int price) {
		super(cartNo, product, memberId, count, price);
	}

	public Order(int cartNo, String product, String memberId, int count, int price, int orderNo, Date orderDate,
			State state, int orderSerialNo) {
		super(cartNo, product, memberId, count, price);
		this.orderNo = orderNo;
		this.orderDate = orderDate;
		this.state = state;
		this.orderSerialNo = orderSerialNo;
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

	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}

	public int getOrderSerialNo() {
		return orderSerialNo;
	}

	public void setOrderSerialNo(int orderSerialNo) {
		this.orderSerialNo = orderSerialNo;
	}

	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", orderDate=" + orderDate + ", state=" + state + ", orderSerialNo="
				+ orderSerialNo + ", toString()=" + super.toString() + "]";
	}

}
