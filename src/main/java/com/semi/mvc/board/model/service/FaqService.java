package com.semi.mvc.board.model.service;

import static com.semi.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.semi.mvc.board.model.dao.FaqDao;
import com.semi.mvc.board.model.vo.FaqBoard;

public class FaqService {
	private final FaqDao faqDao = new FaqDao();

	public FaqBoard findById(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}
	public int insertFaq(FaqBoard faq) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = faqDao.insertFaq(conn, faq);
			
			// Attachment
//			int boardNo = boardDao.getLastBoardNo(conn);
//			board.setNo(boardNo); // servlet에서 redirect시 사용
//			System.out.println("boardNo = " + boardNo);
//			
//			// attachment 테이블 추가
//			List<Attachment> attachments = board.getAttachments();
//			if (attachments != null && !attachments.isEmpty()) {
//				for(Attachment attach : attachments) {
//					attach.setBoardNo(boardNo); // fk컬럼값 세팅
//					result = boardDao.insertAttachment(conn, attach);					
//				}
//			}
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int faqUpdate(FaqBoard faq) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = faqDao.faqUpdate(conn, faq);
			
			// attachment 테이블 추가
//			List<Attachment> attachments = board.getAttachments();
//			if (attachments != null && !attachments.isEmpty()) {
//				for(Attachment attach : attachments) {
//					result = boardDao.insertAttachment(conn, attach);					
//				}
//			}
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int faqDelete(int boardNo) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = faqDao.faqDelete(conn, boardNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return 0;
	}

}
