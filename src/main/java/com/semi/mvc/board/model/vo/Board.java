package com.semi.mvc.board.model.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Board {
	private int boardNo;
	private String writer;
	private String title;
	private String content;
	private Date regDate;
	private int attachCnt;
	private List<Attachment> attachments = new ArrayList<>();
	private int commentCnt;
	
	public Board() {
		// TODO Auto-generated constructor stub
	}

	public Board(int boardNo, String writer, String title, String content, Date regDate, int attachCnt,
			List<Attachment> attachments, int commentCnt) {
		super();
		this.boardNo = boardNo;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.regDate = regDate;
		this.attachCnt = attachCnt;
		this.attachments = attachments;
		this.commentCnt = commentCnt;
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

	public int getAttachCnt() {
		return attachCnt;
	}

	public void setAttachCnt(int attachCnt) {
		this.attachCnt = attachCnt;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", regDate=" + regDate + ", attachCnt=" + attachCnt + ", attachments=" + attachments + ", commentCnt="
				+ commentCnt + "]";
	}
	
}
