package com.semi.mvc.cart.model.vo;

public class Ingredient {

	private int ingredientNo;
	private int categoryNo;
	private String ingredientName;
	private int calorie;
	private int price;
	


	public Ingredient() {
		super();
		// TODO Auto-generated constructor stub
	}



	
	public Ingredient(int ingredientNo, int categoryNo, String ingredientName, int calorie, int price) {
		super();
		this.ingredientNo = ingredientNo;
		this.categoryNo = categoryNo;
		this.ingredientName = ingredientName;
		this.calorie = calorie;
		this.price = price;
	}

	
	public int getIngredientNo() {
		return ingredientNo;
	}



	public void setIngredientNo(int ingredientNo) {
		this.ingredientNo = ingredientNo;
	}



	public int getCategoryNo() {
		return categoryNo;
	}



	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}



	public String getIngredientName() {
		return ingredientName;
	}



	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
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





	@Override
	public String toString() {
		return "Ingredient [ingredientNo=" + ingredientNo + ", categoryNo=" + categoryNo + ", ingredientName="
				+ ingredientName + ", calorie=" + calorie + ", price=" + price + "]";
	}
	
	
}
