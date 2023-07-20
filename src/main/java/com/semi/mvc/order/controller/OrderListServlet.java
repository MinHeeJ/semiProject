package com.semi.mvc.order.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.semi.mvc.member.model.vo.Member;
import com.semi.mvc.order.model.service.OrderService;
import com.semi.mvc.order.model.vo.Order;

/**
 * Servlet implementation class OrderListServlet
 */
@WebServlet("/order/orderList")
public class OrderListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final OrderService orderService = new OrderService();
	// 주문내역확인 누르면 나오는 서블릿
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력값 처리
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();

		
		// 2. 업무로직
		int getLastOrderNo = orderService.getLastOrderNo();
		List<Order> orders = orderService.findByOrder(getLastOrderNo, memberId);
		System.out.println("orders : " + orders);
		
		request.setAttribute("orders", orders);
		
		// 3. 응답처리
		request.getRequestDispatcher("/WEB-INF/views/order/orderList.jsp")
			.forward(request, response);
	}

}
