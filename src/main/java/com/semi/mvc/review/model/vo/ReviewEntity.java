package com.semi.mvc.review.model.vo;

import java.sql.Date;

public class ReviewEntity {
	private int reviewNo;
	private int orderSerialNo;
	private String writer;
	private String title;
	private String content;
	private Date regDate;
	private String product;

	public ReviewEntity() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ReviewEntity(int reviewNo, int orderSerialNo, String writer, String title, String content, Date regDate) {
		super();
		this.reviewNo = reviewNo;
		this.orderSerialNo = orderSerialNo;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.regDate = regDate;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getOrderSerialNo() {
		return orderSerialNo;
	}

	public void setOrderSerialNo(int orderSerialNo) {
		this.orderSerialNo = orderSerialNo;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	@Override
	public String toString() {
		return "ReviewEntity [reviewNo=" + reviewNo + ", orderSerialNo=" + orderSerialNo + ", writer=" + writer
				+ ", title=" + title + ", content=" + content + ", regDate=" + regDate + "]";
	}

	
	
}
