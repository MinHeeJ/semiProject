<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 헤더 내용 -->
<div class="account_wrapper">
    <ul class="account_list">
        <li><a href="javascript:void(0);" onclick="location.href='<%= request.getContextPath() %>/member/memberEnroll';">회원가입</a></li>
        <li><a href="">로그인</a></li>
        
    </ul>
    <!-- 로그인 후 또는 관리자인 경우 -->
    <div class="user_info_container">
        <span>***님, 환영합니다!</span>
        <ul class="account_list">
            <li><a href="">장바구니</a></li>
            <li><a href="">마이페이지</a></li>
            <li><a href="">로그아웃</a></li>
        </ul>
    </div>
    <!-- 관리자일 경우 로그인 -->
    <div class="user_info_container">
        <span>님, 환영합니다!</span>
        <ul class="account_list">
            <li><a href="<%= request.getContextPath() %>/admin/salesLookUp">매출조회</a></li>
            <li><a href="<%= request.getContextPath() %>/admin/orderList">전체주문내역</a></li>
            <li><a href="<%= request.getContextPath() %>/admin/memberList">전체회원조회</a></li>
            <li><a href="">로그인</a></li>
        </ul>
    </div>
</div>

<!-- 스와이퍼 내용 -->
<div class="swiper slide_wrapper">
    <!-- 스와이퍼 내용 생략 -->
</div>

<!-- 추천 내용 -->
<div class="recommend_contents">
    <!-- 추천 내용 생략 -->
</div>
