package com.semi.mvc.cart.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.cart.model.service.CartService;
import com.semi.mvc.cart.model.vo.Ingredient;
import com.semi.mvc.cart.model.vo.SelectedOption;

/**
 * Servlet implementation class SelectedOptionServlet
 */
@WebServlet("/complete/select")
public class SelectedOptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartService();
  
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String saladOrBread = request.getParameter("saladOrBread");
		String[] quantity = request.getParameterValues("quantity");
		String[] optionName = request.getParameterValues("optionName");
		
		HttpSession session = request.getSession();
//		Member loginMember = (Member) session.getAttribute("loginMember");
//		String memberId = loginMember.getMemberId();
		
		String memberId = "honggd";		
		List<Ingredient> ingredients = cartService.findAll();
		List<SelectedOption> selectedOption = new ArrayList<>();
		for(int i = 0; i < optionName.length ; i++) {
			SelectedOption selected = new SelectedOption();
			int quantityNum = Integer.parseInt(quantity[i]);
			for(Ingredient ingredient : ingredients) {
				if(ingredient.getIngredientName().equals(optionName[i]) && quantityNum !=0) {		
					selected.setCalorie(ingredient.getCalorie()*quantityNum);
					selected.setCount(quantityNum);
					selected.setIngredientNo(ingredient.getIngredientNo());
					selected.setMemberId(memberId);
					selected.setPrice(ingredient.getPrice()*quantityNum);
					selected.setIngredientName(ingredient.getIngredientName());
					int result = cartService.insertSelectedOption(selected);	
					selectedOption.add(selected);
				}
			}
		}
		request.setAttribute("selectedOption", selectedOption);
		request.setAttribute("saladOrBread", saladOrBread);
		request.getRequestDispatcher("/WEB-INF/views/cart/beforeCart.jsp").forward(request, response);
	}

}
