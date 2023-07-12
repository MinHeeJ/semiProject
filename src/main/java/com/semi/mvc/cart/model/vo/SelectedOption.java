package com.semi.mvc.cart.model.vo;

public class SelectedOption {
	
//	serial_no number,
//    member_id varchar2(20),
//	ingredient_no number,
//	count number null,
//	calorie number null,
//	price number null,
	
	private int serialNo;
	private String memberId;
	private int ingredientNo;
	private int count;
	private int calorie;
	private int price;
	
	
	
	public SelectedOption() {
		super();
		// TODO Auto-generated constructor stub
	}



	public SelectedOption(int serialNo, String memberId, int ingredientNo, int count, int calorie, int price) {
		super();
		this.serialNo = serialNo;
		this.memberId = memberId;
		this.ingredientNo = ingredientNo;
		this.count = count;
		this.calorie = calorie;
		this.price = price;
	}



	@Override
	public String toString() {
		return "SelectedOption [serialNo=" + serialNo + ", memberId=" + memberId + ", ingredientNo=" + ingredientNo
				+ ", count=" + count + ", calorie=" + calorie + ", price=" + price + "]";
	}



	public int getSerialNo() {
		return serialNo;
	}



	public void setSerialNo(int serialNo) {
		this.serialNo = serialNo;
	}



	public String getMemberId() {
		return memberId;
	}



	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}



	public int getIngredientNo() {
		return ingredientNo;
	}



	public void setIngredientNo(int ingredientNo) {
		this.ingredientNo = ingredientNo;
	}



	public int getCount() {
		return count;
	}



	public void setCount(int count) {
		this.count = count;
	}



	public int getCalorie() {
		return calorie;
	}



	public void setCalorie(int calorie) {
		this.calorie = calorie;
	}



	public int getPrice() {
		return price;
	}



	public void setPrice(int price) {
		this.price = price;
	}
	
	
	
}
