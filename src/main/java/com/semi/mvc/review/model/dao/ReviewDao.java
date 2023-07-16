package com.semi.mvc.review.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.semi.mvc.member.model.vo.Member;
import com.semi.mvc.order.model.exception.OrderException;
import com.semi.mvc.order.model.vo.Order;
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
			pstmt.setInt(4, review.getOrderSerialNo());
			
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

	public List<Review> findReview(Connection conn, int start, int end) {
		List<Review> reviews = new ArrayList<>();
		List<Review> re = new ArrayList<>();
		String sql = prop.getProperty("findReview");
		System.out.println("sql = " + sql);
		System.out.println("start = "+ start);
		System.out.println("end = "+ end);
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			try(ResultSet rset = pstmt.executeQuery()) {
				System.out.println("rset = " + rset);
				while(rset.next()) {
					Review result = new Review();
					result.setReviewNo(rset.getInt("review_no"));
					result.setWriter(rset.getString("writer"));					
					result.setTitle(rset.getString("title"));
					result.setContent(rset.getString("content"));
					result.setRegDate(rset.getDate("reg_date"));
					result.setProduct(rset.getString("product"));
					System.out.println(result);
					reviews.add(result);
							
 					//reviews.add(handleReviewResultSet(rset));
				}
				
			}
			
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		System.out.println("reviews = " + reviews);
		return reviews;
	}

	private Review handleReviewResultSet(ResultSet rset) throws SQLException {
		int reviewNo = rset.getInt("review_no");
		String writer = rset.getString("writer");
		String title = rset.getString("title");
		String content = rset.getString("content");
		Date regDate = rset.getDate("reg_date");
		return new Review(reviewNo, writer, title, content, regDate);
				
				
	}

	public int getTotalContent(Connection conn) {
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContent");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			try (ResultSet rset = pstmt.executeQuery()) {
				if(rset.next())
					totalContent = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return totalContent;
	}

	public List<Order> reviewOrderList(Connection conn,String memberId) {
		List<Order> orders = new ArrayList<>();
		String sql = prop.getProperty("reviewOrderList");
		System.out.println(sql);
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
		
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					System.out.println("여여여영여 =");
//					Order order = handleOrderResultSet(rset);
//					orders.add(order);
					Order order = new Order();
					order.setProduct(rset.getString("product"));
					order.setOrderSerialNo(rset.getInt("order_serial_no"));
					orders.add(order);
					
				}
			}
		} catch (SQLException e) {
			throw new OrderException(e);
		}
		return orders;
	}

	public String findbyId(Connection conn) {
		String memberId = null;
		String sql = prop.getProperty("findbyId");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {		
			try(ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					memberId = rset.getString("member_id");	
				}
			}
			
		} catch (SQLException e) {
			throw new ReviewException(e);
		}

		return memberId;
	}

	public List<AttachmentReview> findAttachment(Connection conn, int reviewNo) {
		List<AttachmentReview> attachments = new ArrayList<>();
		String sql = prop.getProperty("findAttachment");
		System.out.println("sql : " + sql);

		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reviewNo);
			
			
			try(ResultSet rset = pstmt.executeQuery()) {
				System.out.println("rset = " + rset);
				while(rset.next()) {
					AttachmentReview attachmentReview = new AttachmentReview();
				 	attachmentReview.setRenamedFilename(rset.getString("renamed_filename"));
					attachments.add(attachmentReview);
				}
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ReviewException(e);
		}
		
		return attachments;
	}

	
	

//	private Order handleOrderResultSet(ResultSet rset) throws SQLException {
//		int orderSerialNo = rset.getInt("order_serial_no");
//		String product = rset.getString("product");
//		Date orderDate = rset.getDate("order_date");
//		int count = rset.getInt("count");
//		int price = rset.getInt("price");
//		Order order = new Order(orderSerialNo, product, orderDate, count, price);
//		Order order = rset.getString("product");
//		return order;
//	}



}
