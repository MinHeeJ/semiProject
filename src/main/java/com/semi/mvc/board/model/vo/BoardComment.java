package com.semi.mvc.board.model.vo;

import java.sql.Date;

public class BoardComment {
	private int commentNo;
	private int boardNo;
	private String writer;
	private String content;
	private Date regDate;
	
	public BoardComment() {
		// TODO Auto-generated constructor stub
	}

	public BoardComment(int commentNo, int boardNo, String writer, String content, Date regDate) {
		super();
		this.commentNo = commentNo;
		this.boardNo = boardNo;
		this.writer = writer;
		this.content = content;
		this.regDate = regDate;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
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

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "BoardComment [commentNo=" + commentNo + ", boardNo=" + boardNo + ", writer=" + writer + ", content="
				+ content + ", regDate=" + regDate + ", getCommentNo()=" + getCommentNo() + ", getBoardNo()="
				+ getBoardNo() + ", getWriter()=" + getWriter() + ", getContent()=" + getContent() + ", getRegDate()="
				+ getRegDate() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}

}
