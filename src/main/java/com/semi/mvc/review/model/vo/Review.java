package com.semi.mvc.review.model.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Review extends ReviewEntity {
	private int attachCnt;
	private List<AttachmentReview> attachments = new ArrayList<>();
	private int commentCnt;
	
	public Review() {
		// TODO Auto-generated constructor stub
	}

	public Review(int reviewNo, String writer, String title, String content, Date regDate) {
		super();
		// TODO Auto-generated constructor stub
	}


	public int getAttachCnt() {
		return attachCnt;
	}

	public void setAttachCnt(int attachCnt) {
		this.attachCnt = attachCnt;
	}

	public List<AttachmentReview> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<AttachmentReview> attachments) {
		this.attachments = attachments;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public void addAttachment(AttachmentReview attach) {
		if(attach != null)
			this.attachments.add(attach);
	}

	@Override
	public String toString() {
		return "Review [attachCnt=" + attachCnt + ", attachments=" + attachments + ", commentCnt=" + commentCnt 
				+ ", toString()=" + super.toString() + "]";
	}


	
}
