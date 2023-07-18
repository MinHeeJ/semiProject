package com.semi.mvc.board.model.service;

import static com.semi.mvc.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.semi.mvc.board.model.dao.BoardDao;
import com.semi.mvc.board.model.vo.Attachment;
import com.semi.mvc.board.model.vo.Board;
import com.semi.mvc.board.model.vo.BoardComment;

public class BoardService {
	private final BoardDao boardDao = new BoardDao();

	public List<Board> findAll(int start, int end) {
		Connection conn = getConnection();
		List<Board> boards = boardDao.findAll(conn, start, end);
		close(conn);
		return boards;
	}

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = boardDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	public Board findById(int no) {
		Connection conn = getConnection();
		Board board = boardDao.findById(conn, no);
		List<Attachment> attachments = boardDao.findAttachmentByBoardNo(conn, no);
		board.setAttachments(attachments);
		close(conn);
		return board;
	}

	public List<BoardComment> findBoardCommentByBoardNo(int no) {
		Connection conn = getConnection();
		List<BoardComment> boardComments = boardDao.findBoardCommentByBoardNo(conn, no);
		close(conn);
		return boardComments;
	}

	public int insertBoard(Board board) {
		int result = 0;
		Connection conn = getConnection();
		try {
			
			// board 테이블 추가
			result = boardDao.insertBoard(conn, board);
			
			// 발급된 board.no를 조회
			int boardNo = boardDao.getLastBoardNo(conn);
			board.setBoardNo(boardNo); // servlet에서 redirect시 사용
			System.out.println("boardNo = " + boardNo);
			
			// attachment 테이블 추가
			List<Attachment> attachments = board.getAttachments();
			if (attachments != null && !attachments.isEmpty()) {
				for(Attachment attach : attachments) {
					attach.setBoardNo(boardNo); // fk컬럼값 세팅
					result = boardDao.insertAttachment(conn, attach);					
				}
			}
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	}

	public int updateBoard(Board board) {
		int result = 0;
		Connection conn = getConnection();
		try {
			
			// board 테이블 추가
			result = boardDao.updateBoard(conn, board);
			
			// attachment 테이블 추가
			List<Attachment> attachments = board.getAttachments();
			if (attachments != null && !attachments.isEmpty()) {
				for(Attachment attach : attachments) {
					result = boardDao.insertAttachment(conn, attach);					
				}
			}
			commit(conn);
			System.out.println("update commit");
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	}

	public Attachment findAttachmentById(int attachNo) {
		Connection conn = getConnection();
		Attachment attach = boardDao.findAttachmentById(conn, attachNo);
		close(conn);
		return attach;
	}

	public int deleteAttachment(int attachNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = boardDao.deleteAttachment(conn, attachNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

}
