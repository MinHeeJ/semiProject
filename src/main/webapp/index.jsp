<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- 헤더 내용을 include -->
<%-- 헤더 내용을 포함하고 싶은 위치에 다음 코드를 추가 --%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- index.jsp의 나머지 내용 -->
<div class="swiper-wrapper">
    <div class="swiper-slide"></div>
    <div class="swiper-slide"></div>
    <div class="swiper-slide"></div>
</div>
<div class="slide_pagination">
    <div class="slide_prev">
        <
    </div>
    <div class="slide_page_number slide_active"></div>
    <div class="slide_page_number"></div>
    <div class="slide_page_number"></div>
    <div class="slide_next">
        >
    </div>
</div>

<!-- 추천 내용 -->
<div class="recommend_contents">
    <!-- 추천 내용 생략 -->
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
