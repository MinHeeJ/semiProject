package com.semi.mvc.cart.model.vo;

public class Cart {

	private int cartNo;
	private String product;
	private String memberId; 
	private int count;
	private int price;
	
	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Cart(int cartNo, String product, String memberId, int count, int price) {
		super();
		this.cartNo = cartNo;
		this.product = product;
		this.memberId = memberId;
		this.count = count;
		this.price = price;
	}

	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", product=" + product + ", memberId=" + memberId + ", count=" + count
				+ ", price=" + price + "]";
	}
	
	
	
}
