package com.semi.mvc.review.model.service;

import static com.semi.mvc.common.JdbcTemplate.close;
import static com.semi.mvc.common.JdbcTemplate.commit;
import static com.semi.mvc.common.JdbcTemplate.getConnection;
import static com.semi.mvc.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.semi.mvc.order.model.vo.Order;
import com.semi.mvc.review.model.dao.ReviewDao;
import com.semi.mvc.review.model.vo.AttachmentReview;
import com.semi.mvc.review.model.vo.Review;
import com.semi.mvc.review.model.vo.ReviewEntity;

public class ReviewService {
	private final ReviewDao reviewDao = new ReviewDao();
	
	public int insertReview(Review review) {
		int result= 0;
		Connection conn = getConnection();
		
		try {
					result = reviewDao.insertReview(conn, review);
					
					// 발급된 review.no를 조회
					int reviewNo = reviewDao.getLastReviewNo(conn);
					review.setReviewNo(reviewNo); // servlet에서 redirect시 사용
					
					System.out.println("reviewNo = " + reviewNo);
					
					// attachment 테이블 추가
					List<AttachmentReview> attachments = review.getAttachments();
					if (attachments != null && !attachments.isEmpty()) {
						for(AttachmentReview attach : attachments) {
							attach.setReviewNo(reviewNo); // fk컬럼값 세팅
							
							result = reviewDao.insertAttachment(conn, attach);					
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

	public List<Review> findReview(int start, int end) {
		Connection conn = getConnection();
		List<Review> reviews = reviewDao.findReview(conn, start, end);
		
		
		for(int i = 0; i<reviews.size(); i++) {
			int reviewNo = reviews.get(i).getReviewNo();
			System.out.println("reviewNo : " + reviewNo);
			List<AttachmentReview> attachments = reviewDao.findAttachment(conn, reviewNo);
			
			for(int j = 0 ; j < attachments.size() ; j++) {
				System.out.println(attachments.get(j));
			}
			reviews.get(i).setAttachments(attachments);
		}
		close(conn);
		return reviews;
	}

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = reviewDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	public List<Order> reviewOrderList(String memberId) {
		Connection conn = getConnection();
		List<Order> orders = reviewDao.reviewOrderList(conn,memberId);
		System.out.println("씨이이이이"+ orders);
		close(conn);
		return orders;
	}

	public String findbyId() {
	  Connection conn = getConnection();
	  String memberId = reviewDao.findbyId(conn);
	  close(conn);
		return memberId;
	}

	
	}

