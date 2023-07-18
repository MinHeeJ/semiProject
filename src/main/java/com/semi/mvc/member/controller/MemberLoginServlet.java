package com.semi.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.common.util.HelloMvcUtils;
import com.semi.mvc.member.model.service.MemberService;
import com.semi.mvc.member.model.vo.Member;

@WebServlet("/member/memberLogin")
public class MemberLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final MemberService memberService = new MemberService();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/memberLogin.jsp")
			.forward(request, response);
	}
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        String memberId = request.getParameter("memberId");
        String password = HelloMvcUtils.getEncryptedPassword(request.getParameter("password"), memberId);
        System.out.println(password);
        String saveId = request.getParameter("saveId");
        System.out.println("memberId = " + memberId);
        System.out.println("password = " + password);
        System.out.println("saveId = " + saveId);
        
        Member member = memberService.findById(memberId);
        
        HttpSession session = request.getSession();
        
        if(member != null && password.equals(member.getPassword())) {
            session.setAttribute("loginMember", member);
            
            Cookie cookie = new Cookie("saveId", memberId);
            cookie.setPath(request.getContextPath());
            if(saveId != null) {
                cookie.setMaxAge(60 * 60 * 24 * 7); // 7일 유효기간 설정
            }
            else {
                cookie.setMaxAge(0); // 쿠키 삭제
            }
            response.addCookie(cookie);
            
            response.sendRedirect(request.getContextPath()); // 로그인 후 홈 화면으로 이동
        }
        else {
            session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            session.setAttribute("invalidId", memberId); // 잘못된 아이디를 세션에 저장
            
            response.sendRedirect(request.getContextPath() + "/member/memberLogin"); // 로그인 실패 시 로그인 페이지로 이동
        }
    }
}