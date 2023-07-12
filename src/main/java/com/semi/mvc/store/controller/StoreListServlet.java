package com.semi.mvc.store.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.store.model.service.StoreService;
import com.semi.mvc.store.model.vo.Store;




/**
 * 
 */
@WebServlet("/store/storeFinder")
public class StoreFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final StoreService storeService = new StoreService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.입력값처리
		String searchStore = request.getParameter("searchStore");
		//2. 업무로직
		List <Store> stores = storeService.searchStore(searchStore);
		
	}

}
