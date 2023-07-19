<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.semi.mvc.member.model.vo.Member" %>
<%@ page import="com.semi.mvc.member.model.vo.MemberRole" %>
<%@ page import="com.semi.mvc.member.model.vo.Gender" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>

<%
	String msg = (String) session.getAttribute("msg");
	if(msg != null) session.removeAttribute("msg"); // 1회용
	// System.out.println("msg = " + msg);
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	System.out.println("loginMember = " + loginMember);
	
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<% 	if(loginMember != null) { %>
	<script src="<%= request.getContextPath() %>/js/ws.js"></script>		
<% 	} %>
</head>
        
<body>
    <header>

        <a class="header_image" href="<%= request.getContextPath() %>">

            <img src="<%= request.getContextPath() %>/images/main/logo.png" alt="main_image" />
        </a>
        
        <div class="header-wrapper">
        <% if(loginMember == null) {  %>
			<!-- 로그인 전 -->
			<div class="account_wrapper">
				<ul class="account_list">
				    <li>
				    	<a href="<%= request.getContextPath() %>/member/memberLogin">로그인</a>
				    	<img class="clickImg" src="<%= request.getContextPath() %>/images/main/login.png"/>
				    </li>
				    <li>
				    	<a href="<%= request.getContextPath() %>/member/memberEnroll">회원가입</a>
				    	<img class="clickImg" src="<%= request.getContextPath() %>/images/main/signup.png"/>
				    </li>
				</ul>
		    </div>
	<% }  else { 

	        if(loginMember.getMemberRole() == MemberRole.U) { %>
	        <div class="user_info_container">
		        <div>
				    <span id= notification> </span> <span> <%= loginMember.getMemberId() %>님, 환영합니다!</span>
		        </div>
		        <br><br>
	            <ul class="account_list">
	                <li><a href="<%= request.getContextPath()%>/cart/cartList.jsp">장바구니</a></li>
	                <li><a href="<%= request.getContextPath()%>/order/orderList.jsp">주문내역</a></li>
	                <li><a href="<%= request.getContextPath()%>/member/memberDetail">마이페이지</a></li>
	                <li><a href="<%= request.getContextPath()%>/member/logout">로그아웃</a></li>
	            </ul>
	        </div>
	       <% } else if(loginMember.getMemberRole() == MemberRole.A) { %> 
	        <!-- 관리자일 경우 로그인 -->
	        <div class="admin_info_container">
		        <div>
		            <span id= notification></span><span> 관리자(<%= loginMember.getMemberId() %>)님</span>
		        </div>
		        <br><br><br>
	            <ul class="account_list1">
	                <li><a href="<%= request.getContextPath() %>/admin/salesLookUp.jsp">매출조회</a></li>
	                <li><a href="<%= request.getContextPath() %>/admin/orderList">전체주문내역</a></li>
	                <li><a href="<%= request.getContextPath() %>/admin/memberList.jsp">전체회원조회</a></li>
	                <li><a href="<%= request.getContextPath()%>/member/logout">로그아웃</a></li>
	            </ul>
	        </div>
	        <% }}%>
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
        <script>
        const clickImages = document.querySelectorAll(".clickImg");
        clickImages.forEach((image) => {
        	image.addEventListener('click', () => {
        		const link = image.parentNode.querySelector('a');
        	      if (link) {
        	          window.location.href = link.href;
        	        }
        	});
        });
        </script>
		<br>
		<br>
		<br>
    </header>
