package com.semi.mvc.cart.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.cart.model.service.CartService;
import com.semi.mvc.cart.model.vo.Ingredient;

/**
 * Servlet implementation class IngredientServlet
 */
@WebServlet("/OnlinOrder")
public class IngredientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 사용자 입력값 처리
			
		//2. 업무로직
		List<Ingredient> ingredients = cartService.findAll();
		request.setAttribute("ingredients", ingredients);
		
		request.getRequestDispatcher("/WEB-INF/views/cart/optionSelect.jsp").forward(request, response);
		
	}
}
