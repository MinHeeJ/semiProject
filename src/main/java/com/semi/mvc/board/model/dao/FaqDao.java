package com.semi.mvc.board.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.semi.mvc.board.model.exception.FaqException;
import com.semi.mvc.board.model.vo.FaqBoard;

public class FaqDao {
	private Properties prop = new Properties();
	
	public FaqDao() {
		String filename = 
				FaqDao.class.getResource("/sql/board/board-query.properties").getPath();
			try {
				prop.load(new FileReader(filename));
			} catch (IOException e) {
				e.printStackTrace();
			}
	}

	public int insertFaq(Connection conn, FaqBoard faq) {
		int result = 0;
		String sql = prop.getProperty("insertBoard");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, faq.getWriter());
			pstmt.setString(2, faq.getTitle());
			pstmt.setString(3, faq.getContent());
			
			result = pstmt.executeUpdate(); 
		} catch (SQLException e) {
			throw new FaqException(e);
		}
		
		return result;
	}

	public int faqUpdate(Connection conn, FaqBoard faq) {
		int result = 0;
		String query = prop.getProperty("updateFaq");

		try (PreparedStatement pstmt = conn.prepareStatement(query)) {
			pstmt.setString(1, faq.getTitle());
			pstmt.setString(2, faq.getContent());
			pstmt.setInt(3, faq.getBoardNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new FaqException(e);
		} 
		return result;
	}

	public int faqDelete(Connection conn, int boardNo) {
		int result = 0;
		String sql = prop.getProperty("deleteFaq");

		try (PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setInt(1, boardNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new FaqException(e);
		} 
		return result;
	}

}
