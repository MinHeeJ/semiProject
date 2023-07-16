package com.semi.mvc.review.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.review.model.service.ReviewService;

/**
 * Servlet implementation class ReviewDeleteServlet
 */
@WebServlet("/review/reviewDelete")
public class ReviewDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ReviewService reviewService = new ReviewService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		System.out.println("reviewNo 여기기기기기= " + reviewNo);
		
		
		int result = reviewService.deleteReview(reviewNo);
		
		request.getSession().setAttribute("msg", "리뷰를 성공적으로 삭제했습니다.");
		response.sendRedirect(request.getContextPath() + "/review/reviewCreate");
	}

}
