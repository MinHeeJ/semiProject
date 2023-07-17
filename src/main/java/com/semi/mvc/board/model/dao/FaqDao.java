package com.semi.mvc.board.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.semi.mvc.board.model.exception.FaqException;
import com.semi.mvc.board.model.vo.FaqBoard;

import oracle.jdbc.proxy.annotation.Pre;

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
		String sql = prop.getProperty("insertFaq");
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

	public List<FaqBoard> findFaqBoard(Connection conn) {
		List<FaqBoard> faqs = new ArrayList<>();
		String sql = prop.getProperty("findFaqBoard");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					FaqBoard faq = new FaqBoard();
					faq.setBoardNo(rset.getInt("board_no"));
					faq.setWriter(rset.getString("writer"));
					faq.setTitle(rset.getString("title"));
					faq.setContent(rset.getString("content"));
					faq.setRegDate(rset.getDate("reg_date"));
					faqs.add(faq);
				}
			}
		} catch (SQLException e) {
			throw new FaqException(e);
		}
		return faqs;
	}

	public FaqBoard findByBoardNo(Connection conn, int boardNo) {
		FaqBoard faq = new FaqBoard();
		String sql = prop.getProperty("findByBoardNo");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, boardNo);
			try (ResultSet rset = pstmt.executeQuery()){
				faq.setBoardNo(rset.getInt("board_no"));
				faq.setWriter(rset.getString("writer"));
				faq.setTitle(rset.getString("title"));
				faq.setContent(rset.getString("content"));
				faq.setRegDate(rset.getDate("reg_date"));
			}
		} catch (SQLException e) {
			throw new FaqException(e);
		}
		return faq;
	}

}
