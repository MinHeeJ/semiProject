<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String loginMember = null;
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
        <a class="header_image" href="./index.html">
            <img src="<%= request.getContextPath() %>/images/main/logo.png" alt="main_image" />
        </a>

        <nav>
            <ul>
                <li><a href="">메인</a></li>
                <li><a href="">킥킥샐러드</a></li>
                <li><a href="">매장조회</a></li>
                <li><a href="">온라인 주문</a></li>
                <li><a href="">고객센터</a></li>
            </ul>
        </nav>
        
    </header>