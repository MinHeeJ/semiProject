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
		close(conn);
		return orders;
	}

	public String findbyId() {
	  Connection conn = getConnection();
	  String memberId = reviewDao.findbyId(conn);
	  close(conn);
		return memberId;
	}
	
	public int deleteReview(int reviewNo) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = reviewDao.deleteReview(conn, reviewNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
		
	}
	public List<Review> findAllReview() {
		Connection conn = getConnection();
		List<Review> reviews = reviewDao.findAllReview(conn);
			
		for(int i = 0; i<reviews.size(); i++) {
			int reviewNo = reviews.get(i).getReviewNo();
			List<AttachmentReview> attachments = reviewDao.findAttachment(conn, reviewNo);
			
			reviews.get(i).setAttachments(attachments);
		}
		
		close(conn);
		return reviews;
	}


	
	public Review findReviewById(int reviewNo) {
		Connection conn = getConnection();
		Review review = reviewDao.findReviewById(conn, reviewNo);
		List<AttachmentReview> attachments = reviewDao.findAttachmentByReviewNo(conn, reviewNo);
		review.setAttachments(attachments);
		close(conn);
		return review;
	}

	public int updateReview(Review review) {
		int result = 0;
		Connection conn = getConnection();
		try {
			
			// board 테이블 추가
			result = reviewDao.updateReview(conn, review);
			
			// attachment 테이블 추가
			List<AttachmentReview> attachments = review.getAttachments();
			if (attachments != null && !attachments.isEmpty()) {
				for(AttachmentReview attach : attachments) {
					result = reviewDao.insertReviewAttachment(conn, attach);					
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

	public AttachmentReview findAttachmentReviewById(int reviewNo) {
		Connection conn = getConnection();
		AttachmentReview attach = reviewDao.findAttachmentReviewById(conn, reviewNo);
		close(conn);
		return attach;
	}

	public int deleteAttachment(int attachNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = reviewDao.deleteAttachment(conn, attachNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	
	public int findLikeCount(int reviewNo) {
		Connection conn = getConnection();
		int countLike = reviewDao.findLikeCount(conn, reviewNo);
		close(conn);
		return countLike;
	}

	public int likeCount(String memberId, int reviewNo) {
		int likeCount = 0;
		int result = 0;
		
		Connection conn = getConnection();
		try {
			// 1. 로그인된 아이디가 해당게시물에 좋아요 있는지 확인
			likeCount = reviewDao.likeCount(conn, memberId, reviewNo);

			if(likeCount == 0) {
				// 2. 해당게시물에 좋아요가 존재하지않는다면 해당게시물 좋아요 추가
				result = reviewDao.insertLike(conn, memberId, reviewNo);
			}
			else {
				// 2. 해당게시물에 좋아요가 존재한다면 해당게시물 좋아요 삭제
				result = reviewDao.deleteLike(conn, memberId, reviewNo);
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

	public int onloadAllLikeCount(int reviewNo) {
		Connection conn = getConnection();
		int allLikeCount = reviewDao.findAllLikeCount(conn, reviewNo);
		close(conn);
		return allLikeCount;
	}

	public int isLike(String memberId, int reviewNo) {
		Connection conn = getConnection();
		int likeCount = reviewDao.likeCount(conn, memberId, reviewNo);
		close(conn);
		return likeCount;
	}

	}


	
