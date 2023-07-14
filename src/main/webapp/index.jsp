<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


        <!-- 로그인 전 -->
<ul class="account_list">
    <li><a href="<%= request.getContextPath() %>/member/memberEnroll">회원가입</a></li>
    <li><a href="">로그인</a></li>
</ul>

        <!-- 로그인 후 -->
        <div class="user_info_container">
            <span>***님, 환영합니다!</span>
            <ul class="account_list">
                <li><a href="<%= request.getContextPath()%>/cart/cartList.jsp">장바구니</a></li>
                <li><a href="">마이페이지</a></li>
                <li><a href="">로그아웃</a></li>
            </ul>
        </div>
        
        <!-- 관리자일 경우 로그인 -->
        <div class="user_info_container">
            <span>님, 환영합니다!</span>
            <ul class="account_list">
                <li><a href="<%= request.getContextPath() %>/admin/salesLookUp.jsp">매출조회</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/orderList">전체주문내역</a></li>
                <li><a href="<%= request.getContextPath() %>/admin/memberList">전체회원조회</a></li>
                <li><a href="">로그인</a></li>
            </ul>
        </div>
        
    </div>
	

    <div class="swiper slide_wrapper">
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


    </div>

    <!-- 로그인 전 -->
    <div class="recommend_contents">
        <div id="balloon">
            <img src="<%= request.getContextPath() %>/images/balloon.png" alt="balloon"/>
            <span>고르기 힘들다면?</span>
        </div>

        <h1>추천 조합</h1>
        <div class="contents_lists">
            <div class="contents_image_wrapper">
                <a href="링크 주소"> <!-- 추천 조합 링크 -->
                    <div class="contents_image">
                        <img src="<%= request.getContextPath() %>/images/강선모.jpg" alt="강선모의 이미지" style="max-width: 100%;">
                    </div>
                </a>
                <span class="contents_title"></span>
            </div>
            <div style="overflow: auto;">
                <p style="float: right;">
                    청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다 보이는 끝까지 찾아다녀도 목숨이 있는 때까지 방황하여도 보이는
                </p>
            </div>
        </div>
        <div class="contents_lists">
            <div class="contents_image_wrapper">
                <a href="링크 주소"> <!-- 추천 조합 링크 -->
                    <div class="contents_image">
                        <img src="<%= request.getContextPath() %>/images/강선모.jpg" alt="강선모의 이미지" style="max-width: 100%;">
                    </div>
                </a>
                <span class="contents_title"></span>
            </div>
            <div style="overflow: auto;">
                <p style="float: right;">
                    청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다 보이는 끝까지 찾아다녀도 목숨이 있는 때까지 방황하여도 보이는
                </p>
            </div>
        </div>
        <div class="contents_lists">
            <div class="contents_image_wrapper">
                <a href="링크 주소"> <!-- 추천 조합 링크 -->
                    <div class="contents_image">
                        <img src="<%= request.getContextPath() %>/images/강선모.jpg" alt="강선모의 이미지" style="max-width: 100%;">
                    </div>
                </a>
                <span class="contents_title"></span>
            </div>
            <div style="overflow: auto;">
                <p style="float: right;">
                    청춘의 피가 뜨거운지라 인간의 동산에는 사랑의 풀이 돋고 이상의 꽃이 피고 희망의 놀이 뜨고 열락의 새가 운다사랑의 풀이 없으면 인간은 사막이다 오아이스도 없는 사막이다 보이는 끝까지 찾아다녀도 목숨이 있는 때까지 방황하여도 보이는
                </p>
                </p>
            </div>
		</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>


