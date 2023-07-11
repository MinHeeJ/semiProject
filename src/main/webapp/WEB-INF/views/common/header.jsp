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
	
	<div class="account_wrapper">

        <!-- 로그인 전 -->
        <ul class="account_list">
            <li><a href="">회원가입</a></li>
            <li><a href="">로그인</a></li>
        </ul>

        <!-- 로그인 후 -->
      
        <div class="user_info_container">
            <span>***님, 환영합니다!</span>
            <ul class="account_list">
                <li><a href="">장바구니</a></li>
                <li><a href="">마이페이지</a></li>
                <li><a href="">로그아웃</a></li>
            </ul>
        </div>
    </div>
    
	<div class="serviceCenter">
	<a href="#">고객센터</a>
	</div>
    

    

</body>
</html>