package com.semi.mvc.review.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.semi.mvc.review.model.service.ReviewService;
import com.semi.mvc.review.model.vo.AttachmentReview;
import com.semi.mvc.review.model.vo.Review;


/**
 * Servlet implementation class ReviewMoreServlet
 */
@WebServlet("/review/reviewMore")
public class ReviewMoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ReviewService reviewService = new ReviewService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int limit= 5;
		int cpage=1;
		
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));			
		} catch (NumberFormatException e) {       
		}
		
		int start = (cpage - 1) * limit + 1; 
		int end = cpage * limit;
		
		// 2. 업무로직
		List<Review> reviews = reviewService.findReview(start, end);
		request.setAttribute("reviews", reviews);
		
		// 3. 응답처리 (json)
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(reviews, response.getWriter());
	}

}
