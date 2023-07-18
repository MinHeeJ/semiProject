package com.semi.mvc.cart.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.semi.mvc.cart.model.service.CartService;

/**
 * Servlet implementation class DeleteCartServlet
 */
@WebServlet("/delete/cart")
public class DeleteCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		MultipartRequest multiReq = new MultipartRequest(request, getServletContext().getRealPath("/images"), "utf-8");
		String[] cartNumber = multiReq.getParameterValues("cartNumber");
		String[] checkedOrNot = multiReq.getParameterValues("checkedOrNot");
		
		int result = 0;
		
		for(int i = 0; i < checkedOrNot.length; i++) {
			for(int z = 0; z < cartNumber.length; z++) {
				if(checkedOrNot[i].equals(cartNumber[z])) {
					int cartNo = Integer.parseInt(cartNumber[z]);
					result = cartService.deleteCart(cartNo);
				}
				
			}
		}
		
		Map<String, Object> map = new HashMap<>();
		response.setContentType("text/plain; charset=utf-8");
		map.put("result", "success");
		map.put("message", "삭제완료");
		new Gson().toJson(map, response.getWriter());
	}

}
