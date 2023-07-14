package com.semi.mvc.order.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.member.model.vo.Member;
import com.semi.mvc.order.model.service.OrderService;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/order/cart")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final OrderService orderService = new OrderService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력값 처리
//		HttpSession session = request.getSession();
//		Member loginMember = (Member) session.getAttribute("loginMember");
//		String memberId = loginMember.getMemberId();
		String memberId = request.getParameter("memberId");
		String[] cartNumber = request.getParameterValues("cartNumber");
		String[] checkedOrNot = request.getParameterValues("checkedOrNot");
		
		// 2. 업무로직
		for(int i=0; i<checkedOrNot.length; i++) {
			for(int j=0; j<cartNumber.length; j++) {
				if(checkedOrNot[i].equals(cartNumber[j])) {
					int cartNo = Integer.parseInt(cartNumber[j]);
					System.out.println(cartNo);
					int result = orderService.insertOrder(memberId, cartNo);
				}
			}
		}
		
		// 3. 응답처리
		request.getRequestDispatcher("/WEB-INF/views/order/order.jsp")
			.forward(request, response);
	}

}
