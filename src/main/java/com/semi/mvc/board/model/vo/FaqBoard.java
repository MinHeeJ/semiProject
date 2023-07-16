package com.semi.mvc.board.model.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class FaqBoard {
	private int boardNo;
	private String writer;
	private String title;
	private String content;
	private Date regDate;
	private List<Attachment> attachments = new ArrayList<>();
	
	public FaqBoard() {
		// TODO Auto-generated constructor stub
	}

	public FaqBoard(int boardNo, String writer, String title, String content, Date regDate) {
		super();
		this.boardNo = boardNo;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.regDate = regDate;
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
	
	public void addAttachment(Attachment attach) {
		if(attach != null)
			this.attachments.add(attach);
	}
	
	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	@Override
	public String toString() {
		return "FaqBoard [boardNo=" + boardNo + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", regDate=" + regDate + "]";
	}
	
}

