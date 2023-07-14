package com.semi.mvc.store.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.store.model.service.StoreService;
import com.semi.mvc.store.model.vo.Store;

/**
 * Servlet implementation class StoreDeleteServlet
 */
@WebServlet("/store/storeDelete")
public class StoreDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final StoreService storeService = new StoreService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 사용자 입력값 처리
		int storeNo = Integer.parseInt(request.getParameter("storeNo"));
	
		//2. 서비스로직호출
		int result = storeService.deleteStore(storeNo);
				
		
		// 3. 응답처리
		request.getSession().setAttribute("msg", "게시글을 성공적으로 삭제했습니다.");
		response.sendRedirect(request.getContextPath() + "/store/storeList");
	}
	
}
	


