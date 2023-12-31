package com.semi.mvc.order.controller;

import java.io.IOException;
import java.sql.Date;
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
 * Servlet implementation class MemberOrderListServlet
 */
@WebServlet("/member/orderList")
public class MemberOrderListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final OrderService orderService = new OrderService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 0. MultipartRequest객체 생성
		String saveDirectory = getServletContext().getRealPath("/images");
		int maxPostSize = 1024 * 1024 * 10;
		String encoding = "utf-8";
		FileRenamePolicy policy = new DefaultFileRenamePolicy();
		MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		// 1. 사용자 입력값 처리
		String _startDate = multiReq.getParameter("searchStartDate");
		String _endDate = multiReq.getParameter("searchEndDate");
		Date startDate = Date.valueOf(_startDate);
		Date endDate = Date.valueOf(_endDate);
		
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();

		
		// 2. 업무로직
		List<Order> orders = orderService.findByDateOfId(memberId, startDate, endDate);
		System.out.println("orders111 : " + orders);
		
		// 헤더
		response.setContentType("application/json; charset=utf-8");
		
		// 바디
		Map<String, Object> map = new HashMap<>();
		map.put("result", "성공");
		map.put("orders", orders);
		System.out.println(map);
		new Gson().toJson(map, response.getWriter());
	}

}
