<%@page import="com.semi.mvc.review.model.vo.Review"%>
<%@page import="com.semi.mvc.review.model.vo.AttachmentReview"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/index.css" />


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
                <li><a href="<%= request.getContextPath()%>/order/orderList.jsp">주문내역</a></li>
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
                <li><a href="<%= request.getContextPath() %>/admin/memberList.jsp">전체회원조회</a></li>
                <li><a href="">로그인</a></li>
            </ul>
        </div>
        
    </div>
	

    <div class="swiper slide_wrapper">
       	<div class="swiper-wrapper">
            <div class="swiper-slide" style="background-image: url('<%= request.getContextPath() %>/images/index/banner1.jpg');"></div>
            <div class="swiper-slide" style="background-image: url('<%= request.getContextPath() %>/images/index/banner2.jpg');"></div>
            <div class="swiper-slide" style="background-image: url('<%= request.getContextPath() %>/images/index/banner3.jpg');"></div>
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
            <img src="<%= request.getContextPath() %>/images/index/balloon.png" id="choiceBallon"/>
            <span>고르기 힘들다면?</span>
        </div>
		<br>
        <h1 id="recommend">리뷰 베스트</h1>
        <br>
        <div id="reviewBestPrint">
        	
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

                
	</div>
		
	<script>
		
		document.addEventListener("DOMContentLoaded", function(){

			 console.log('Load후 동작하는 함수입니다.');
			 getReview();
			 

		});
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
        
        
     
	const getReview = () => {

	    $.ajax({
	        url: "<%= request.getContextPath()%>/main/likeBest",
	        dataType: "json",
	        success(responseData){
	            
	        	const container = document.querySelector("#reviewBestPrint");
				let rank = 1;
				responseData.forEach((review)=>{
					const {reviewNo,writer, content, regDate, product, attachments} = review;
					let renamedFile = "";
					attachments.forEach((attachment)=>{
						const {renamedFilename} = attachment;
						renamedFile = renamedFilename;
					})
		
					container.innerHTML += `
						<div class="polaroid">
							<div class="textArea">
								<p id="textAreaTitle">🧡 좋아요 \${rank}위 🧡</p><br>
								<p class="reviewInfo">\${product}</p><br>
								<p>
									<span class ="writer">작성자 : \${writer}</span><br><br>
									<span class ="photoDate">작성일 : \${regDate}</span><br><br>
								</p>
								<p class ="caption">내 &nbsp&nbsp&nbsp용 : \${content}</p>
							</div>
							<div class="imageArea" style="background-image: url('<%= request.getContextPath()%>/upload/review/\${renamedFile}')";>
								
							</div>
						</div>
					`;
					rank++;
				})
	        	
	        },
	        complete(){
	            console.log("완료");
	        }
	    });
	};
	
  
	
    </script>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>


