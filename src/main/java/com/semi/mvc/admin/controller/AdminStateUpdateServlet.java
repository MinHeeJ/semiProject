package com.semi.mvc.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.order.model.service.OrderService;
import com.semi.mvc.order.model.vo.State;

/**
 * Servlet implementation class AdminStateUpdate
 */
@WebServlet("/admin/stateUpdate")
public class AdminStateUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final OrderService orderService = new OrderService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 0. 인코딩처리
		request.setCharacterEncoding("utf-8");
		
		// 1. 사용자 입력값 처리
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
		String state = request.getParameter("state");
		System.out.println(state);
		
		// 2. 업무로직
		int result = orderService.stateUpdate(orderNo, state);
		
		// 3. 응답처리
		response.sendRedirect(request.getContextPath() + "/admin/orderList");
	}

}
