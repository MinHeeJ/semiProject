package com.semi.mvc.store.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.store.model.service.StoreService;
import com.semi.mvc.store.model.vo.Store;

/**
 * Servlet implementation class StoreEnrollServlet
 */
@WebServlet("/store/storeEnroll")
public class StoreEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final StoreService storeService = new StoreService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/store/storeEnroll.jsp")
			.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 1. 사용자입력값 처리
		String storeName = request.getParameter("storeName");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		
		Store newStore = new Store(0, storeName, address, phone);
		
		// 2. 업무로직 - db저장 요청
		int result = storeService.insertStore(newStore);
		
		// 결과 메세지 속성 등록 : 성공적으로 회원등록 했습니다. 
		HttpSession session = request.getSession();
		session.setAttribute("msg", "성공적으로 회원등록 했습니다.");
		
		// 3. 인덱스페이지 리다이렉트
		response.sendRedirect(request.getContextPath() + "/");
	}

}
