package com.semi.mvc.cart.model.vo;

import java.util.ArrayList;
import java.util.List;

public class Cart {

	private int cartNo;
	private String product;
	private String memberId; 
	private int count;
	private int price;
	private List<SelectedOption> optionList = new ArrayList<>();
	
	public Cart() {
		super();
	}
	

	public Cart(int cartNo, String product, String memberId, int count, int price) {
		super();
		this.cartNo = cartNo;
		this.product = product;
		this.memberId = memberId;
		this.count = count;
		this.price = price;
	}



	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public List<SelectedOption> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<SelectedOption> optionList) {
		this.optionList = optionList;
	}

	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", product=" + product + ", memberId=" + memberId + ", count=" + count
				+ ", price=" + price + ", optionList=" + optionList + "]";
	}

	
	
	
}
