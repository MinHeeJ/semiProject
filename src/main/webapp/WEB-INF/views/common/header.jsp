<%@ page import="com.semi.mvc.member.model.vo.Member" %>
<%@ page import="com.semi.mvc.member.model.vo.MemberRole" %>
<%@ page import="com.semi.mvc.member.model.vo.Gender" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String msg = (String) session.getAttribute("msg");
	if(msg != null) session.removeAttribute("msg"); // 1회용
	// System.out.println("msg = " + msg);
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	// System.out.println("loginMember = " + loginMember);
	
	Cookie[] cookies = request.getCookies();
	String saveId = null;
	if(cookies != null) {
		for(Cookie cookie : cookies) {
			String name = cookie.getName();
			String value = cookie.getValue();
			// System.out.println("[Cookie] " + name + " = " + value);
			if ("saveId".equals(name))
				saveId = value;
		}
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>킥킥샐러드</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
    <header>

        <a class="header_image" href="<%= request.getContextPath() %>/index.jsp">

            <img src="<%= request.getContextPath() %>/images/main/logo.png" alt="main_image" />
        </a>

        <nav>
            <ul>
                <li><a href="<%= request.getContextPath() %>">메인</a></li>
                <li><a href="<%= request.getContextPath() %>/main/introduce.jsp">킥킥샐러드</a></li>
                <li><a href="<%= request.getContextPath() %>/store/storeList">매장조회</a></li>
                <li><a href="<%= request.getContextPath() %>/OnlinOrder">온라인 주문</a></li>
                <li><a href="<%= request.getContextPath() %>/review/reviewCreate">리뷰</a></li>
            </ul>
        </nav>

    </header>

