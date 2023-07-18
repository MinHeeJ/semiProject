package com.semi.mvc.cart.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.semi.mvc.cart.model.service.CartService;
import com.semi.mvc.cart.model.vo.Cart;

/**
 * Servlet implementation class CartListServlet
 */
@WebServlet("/myCart/list")
public class CartListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartService();   
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
//		Member loginMember = (Member) session.getAttribute("loginMember");
//		String memberId = loginMember.getMemberId();
		
		String memberId = "honggd";		
		
		List<Cart> carts = cartService.findAllCart(memberId);
//		request.setAttribute("carts", carts);
		
		response.setContentType("application/json; charset=utf-8");
		
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(carts); 
		System.out.println("jsonStr = " + jsonStr);
		response.getWriter().append(jsonStr);
	}



}
