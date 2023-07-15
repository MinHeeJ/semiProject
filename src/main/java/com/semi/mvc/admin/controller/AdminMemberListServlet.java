package com.semi.mvc.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.semi.mvc.member.model.service.MemberService;
import com.semi.mvc.member.model.vo.Member;

/**
 * Servlet implementation class AdminMemberListServlet
 */
@WebServlet("/admin/memberList")
public class AdminMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 입력값 처리 x
		
		// 2. 업무로직
		List<Member> members = memberService.findAll();
		
		
		// 3. 응답처리
		// 헤더
		response.setContentType("application/json; charset=utf-8");
		
		// 바디
		Gson gson = new Gson();
		String jsonStr = gson.toJson(members);
		response.getWriter().append(jsonStr);
	}

}
