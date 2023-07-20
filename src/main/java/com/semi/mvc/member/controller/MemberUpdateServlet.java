package com.semi.mvc.member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.member.model.service.MemberService;
import com.semi.mvc.member.model.vo.Gender;
import com.semi.mvc.member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/member/memberUpdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 사용자입력값 처리
		String memberId = request.getParameter("memberId");
		String currentPassword = request.getParameter("currentPassword"); 
	    String newPassword = request.getParameter("newPassword"); 
		String name = request.getParameter("name");
		String _gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		Gender gender = _gender != null ? Gender.valueOf(_gender) : null;
	
		// Member객체로 변환
		// update member set name = ?, gender = ?, birthday = ?, email = ?, phone = ?, hobby = ? where member_id = ?
		
		Member member = new Member();
		member.setMemberId(memberId);
		member.setName(name);
		member.setGender(gender);
		member.setPhone(phone);
		member.setAddress(address);
		System.out.println(member);
		
		// 3.업무로직
		int result = memberService.updateMember(member); 

		// session의 속성 loginMember도 바로 갱신
		HttpSession session = request.getSession();
		session.setAttribute("loginMember", memberService.findById(memberId));

		// 4. 사용자피드백 및 리다이렉트 처리
		session.setAttribute("msg", "성공적으로 회원정보를 수정했습니다.");

		response.sendRedirect(request.getContextPath() + "/member/memberDetail");
	}

}