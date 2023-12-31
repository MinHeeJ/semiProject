package com.semi.mvc.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.member.model.service.MemberService;
import com.semi.mvc.member.model.vo.Member;

/**
 * Servlet implementation class MemberCheckIdDuplicateServlet
 */
@WebServlet("/member/checkIdDuplicate")
public class MemberCheckIdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자입력값 처리
		String memberId = request.getParameter("memberId");
		System.out.println("memberId = " + memberId);
		
		// 2. 업무로직 - 아이디중복검사
		Member member = memberService.findById(memberId);
		boolean available = member == null; 
		request.setAttribute("available", available);
		
		// 3. 응답 html
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/member/checkIdDuplicate.jsp");
		reqDispatcher.forward(request, response);
	}

}
