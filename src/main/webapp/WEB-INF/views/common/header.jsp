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
        <% if(loginMember != null) { %>
        <div class="user_info_container">
            <span>***님, 환영합니다!</span>
            <ul class="account_list">
                <li><a href="">장바구니</a></li>
                <li><a href="">마이페이지</a></li>
                <li><a href="">로그아웃</a></li>
            </ul>
        </div>
        <% } %>
    </div>
    
	<div class="serviceCenter">
	<a href="">고객센터</a>
	</div>
    <!-- 로그인 후 -->
    <!-- <div class="recommend_contents login_after">
        <div id="balloon">
            <img src="<%= request.getContextPath() %>/images/balloon.png" alt="balloon"/>
            <span>고르기 힘들다면?</span>
        </div>

        <h1>추천 조합</h1>
        <div class="horizontal_contents_lists">
            <div class="contents_image_wrapper">
                <div class="contents_image">

                </div>
                <span class="contents_title">충분히 발휘하기</span>
            </div>
            

            <div class="contents_image_wrapper">
                <div class="contents_image">

                </div>
                <span class="contents_title">충분히 발휘하기</span>
            </div>

            <div class="contents_image_wrapper">
                <div class="contents_image">

                </div>
                <span class="contents_title">충분히 발휘하기</span>
            </div>

        </div>
    </div>

    <div class="recommend_contents login_after">
        <div id="balloon">
            <img src="<%= request.getContextPath() %>/images/balloon.png" alt="balloon"/>
            <span>호불호 없는!</span>
        </div>

        <h1>인기메뉴</h1>
        <div class="horizontal_contents_lists">
            <div class="contents_image_wrapper">
                <div class="contents_image">

                </div>
                <span class="contents_title">충분히 발휘하기</span>
            </div>
            

            <div class="contents_image_wrapper">
                <div class="contents_image">

                </div>
                <span class="contents_title">충분히 발휘하기</span>
            </div>

            <div class="contents_image_wrapper">
                <div class="contents_image">

                </div>
                <span class="contents_title">충분히 발휘하기</span>
            </div>

        </div>
    </div> -->

    <!-- 로그인 후 END -->

    <script>
        let slide_index = 0;
        let slide_prev = document.querySelector('.slide_prev');
        let slide_next = document.querySelector('.slide_next');
        let swiper_wrapper = document.querySelector('.swiper-wrapper');
        let slide_page_number = document.querySelectorAll('.slide_page_number');

        slide_prev.addEventListener('click', ()=>{
            slide_page_number[slide_index].classList.remove('slide_active');

            if(slide_index === 0){
                slide_index = 2;
            }else{
                slide_index -= 1;
            }

            swiper_wrapper.style.left = -1200 * slide_index + 'px';
            slide_page_number[slide_index].classList.add('slide_active');

        })

        slide_next.addEventListener('click', ()=>{
            slide_page_number[slide_index].classList.remove('slide_active');

            if(slide_index === 2){
                slide_index = 0;
            }else{
                slide_index += 1;
            }

            swiper_wrapper.style.left = -1200 * slide_index + 'px';
            slide_page_number[slide_index].classList.add('slide_active');

        })

        setInterval(() => {
            slide_page_number[slide_index].classList.remove('slide_active');

            if(slide_index === 2){
                slide_index = 0;
            }else{
                slide_index += 1;
            }

            swiper_wrapper.style.left = -1200 * slide_index + 'px';
            slide_page_number[slide_index].classList.add('slide_active');
        }, 3000)
    </script>

</body>
</html>