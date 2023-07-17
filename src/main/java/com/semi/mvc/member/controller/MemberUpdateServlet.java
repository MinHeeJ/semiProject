package com.semi.mvc.member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.common.util.HelloMvcUtils;
import com.semi.mvc.member.model.service.MemberService;
import com.semi.mvc.member.model.vo.Gender;
import com.semi.mvc.member.model.vo.Member;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/member/memberUpdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();

	/**
	 * GET /member/memberEnroll 
	 * - 회원가입 폼페이지 응답
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp")
			.forward(request, response);
	}

	/**
	 * POST /member/memberEnroll
	 * - DB에 회원정보 저장 insert into member values (?, ?, default, ...)
	 * - 회원권한, 포인트, 등록일등 sql 기본값처리
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	 
	    // 1. 사용자 입력값 처리
	    String memberId = request.getParameter("memberId");
	    String password = HelloMvcUtils.getEncryptedPassword(request.getParameter("password"), memberId);
	    String name = request.getParameter("name");
	    String phone = request.getParameter("phone");
	    String address = request.getParameter("address");
	    String _gender = request.getParameter("gender");
	    
	    Gender gender = _gender != null ? Gender.valueOf(_gender) : null;
	    
	 
//	    insert into member values (?, ?, ?, ?, ?, ?, default
	    Member member = new Member(memberId, password, name, phone, address, gender, null);
	    System.out.println(member);
	    // 다른 속성 초기화 등...
	
	

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

		
		
	

