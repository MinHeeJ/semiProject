package com.semi.mvc.store.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.store.model.service.StoreService;
import com.semi.mvc.store.model.vo.Store;

/**
 * Servlet implementation class StoreCheckNameDuplicateServlet
 */
@WebServlet("/store/checkNameDuplicate")
public class StoreCheckNameDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final StoreService storeService = new StoreService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.입력값처리
		String storeName = request.getParameter("storeName");
		System.out.println("storeName = " + storeName);
		
		//2.업무로직 - 매장 중복검사
		Store store = storeService.findByName(storeName);
		boolean available = store == null;
		request.setAttribute("available", available);
		
		//3.응답 html
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/store/checkNameDuplicate.jsp");
		reqDispatcher.forward(request, response);
	}

}
