package com.semi.mvc.review.model.vo;

import java.sql.Date;

public class AttachmentReview {
	private int no;
	private int reviewNo;
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
	
	public AttachmentReview() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AttachmentReview(int no, int reviewNo, String originalFilename, String renamedFilename, Date regDate) {
		super();
		this.no = no;
		this.reviewNo = reviewNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.regDate = regDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getRenamedFilename() {
		return renamedFilename;
	}

	public void setRenamedFilename(String renamedFilename) {
		this.renamedFilename = renamedFilename;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "AttachmentReview [no=" + no + ", reviewNo=" + reviewNo + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename + ", regDate=" + regDate + "]";
	}
	
	
	
	
}
                           