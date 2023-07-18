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
import com.semi.mvc.store.model.exception.StoreException;
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
		//List<Review> re = new ArrayList<>();
		String sql = prop.getProperty("findReview");
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			try(ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					Review result = new Review();
					result.setReviewNo(rset.getInt("review_no"));
					result.setWriter(rset.getString("writer"));					
					result.setTitle(rset.getString("title"));
					result.setContent(rset.getString("content"));
					result.setRegDate(rset.getDate("reg_date"));
					result.setProduct(rset.getString("product"));
					reviews.add(result);
							
 					//reviews.add(handleReviewResultSet(rset));
				}
				
			}
			
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return reviews;
	}

	private Review handleReviewResultSet(ResultSet rset) throws SQLException {
		Review review = new Review();
		review.setReviewNo(rset.getInt("review_no"));
		review.setWriter(rset.getString("writer"));
		review.setTitle(rset.getString("title"));
		review.setContent(rset.getString("content"));
		review.setRegDate(rset.getDate("reg_date"));
		return review;
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
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
		
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
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

		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reviewNo);
			
			
			try(ResultSet rset = pstmt.executeQuery()) {
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

	public int deleteReview(Connection conn, int reviewNo) {
		int result = 0;
		String sql = prop.getProperty("deleteReview");
		// delete from review where review_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reviewNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return result;
	}

	public Review findReviewById(Connection conn, int reviewNo) {
		Review review = null;
		String sql = prop.getProperty("findReviewById");
		
		//select * from review where review_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reviewNo);
			try (ResultSet rset = pstmt.executeQuery()) {
				if (rset.next())
					review = handleReviewResultSet(rset);
				
			}
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return review;
	}

	public List<AttachmentReview> findAttachmentByReviewNo(Connection conn, int reviewNo) {
		List<AttachmentReview> attachments = new ArrayList<>();
		String sql = prop.getProperty("findAttachmentByReviewNo");
		
		//select * from attachment_review where review_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reviewNo);
			try (ResultSet rset = pstmt.executeQuery()) {
				while (rset.next()) {
					AttachmentReview attach = handleAttachmentResultSet(rset);
					attachments.add(attach);
				}
			}
		} catch (Exception e) {
			throw new ReviewException(e);
		}
		return attachments;
	}

	private AttachmentReview handleAttachmentResultSet(ResultSet rset) throws SQLException {
		int attachNo = rset.getInt("no");
		int reviewNo = rset.getInt("review_no");
	    String originalFilename = rset.getString("original_filename");
	    String renamedFilename = rset.getString("renamed_filename");
	    Date regDate = rset.getDate("reg_date");
	    
	    AttachmentReview attach = new AttachmentReview();
	    attach.setNo(attachNo);
	    attach.setReviewNo(reviewNo);
	    attach.setOriginalFilename(originalFilename);
	    attach.setRenamedFilename(renamedFilename);
	    attach.setRegDate(regDate);
	    
	    return attach;
	
	}


	public int updateReview(Connection conn, Review r) {
		int result = 0;
		String query = prop.getProperty("updateReview");
		//update review set content = ? where review_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(query)) {
			pstmt.setString(1, r.getContent());
			pstmt.setInt(2, r.getReviewNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ReviewException(e);
		} 
		return result;
	}

	public int insertReviewAttachment(Connection conn, AttachmentReview attach) {
		int result = 0;
		String sql = prop.getProperty("insertReviewAttachment");
		// insert into attachment(no, board_no, original_filename, renamed_filename) values(seq_attachment_no.nextval, ?, ?, ?)
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

	public AttachmentReview findAttachmentReviewById(Connection conn, int reviewNo) {
		AttachmentReview attach = null;
		String sql = prop.getProperty("findAttachmentReviewById");
		//select * from attachment_review where review_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reviewNo);
			try (ResultSet rset = pstmt.executeQuery()) {
				if (rset.next()) {

				    attach = new AttachmentReview();
				    attach.setNo(rset.getInt("no"));
				    attach.setReviewNo(rset.getInt("review_no"));
				    attach.setOriginalFilename(rset.getString("original_filename"));
				    attach.setRenamedFilename(rset.getString("renamed_filename"));
				    attach.setRegDate(rset.getDate("reg_date"));
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ReviewException(e);
		}
		return attach;
	}

	public int deleteAttachment(Connection conn, int attachNo) {
		int result = 0;
		String sql = prop.getProperty("deleteAttachment");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, attachNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return result;
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

	
	public List<Review> findAllReview(Connection conn) {
		List<Review> reviews = new ArrayList<>();
		
		String sql = prop.getProperty("findAllReview");
	
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {

			try(ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					Review result = new Review();
					result.setReviewNo(rset.getInt("review_no"));
					result.setWriter(rset.getString("writer"));					
					result.setTitle(rset.getString("title"));
					result.setContent(rset.getString("content"));
					result.setRegDate(rset.getDate("reg_date"));
					result.setProduct(rset.getString("product"));
					reviews.add(result);
							
				}
				
			}
			
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return reviews;
	}

	public int findLikeCount(Connection conn, int reviewNo) {
		int countLike = 0;
		String sql = prop.getProperty("findLikeCount");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reviewNo);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				if (rset.next())
					countLike = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return countLike;
	}

	public int likeCount(Connection conn, String memberId, int reviewNo) {
		int likeCount = 0;
		String sql = prop.getProperty("likeCount");
		// findLikeCount = select like_count from like_tbl where member_id = ? and review_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			pstmt.setInt(2, reviewNo);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				if(rset.next()) {
					likeCount = rset.getInt("count(like_count)");
				}
			}
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return likeCount;
	}

	public int deleteLike(Connection conn, String memberId, int reviewNo) {
		int result = 0;
		String sql = prop.getProperty("deleteLike");
		// deleteLike = delete * from like_tbl where member_id = ? and review_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			pstmt.setInt(2, reviewNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		return result;
	}

	public int insertLike(Connection conn, String memberId, int reviewNo) {
		int result = 0;
		String sql = prop.getProperty("insertLike");
		// insertLike = insert into like_tbl values(seq_like_no.nextval, ?, ?, 1)
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			pstmt.setInt(2, reviewNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ReviewException(e);
		}
		return result;
	}

	public int findAllLikeCount(Connection conn, int reviewNo) {
		int allLikeCount = 0;
		String sql = prop.getProperty("findAllLikeCount");
		// select like_count from like_tbl where review_no = ?
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reviewNo);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					allLikeCount = rset.getInt("count(like_count)");
				}
			}
		} catch (SQLException e) {
			throw new ReviewException(e);
		}
		
		return allLikeCount;
	}

}

