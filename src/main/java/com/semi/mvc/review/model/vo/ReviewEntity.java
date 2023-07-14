package com.semi.mvc.review.model.vo;

import java.sql.Date;

public class ReviewEntity {
	private int reviewNo;
	private String writer;
	private String title;
	private String content;
	private Date regDate;

	public ReviewEntity() {
		super();
	}

	public ReviewEntity(int reviewNo, String writer, String title, String content, Date regDate) {
		super();
		this.reviewNo = reviewNo;
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

	@Override
	public String toString() {
		return "ReviewEntity [reviewNo=" + reviewNo + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", regDate=" + regDate + "]";
	}
	

	
}
