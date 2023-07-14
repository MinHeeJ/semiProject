package com.semi.mvc.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.mvc.member.model.service.MemberService;
import com.semi.mvc.member.model.vo.MemberRole;

/**
 * Servlet implementation class AdminMemberRoleUpdateServlet
 */
@WebServlet("/admin/memberRoleUpdate")
public class AdminMemberRoleUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자 입력값 처리
		String memberId = request.getParameter("memberId");
		String _memberRole = request.getParameter("memberRole");
		MemberRole memberRole = MemberRole.valueOf(_memberRole);
		
		// 2. 업무로직
		int result = memberService.updateMemberRole(memberId, memberRole);
		
		// 3. 응답처리
		response.sendRedirect(request.getContextPath() + "/admin/memberList");
	}

}
