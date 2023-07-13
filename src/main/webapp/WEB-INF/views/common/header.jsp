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
                <li><a href="/common/introduce">킥킥샐러드</a></li>
                <li><a href="<%= request.getContextPath() %>/store/storeList">매장조회</a></li>
                <li><a href="<%= request.getContextPath() %>/OnlinOrder">온라인 주문</a></li>
                <li><a href="<%= request.getContextPath() %>/review/review">리뷰</a></li>
            </ul>
        </nav>

    </header>