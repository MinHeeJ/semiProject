package com.semi.mvc.cart.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.semi.mvc.cart.model.service.CartService;
import com.semi.mvc.cart.model.vo.SelectedOption;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add/to/cart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 사용자 입력값 처리

		MultipartRequest multiReq = new MultipartRequest(request, getServletContext().getRealPath("/images"), "utf-8");
		String confirmOptions = multiReq.getParameter("confirmOptions");
		String totalPrice = multiReq.getParameter("totalPrice");
		String saladOrBread = multiReq.getParameter("saladOrBread");
		String memberId = multiReq.getParameter("memberId");
		confirmOptions = saladOrBread + " " + confirmOptions;
		System.out.println(confirmOptions);
		
		System.out.println(confirmOptions + "   "+ totalPrice +"   " +"memberId" + memberId);
		int result = 0;
		
		result = cartService.insertCart(confirmOptions, totalPrice, memberId);
		
		Map<String, Object> map = new HashMap<>();
		response.setContentType("text/plain; charset=utf-8");
		map.put("result", "success");
		map.put("message", "장바구니 추가");
		map.put("cart", "");
		new Gson().toJson(map, response.getWriter());
	}

}
