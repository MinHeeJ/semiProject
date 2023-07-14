package com.semi.mvc.review.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.semi.mvc.review.model.exception.ReviewException;
import com.semi.mvc.review.model.vo.AttachmentReview;
import com.semi.mvc.review.model.vo.Review;

public class ReviewDao {
	private Properties prop = new Properties();
		
		public ReviewDao() {
			String filename = 
				ReviewDao.class.getResource("/sql/review/review-query.properties").getPath();
			try {
				prop.load(new FileReader(filename));
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
	public int insertReview(Connection conn, Review review) {
		int result = 0;
		String sql = prop.getProperty("insertReview");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			
			pstmt.setString(1, review.getWriter());
			pstmt.setString(2, review.getTitle());
			pstmt.setString(3, review.getContent());
			
			result = pstmt.executeUpdate(); 
			
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		
		return result;
	}

	public int getLastReviewNo(Connection conn) {
		int reviewNo = 0;
		String sql = prop.getProperty("getLastReviewNo");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			try (ResultSet rset = pstmt.executeQuery()) {
				if(rset.next()) {
					reviewNo = rset.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		
		return reviewNo;
	}

	public int insertAttachment(Connection conn, AttachmentReview attach) {
		int result = 0;
		String sql = prop.getProperty("insertAttachment");
		// insert into attachment_review(no, review_no, original_filename, renamed_filename) values(seq_attachment_review_no.nextval, ?, ?, ?)
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, attach.getReviewNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return result;
	}

}
