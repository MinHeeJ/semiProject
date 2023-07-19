package com.semi.mvc.review.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.semi.mvc.review.model.service.ReviewService;

/**
 * Servlet implementation class ReviewLikeCountServlet
 */
@WebServlet("/review/likeCount")
public class ReviewLikeCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ReviewService reviewService = new ReviewService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력값 처리
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
	
		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		
		// 2. 업무로직
		int likeCount = reviewService.onloadLikeCount(memberId, reviewNo);
		boolean isLike = reviewService.isLike(memberId, reviewNo);
		
		// 3. 응답처리
		// 헤더
		response.setContentType("application/json; charset=utf-8");
		
		// 바디
		Map<String, Object> map = new HashMap<>();
		map.put("result", "성공");
		map.put("likeCount", likeCount);
		map.put("isLike", isLike);
		new Gson().toJson(map, response.getWriter());
	}

}
