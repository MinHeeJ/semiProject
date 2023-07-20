<%@page import="com.semi.mvc.review.model.vo.Review"%>
<%@page import="com.semi.mvc.review.model.vo.AttachmentReview"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.0.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/css/index.css" />


	<div class="swiper slide_wrapper">
		<div class="swiper-wrapper">
			<div class="swiper-slide"
				style="background-image: url('<%= request.getContextPath() %>/images/index/banner1.png');"></div>
			<div class="swiper-slide"
				style="background-image: url('<%= request.getContextPath() %>/images/index/banner2.png');"></div>
			<div class="swiper-slide"
				style="background-image: url('<%= request.getContextPath() %>/images/index/banner3.png');"></div>
		</div>

		<div class="slide_pagination">
			<div class="slide_prev"><</div>
			<div class="slide_page_number slide_active"></div>
			<div class="slide_page_number"></div>
			<div class="slide_page_number"></div>
			<div class="slide_next">></div>
		</div>


	</div>

	<!-- 로그인 전 -->
	<div class="recommend_contents">
		<div id="balloon">
		
			<img src="<%= request.getContextPath() %>/images/index/balloon.png" id="choiceBallon" /> <span>고르기 힘들다면?</span>
		
		
		</div>
		<br>
		<h1 id="recommend">리뷰 베스트</h1>
		<br>
		<div id="reviewBestPrint"></div>

	</div>

	<script>
    document.addEventListener("DOMContentLoaded", function() {
        getReview();
        <% if(msg != null){ %>
    		alert('<%= msg %>');
   		<%  } %>
    });

    let slide_index = 0;
    let slide_prev = document.querySelector('.slide_prev');
    let slide_next = document.querySelector('.slide_next');
    let swiper_wrapper = document.querySelector('.swiper-wrapper');
    let slide_page_number = document.querySelectorAll('.slide_page_number');

    slide_prev.addEventListener('click', () => {
        slide_page_number[slide_index].classList.remove('slide_active');
        if (slide_index === 0) {
            slide_index = 2;
        } else {
            slide_index -= 1;
        }
        swiper_wrapper.style.left = -1920 * slide_index + 'px';
        slide_page_number[slide_index].classList.add('slide_active');
    });

    slide_next.addEventListener('click', () => {
        slide_page_number[slide_index].classList.remove('slide_active');
        if (slide_index === 2) {
            slide_index = 0;
        } else {
            slide_index += 1;
        }
        swiper_wrapper.style.left = -1920 * slide_index + 'px';
        slide_page_number[slide_index].classList.add('slide_active');
    });

    setInterval(() => {
        slide_page_number[slide_index].classList.remove('slide_active');
        if (slide_index === 2) {
            slide_index = 0;
        } else {
            slide_index += 1;
        }
        swiper_wrapper.style.left = -1920 * slide_index + 'px';
        slide_page_number[slide_index].classList.add('slide_active');
    }, 3000);

  
   
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
								<p id="textAreaTitle">💚 좋아요 \${rank}위 💚</p><br>
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

<%@ include file="/WEB-INF/views/common/footer.jsp"%>

