package com.semi.mvc.store.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.semi.mvc.store.model.service.StoreService;
import com.semi.mvc.store.model.vo.Store;

/**
 * Servlet implementation class StoreLookMap
 */
@WebServlet("/store/lookMap")
public class StoreLookMap extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final StoreService storeService = new StoreService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 지도보기
		int storeNo = Integer.parseInt(request.getParameter("storeNo"));
		Store store = storeService.findByStoreNo(storeNo);
		
		// 3. 응답처리
		// 헤더
		response.setContentType("application/json; charset=utf-8");
		
		// 바디
		Gson gson = new Gson();
		String jsonStr = gson.toJson(store);
		response.getWriter().append(jsonStr);
	}

}
