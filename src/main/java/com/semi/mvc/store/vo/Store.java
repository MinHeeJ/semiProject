package com.semi.mvc.store.vo;

public class Store {
	private int storeNo;
	private String storeName;
	private String address;
	private String phone;
	
	public Store() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Store(int storeNo, String storeName, String address, String phone) {
		super();
		this.storeNo = storeNo;
		this.storeName = storeName;
		this.address = address;
		this.phone = phone;
	}

	public int getStoreNo() {
		return storeNo;
	}

	public void setStoreNo(int storeNo) {
		this.storeNo = storeNo;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Override
	public String toString() {
		return "Store [storeNo=" + storeNo + ", storeName=" + storeName + ", address=" + address + ", phone=" + phone
				+ "]";
	}
	
	
	
}
