package com.semi.mvc.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.order.model.service.OrderService;
import com.semi.mvc.order.model.vo.Order;

/**
 * Servlet implementation class AdminOrderListServlet
 */
@WebServlet("/admin/orderList")
public class AdminOrderListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final OrderService orderService = new OrderService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력값 처리 x
		
		// 2. 업무로직
		List<Order> orders = orderService.findAll();
		
		request.setAttribute("orders", orders);
		System.out.println("orders" + orders);
		
		// 3. 응답처리
		request.getRequestDispatcher("/WEB-INF/views/admin/orderList.jsp")
			.forward(request, response);
	}

}
