<%@ page import="com.semi.mvc.member.model.vo.Member" %>
<%@ page import="com.semi.mvc.member.model.vo.MemberRole" %>
<%@ page import="com.semi.mvc.member.model.vo.Gender" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginMember = new Member("a", "1234", "a", "010", "a", Gender.valueOf("M"), MemberRole.valueOf("A"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>킥킥샐러드</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" />

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

