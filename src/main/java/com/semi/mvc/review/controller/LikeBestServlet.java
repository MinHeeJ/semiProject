package com.semi.mvc.review.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.semi.mvc.review.model.service.ReviewService;
import com.semi.mvc.review.model.vo.Review;

/**
 * Servlet implementation class LikeBestServlet
 */
@WebServlet("/main/likeBest")
public class LikeBestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final ReviewService reviewService = new ReviewService();
	  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		List<Review> reviews = reviewService.findAllReview();
		Map<Integer, Integer> map = new HashMap<>();
		List<Review> reviewBest = new ArrayList<>();
		for(Review review : reviews) {
			int reviewNo = review.getReviewNo();
			int count = reviewService.findLikeCount(reviewNo);
			map.put(reviewNo, count);
		}
		Comparator<Map.Entry<Integer, Integer>> comparator = Map.Entry.comparingByValue(Comparator.reverseOrder());
		
		List<Map.Entry<Integer, Integer>> sortedEntries = new ArrayList<>(map.entrySet());
		sortedEntries.sort(comparator);
		
	
		if(reviews.size() >= 3) {	
			for (int i = 0; i < 3; i++) {
				int reviewNo = sortedEntries.get(i).getKey();
				for(Review review : reviews) {
					if(reviewNo == review.getReviewNo()) 
						reviewBest.add(review);
				}
			}			
		} else {
			for (int i = 0; i < reviews.size(); i++) {
				int reviewNo = sortedEntries.get(i).getKey();
				for(Review review : reviews) {
					if(reviewNo == review.getReviewNo()) 
						reviewBest.add(review);
				}
			}
		}
		
		response.setContentType("application/json; charset=utf-8");
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(reviewBest); 
		System.out.println("jsonStr = " + jsonStr);
		response.getWriter().append(jsonStr);
	}


}

