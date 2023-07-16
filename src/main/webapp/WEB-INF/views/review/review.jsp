<%@page import="com.semi.mvc.review.model.vo.AttachmentReview"%>
<%@page import="com.semi.mvc.review.model.vo.Review"%>
<%@page import="com.semi.mvc.order.model.vo.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<% 
	int totalPage = (int) request.getAttribute("totalPage");  
	int cpage = (int) request.getAttribute("cpage");
	List<Order> orders = (List<Order>)request.getAttribute("orders");
	String product = (String) request.getAttribute("product");
	List<Review> reviews = (List<Review>)request.getAttribute("reviews");
	String memberId = (String) request.getAttribute("memberId");
	
%>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
 <link rel="stylesheet" href="<%=request.getContextPath()%>/css/review.css" />
<section id="review-container">
	<h2>리뷰작성</h2>
	<form
		name="reviewOrderListFrm"
		action="<%=request.getContextPath() %>/review/reviewOrderList" 
		method="POST"
		enctype="multipart/form-data">
	
		<table id="tbl-order-review">
		<thead>
			<tr>
				
				<th>주문상품</th>
			
			
			</tr>
		</thead>
		
		<tbody>
			<% 	if(orders == null || orders.isEmpty()) { %>
			<tr>
				<td colspan="4">작성할 리뷰가 없습니다.</td>
			</tr>
			<%	
				} 
				else { 
					for(Order order : orders) {
			%>
				<tr>
					<td>
						<input type="radio" name="orderSerialNo" value="<%= order.getOrderSerialNo() %>"/> <%= order.getProduct() %>
					</td>
				</tr>
				<% 		
					}
				} 
			%>
		</tbody>
	</table>
	
	
		<% 	if(!(orders == null || orders.isEmpty())) { %>
		<table id="tbl-board-view">
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" name="writer" id="writer" value="<%=memberId%>"readonly/>
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>			
				<input type="file" name="upFile1">
				<input type="file" name="upFile2">
			</td>
		</tr>
		<tr>
			<th>내 용</th>
			<td><textarea rows="5" cols="40" id = "content" name="content"></textarea></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" value="등록하기" >
			</th>
		</tr>
	</table>
	<%}%>
	</form>
</section>



<section id="photo-review-wrapper">
	<h2>리뷰게시판</h2>
	
	<div id="photo-review-container">
	<% 	if(reviews == null || reviews.isEmpty()) { %>
			<tr>
				<td>리뷰가 없습니다.</td>
			</tr>
			<%	
				} 
				else { 
					for(Review review : reviews){
						List<AttachmentReview> files = review.getAttachments();
			%>
				<tr>
					
				<div class="polaroid">
						<p class="photo"></p>
							<%for(AttachmentReview file : files){ %>
								<img src ="<%= request.getContextPath()%>/upload/review/<%=file.getRenamedFilename() %>">
							<%} %>
						</p>
						<p class="info">
							<p class ="no"><%= review.getReviewNo() %></p>
							<span class ="writer"><%= review.getWriter() %></span>
							<span class ="photoDate"><%= review.getRegDate() %></span>
						</p>
						<p class ="content"><%= review.getContent() %></p>
						<p class ="product"><%= review.getProduct() %></p>
						
					</div>
					<tr>			
						<th colspan="2">
							<%-- 첨부파일이 없는 게시물 수정 --%>
							<input type="button" value="수정하기" onclick="updateReview()">
							
							<input type="button" value="삭제하기" onclick="deleteReview('<%= review.getReviewNo()%>');">
							
							
						</th>
					</tr>
				</tr>
				<% 		
					}
				} 
			%>
	
	
	<!--  <div class="polaroid">
	<img src ="">
	<p class="info">
	<span class ="writer"></span>
	<span class ="photoDate"></span>
	</p>
	<p class ="caption"></p>
	</div>
	 -->
	</div>
	
	<hr />
	
	<div id='btn-more-container'>
		<button id="btn-more" value="">더보기(<span id="cpage"><%= cpage %></span>/<span id="totalPage"><%= totalPage %></span>)</button>
	</div>
</section>
<form action="<%= request.getContextPath() %>/review/reviewDelete" name="reviewDelFrm" method="POST" >
	<input type="hidden" name="reviewNo" id="reviewNo" value=""/>

</form>

<script>
/**
* reviewCreateFrm 유효성 검사
*/

<!--
document.reviewCreateFrm.onsubmit = (e) => {
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
-->

document.querySelector("#btn-more").onclick = () =>{
	const cpage = Number(document.querySelector("#cpage").innerHTML);
	const nextPage = cpage + 1;
	getPage(nextPage);
};
<!--
window.addEventListener('load', () => { 
	getPage(1);
});
-->
const getPage = (cpage) => {
	
	$.ajax({
		url : "<%= request.getContextPath() %>/review/reviewMore",
		data : {cpage},
		success(reviews) {
			console.log(reviews);
			const container = document.querySelector("#photo-review-container");
			reviews.forEach((Review)=>{
				const {reviewNo,writer, title, content, regDate,product} =Review;
				container.innerHTML += `
					<div class="polaroid">
					<img src ="<%= request.getContextPath()%>/upload/photo/\${renamedFilename}">
						<p class="info">
							<span class ="writer">\${writer}</span>
							<span class ="photoDate">\${regDate}</span>
						</p>
					<p class ="caption">\${content}</p>
				</div>
				`;
			})
		},
		complete(){
			document.querySelector("#cpage").innerHTML = cpage;
			
			if(cpage === <%= totalPage%>){
				const btn = document.querySelector("#btn-more");
				btn.disabled = true;
				btn.style.cursor = "not-allowed";
			}
		}
	});
	
}


function deleteReview(reviewNo){
	if(confirm("정말 리뷰를 삭제하시겠습니까?")){
		document.getElementById("reviewNo").value = reviewNo;
     
		document.reviewDelFrm.submit();
	}
}

const updateReview = () => {
	location.href = "<%= request.getContextPath() %>/review/reviewCreate %>";
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>