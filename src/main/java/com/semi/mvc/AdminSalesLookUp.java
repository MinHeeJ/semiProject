package com.semi.mvc;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.member.model.service.MemberService;

/**
 * Servlet implementation class AdminSalesLookUp
 */
@WebServlet("/admin/salesLookUp")
public class AdminSalesLookUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력값 처리 x
		
		// 2. 업무로직
//		int countAll = memberService.salesLookUp();
		
//		request.setAttribute("countAll", countAll);
		
		// 3. 응답처리
		request.getRequestDispatcher("/WEB/INF/views/admin/salesLookUp.jsp")
			.forward(request, response);
	}

}
