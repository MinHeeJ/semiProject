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
@WebServlet("/member/memberEnroll")
public class MemberEnrollServlet extends HttpServlet {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    // 1. 사용자 입력값 처리
	    String memberId = request.getParameter("memberId");
	    String password = HelloMvcUtils.getEncryptedPassword(request.getParameter("password"), memberId);
	    String name = request.getParameter("name");
	    String phone = request.getParameter("phone");
	    String city = request.getParameter("city"); // 시/도 입력 값 가져오기
	    String district = request.getParameter("district"); // 구/군 입력 값 가져오기
	    String addressDetail = request.getParameter("address"); // 상세주소 입력 값 가져오기
	    String address = city + " " + district + " " + addressDetail; // 시/도, 구/군, 상세주소 조합하여 주소 생성
	    String _gender = request.getParameter("gender");
	    Gender gender = _gender != null ? Gender.valueOf(_gender) : null;
	    
	 
//	    insert into member values (?, ?, ?, ?, ?, ?, default
	    Member newMember = new Member(memberId, password, name, phone, address, gender, null);
	    System.out.println(newMember);
	    // 다른 속성 초기화 등...
	
	

		// 2. 업무로직 - db저장 요청
		int result = memberService.insertMember(newMember);
		System.out.println("result = " + result);
		
		// 결과 메세지 속성 등록 : 성공적으로 회원등록 했습니다. 
		HttpSession session = request.getSession();
		session.setAttribute("msg", "성공적으로 회원등록 했습니다.");
		
		// 3. 인덱스페이지 리다이렉트
		response.sendRedirect(request.getContextPath() + "/");
		
		
	}

}