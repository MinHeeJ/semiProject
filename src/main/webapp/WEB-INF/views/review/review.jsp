<%@page import="com.semi.mvc.review.model.vo.AttachmentReview"%>
<%@page import="com.semi.mvc.review.model.vo.Review"%>
<%@page import="com.semi.mvc.order.model.vo.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<% 
	int totalPage = (int) request.getAttribute("totalPage");  
	int cpage = (int) request.getAttribute("cpage");
	List<Order> orders = (List<Order>)request.getAttribute("orders");
	String product = (String) request.getAttribute("product");
	List<Review> reviews = (List<Review>)request.getAttribute("reviews");
	String memberId = (String) request.getAttribute("memberId");
	Review review = (Review) request.getAttribute("review");
%>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/review.css" />

	<form name="reviewOrderListFrm"
		action="<%=request.getContextPath() %>/review/reviewOrderList"
		method="POST" enctype="multipart/form-data">
<% if (loginMember != null) { %>
<h2>✨리뷰작성✨</h2>
<section id="review-container">
		<table id="tbl-order-review">
			<h1>상품</h1>
			<tbody>
				<% 	if(orders == null || orders.isEmpty()) { //주문내역이 없으면%>
				<tr>
					<td colspan="4">작성할 리뷰가 없습니다.</td>
				</tr>
				<%	
				} 
				else { 
					for(Order order : orders) { //주문내역 있으면 시리얼번호로 주문제품알아오기
			%>
				<tr>
					<td><input type="radio" name="orderSerialNo"
						value="<%= order.getOrderSerialNo() %>" /> <%= order.getProduct() %>
					</td>
				</tr>
				<% 		
					}
				} 
			%>
			</tbody>
		</table>
		<br>
		<br>
		<br>
		<% 	if(!(orders == null || orders.isEmpty())) { //주문내역이 있으면 띄워주기 %>
		<table id="tbl-board-view">
			<tr>
				<th>작성자</th>
				<td><input type="text" name="writer" id="writer"
					value="<%=memberId%>" readonly /></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="upFile1"> <input
					type="file" name="upFile2"></td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea rows="5" cols="40" id="content" name="content"></textarea></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="등록하기"></th>
			</tr>
		</table>
		<%}
			}%>
	</form>
</section>
		



<section id="photo-review-wrapper">
	<h2>✨리뷰게시판✨</h2>
	<div id="photo-review-container">
		<% 	if(reviews == null || reviews.isEmpty()) {//리뷰가 없으면 %>
		<tr>
			<td>리뷰가 없습니다.</td>
		</tr>
		<%	
			} 
			else { //첨부파일뿌려ㅇ
				for(Review reviewss : reviews){
					List<AttachmentReview> files = reviewss.getAttachments();
		%>
		<tr>
			<div class="polaroid">
				<!-- ajax -->
			</div>
			<br />
		</tr>
		<% 		
				}
			} 
		%>
	</div>
	<div id='btn-more-container'>
		<button id="btn-more" value="">
			더보기(<span id="cpage"><%= cpage %></span>/<span id="totalPage"><%= totalPage %></span>)
		</button>
	</div>
</section>


<form action="<%= request.getContextPath() %>/review/reviewDelete"
	name="reviewDelFrm" method="POST">
	<input type="hidden" name="reviewNo" id="reviewNo" value="" />
</form>
<script>
document.reviewOrderListFrm.onsubmit = (e) => {
	const frm = e.target;
	const title = e.target.title;
	const content = e.target.content;
	
	// 제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test(title.value)) {
		alert("제목을 작성해주세요.");
		return false;
	}
					   
	// 내용을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^(.|\n)+$/.test(content.value)) {
		alert("내용을 작성해주세요.");
		return false;
	}
	return true;
}
//좋아요
// onload될때 내가 좋아요 했는지 유무 / 해당게시물 좋아요 총갯수
function like() {
  const reviewNo = document.querySelectorAll(".heart");
  reviewNo.forEach((e) => {
    console.log(e);
    $.ajax({
      url : "<%= request.getContextPath() %>/review/likeCount",
      method : "POST",
      data : {
        reviewNo : e.value
      },
      success(responseData) {
        console.log(responseData);
        const {likeCount, isLike} = responseData;
        console.log(likeCount); // 해당게시물 좋아요 갯수
        console.log(isLike); // 해당게시물에 좋아요 했으면 1
        const hearts = document.querySelectorAll(".heart");
        const p = document.querySelectorAll("#p");
        for(let i=0; i<hearts.length; i++) {
          if(e.value == hearts[i].value) { 
            if(isLike == 1) {
              hearts[i].src = "<%= request.getContextPath() %>/images/review/greenheart.png"
              p[i].innerHTML = `\${likeCount}`;
            } else {
              hearts[i].src = "<%= request.getContextPath() %>/images/review/emptyheart.png"
              p[i].innerHTML = `\${likeCount}`;
            }
          }
        }
      }
    });
  });
}

// 하트를 눌렀을때
document.querySelector("#photo-review-wrapper").onclick = (e) => {
	love(e);
}

// 내가 좋아요 했는지 유무 / 해당게시물 좋아요 총갯수 / 해당게시물 좋아요or좋아요취소
function love(e) {
  $.ajax({
    url : "<%= request.getContextPath() %>/review/like",
    method : "POST",
    data : {
      reviewNo : e.target.value
    },
    success(responseData) {
      const {likeCount, isLike} = responseData;
      const hearts = document.querySelectorAll(".heart");
      const p = document.querySelectorAll("#p");
      for(let i=0; i<hearts.length; i++) {
        if(e.target.value == hearts[i].value) {
          if(isLike == 1) {
            hearts[i].src = "<%= request.getContextPath() %>/images/review/greenheart.png"
            p[i].innerHTML = `\${likeCount}`;
          } else {
            hearts[i].src = "<%= request.getContextPath() %>/images/review/emptyheart.png"
            p[i].innerHTML = `\${likeCount}`;
          }
        }
      }
    }
  });
}
/**
* 
*/
document.querySelector("#btn-more").onclick = () =>{
	const cpage = Number(document.querySelector("#cpage").innerHTML);
	const nextPage = cpage + 1;
	getPage(nextPage);
};
window.addEventListener('load', () => { 
	getPage(1);
});

const getPage = (cpage) => {
	var loginMemberId = "<%= loginMember != null ? loginMember.getMemberId() : "" %>"
	
		
	$.ajax({
		url : "<%=request.getContextPath()%>/review/reviewMore",
		data : {cpage},
		success(reviews) {
			
			console.log(reviews);
			const container = document.querySelector(".polaroid");
			
			reviews.forEach((Review)=>{
				const {reviewNo,writer, content, regDate,product,attachments,likeCount} =Review;
				console.log(likeCount);
				console.log(writer);
				let renamedFile = "";
				let imgElements = "";
				
				
				for (let i = 0; i < attachments.length; i++) {
				    const attachment = attachments[i];
				    const { renamedFilename } = attachment;
				    renamedFile = renamedFilename;
				    imgElements += `<img src="<%= request.getContextPath()%>/upload/review/\${renamedFile}" class="photo photoModal">`;
				  }
				
			
					
				<% 	boolean admin = loginMember != null && (loginMember.getMemberRole() == MemberRole.A); 
					boolean isHeart = loginMember == null? false : true;
				%>
			
				const isWriter = loginMemberId == writer;
			
				if(isWriter){ //게시글 작성자
					container.innerHTML += imgElements + `
						<div class = "content-container">
									<p class ="photoDate">\${regDate}</p>
								<div class="info-container">
								<p class ="product">🥗\${product}🥗</p>
									<p class ="writer">작성자 : \${writer}</p></p>
									<p class ="content">내용 : \${content}</p>
								</div>
						
							<tr>			
								<th colspan="2" id="th">
										
										<div class="heart-container">
								            <input type="hidden" name="reviewNo" value="\${reviewNo}"/>
								            <input type="image" src="<%= request.getContextPath() %>/images/review/emptyheart.png" alt="heart.png" style="width: 30px;" class="heart" value="\${reviewNo}">
								            <p id="p">0</p>
						          	 	</div>
										
										<div class = "button-container">
											<input type="button" value="수정하기" onclick="updateReview('\${reviewNo}');">
											<input type="button" value="삭제하기" onclick="deleteReview('\${reviewNo}');">
										</div>
								</th>
							</tr>
						</div>
						
					`;
					
					
				} else { // 게시글 작성자 이외
					container.innerHTML += imgElements + `
						<div class = "content-container">
							<p class ="photoDate">\${regDate}</p>
							<div class="info-container">
								<p class ="product">🥗\${product}🥗</p>
								<p class ="writer">작성자 : \${writer}</p></p>
							<p class ="content">내용 : \${content}</p>
						</div>
					<tr>			
						<th colspan="2" id="th">
						
						<%if(isHeart){ //비로그인사용자 하트안보이기 %> 
								<div class="heart-container">
						            <input type="hidden" name="reviewNo" value="\${reviewNo}"/>
						            <input type="image" src="<%= request.getContextPath() %>/images/review/emptyheart.png" alt="heart.png" style="width: 30px;" class="heart" value="\${reviewNo}">
						            <p id="p">0</p>
				          	 	</div>
				         <%} %>
				  		    
							<% 	if(admin){// & 관리자 %> 
							<div class = "button-container">
									
								<input type="button" value="수정하기" onclick="updateReview('\${reviewNo}');">
									
								<input type="button" value="삭제하기" onclick="deleteReview('\${reviewNo}');">
							</div>
							<% 	} %>
						</th>
					</tr>
				</div>
				
					`;
				}
			})
		},
		complete(){
			document.querySelector("#cpage").innerHTML = cpage;
			
			if(cpage === <%=totalPage%>){
				const btn = document.querySelector("#btn-more");
				btn.disabled = true;
				btn.style.cursor = "not-allowed";
			}
			like();
		}
	});
}


function deleteReview(reviewNo){
	if(confirm("정말 리뷰를 삭제하시겠습니까?")){
		document.getElementById("reviewNo").value = reviewNo;
     
		document.reviewDelFrm.submit();
	}
}
function updateReview(reviewNo){
	location.href = "<%=request.getContextPath()%>/review/reviewUpdate?reviewNo=" + reviewNo;
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
