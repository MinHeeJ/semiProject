package com.semi.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi.mvc.common.util.HelloMvcUtils;
import com.semi.mvc.member.model.service.MemberService;
import com.semi.mvc.member.model.vo.Member;

@WebServlet("/member/login")
public class MemberLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final MemberService memberService = new MemberService();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        String memberId = request.getParameter("memberId");
        String password = HelloMvcUtils.getEncryptedPassword(request.getParameter("password"), memberId);
        System.out.println(password);
        System.out.println("memberId = " + memberId);
        System.out.println("password = " + password);
        
        Member member = memberService.findById(memberId);
        
        HttpSession session = request.getSession();
        
        if(member != null && password.equals(member.getPassword())) {
            session.setAttribute("loginMember", member);
        }
        else {
            session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
        }
        
        response.sendRedirect(request.getContextPath() + "/");
    }
}
