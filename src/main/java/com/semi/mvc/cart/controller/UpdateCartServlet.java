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
 * Servlet implementation class UpdateCart
 */
@WebServlet("/update/cart")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		MultipartRequest multiReq = new MultipartRequest(request, getServletContext().getRealPath("/images"), "utf-8");
		String[] quentity = multiReq.getParameterValues("quentity");
		String[] cartNumber = multiReq.getParameterValues("cartNumber");
		String[] checkedOrNot = multiReq.getParameterValues("checkedOrNot");
		
		int result = 0;
		
		for(int i = 0; i < checkedOrNot.length; i++) {
			System.out.println("  체크여부 : "+checkedOrNot[i]);
			for(int z = 0; z < cartNumber.length; z++) {
				if(checkedOrNot[i].equals(cartNumber[z])) {
					int cartNo = Integer.parseInt(cartNumber[z]);
					int updateQuentity = Integer.parseInt(quentity[z]);
					result = cartService.updateCart(cartNo, updateQuentity);
				}
				
			}
		}
		
		Map<String, Object> map = new HashMap<>();
		response.setContentType("text/plain; charset=utf-8");
		map.put("result", "success");
		map.put("message", "수정완료");
		new Gson().toJson(map, response.getWriter());
	}

}
