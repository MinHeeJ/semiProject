package com.semi.mvc.board.model.vo;

import java.sql.Date;

public class BoardComment {
	private int commentNO;
	private String writer;
	private String content;
	private int commentLevel;
	private int commentRef;
	private Date regDate;
	
	public BoardComment() {
		// TODO Auto-generated constructor stub
	}

	public BoardComment(int commentNO, String writer, String content, int commentLevel, int commentRef, Date regDate) {
		super();
		this.commentNO = commentNO;
		this.writer = writer;
		this.content = content;
		this.commentLevel = commentLevel;
		this.commentRef = commentRef;
		this.regDate = regDate;
	}

	public int getCommentNO() {
		return commentNO;
	}

	public void setCommentNO(int commentNO) {
		this.commentNO = commentNO;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCommentLevel() {
		return commentLevel;
	}

	public void setCommentLevel(int commentLevel) {
		this.commentLevel = commentLevel;
	}

	public int getCommentRef() {
		return commentRef;
	}

	public void setCommentRef(int commentRef) {
		this.commentRef = commentRef;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "BoardComment [commentNO=" + commentNO + ", writer=" + writer + ", content=" + content
				+ ", commentLevel=" + commentLevel + ", commentRef=" + commentRef + ", regDate=" + regDate + "]";
	}
	
	
}
