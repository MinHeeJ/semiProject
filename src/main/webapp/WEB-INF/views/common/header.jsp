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
        <a class="header_image" href="<%= request.getContextPath() %>">
            <img src="<%= request.getContextPath() %>/images/main/logo.png" alt="main_image" />
        </a>
        
        <% if(loginMember == null || loginMember.isEmpty()) {  %>
        <div class="header-wrapper">
			<!-- 로그인 전 -->
			<div class="account_wrapper">
				<ul class="account_list">
				    <li>
				    	<a href="">로그인</a>
				    	<img src="<%= request.getContextPath() %>/images/main/login.png"/>
				    </li>
				    <li>
				    	<a href="<%= request.getContextPath() %>/member/memberEnroll">회원가입</a>
				    	<img src="<%= request.getContextPath() %>/images/main/signup.png"/>
				    </li>
				</ul>
		    </div>
			<% }  %>
	        <!-- 로그인 후 -->
	        <div class="user_info_container">
		        <div>
				    <span>님, 환영합니다!</span>
		        </div>
		        <br>
	            <ul class="account_list">
	                <li><a href="<%= request.getContextPath()%>/cart/cartList.jsp">장바구니</a></li>
	                <li><a href="<%= request.getContextPath()%>/order/orderList.jsp">주문내역</a></li>
	                <li><a href="">마이페이지</a></li>
	                <li><a href="">로그아웃</a></li>
	            </ul>
	        </div>
	        <!-- 관리자일 경우 로그인 -->
	        <div class="admin_info_container">
		        <div>
		            <span>관리자()님</span>
		        </div>
		        <br>
	            <ul class="account_list">
	                <li><a href="<%= request.getContextPath() %>/admin/salesLookUp.jsp">매출조회</a></li>
	                <li><a href="<%= request.getContextPath() %>/admin/orderList">전체주문내역</a></li>
	                <li><a href="<%= request.getContextPath() %>/admin/memberList.jsp">전체회원조회</a></li>
	                <li><a href="">로그아웃</a></li>
	            </ul>
	        </div>
        </div>
        
        <nav>
            <ul>
                <li><a href="<%= request.getContextPath() %>">메인</a></li>
                <li><a href="<%= request.getContextPath() %>/main/introduce.jsp">킥킥샐러드</a></li>
                <li><a href="<%= request.getContextPath() %>/store/storeList">매장조회</a></li>
                <li><a href="<%= request.getContextPath() %>/OnlinOrder">온라인 주문</a></li>
                <li><a href="<%= request.getContextPath() %>/review/reviewCreate">리뷰</a></li>
            </ul>
        </nav>
		<br>
		<br>
		<br>
    </header>