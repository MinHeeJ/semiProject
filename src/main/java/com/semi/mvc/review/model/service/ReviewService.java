package com.semi.mvc.review.model.service;

import static com.semi.mvc.common.JdbcTemplate.getConnection;
import static com.semi.mvc.common.JdbcTemplate.commit;
import static com.semi.mvc.common.JdbcTemplate.rollback;
import static com.semi.mvc.common.JdbcTemplate.close;

import java.sql.Connection;
import java.util.List;

import com.semi.mvc.review.model.dao.ReviewDao;
import com.semi.mvc.review.model.vo.AttachmentReview;
import com.semi.mvc.review.model.vo.Review;

public class ReviewService {
	private final ReviewDao reviewDao = new ReviewDao();
	
	public int insertReview(Review review) {
		int result= 0;
		Connection conn = getConnection();
		
		try {
					result = reviewDao.insertReview(conn, review);
					
					// 발급된 board.no를 조회
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
}
