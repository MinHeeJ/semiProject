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
						
						
					<!-- ajax -->
						
						
				   </div>  
			</tr>
			<% 		
				}
			} 
		%>
	  </div>  
	
	<div id='btn-more-container'>
		<button id="btn-more" value="">더보기(<span id="cpage"><%= cpage %></span>/<span id="totalPage"><%= totalPage %></span>)</button>
	</div>
	
</section>
</section>
<form action="<%= request.getContextPath() %>/review/reviewDelete" name="reviewDelFrm" method="POST" >
	<input type="hidden" name="reviewNo" id="reviewNo" value=""/>
</form>


<script>
// 좋아요
window.onload = () => {
  like();
};

const like = () => {
  const reviewNoElements = document.querySelectorAll('input[name="reviewNo"]');
  reviewNoElements.forEach((reviewNoElement) => {
    const reviewNo = reviewNoElement.value;

    $.ajax({
      url: "<%= request.getContextPath() %>/review/like",
      method: "POST",
      data: {
        reviewNo: reviewNo,
      },
      success(responseData) {
        console.log(responseData);
        const { likeCount, isLike } = responseData;
        console.log(likeCount);
        console.log(isLike);

        const thElements = document.querySelectorAll(".th");
        thElements.forEach((thElement) => {
          if (thElement.dataset.reviewNo === reviewNo) {
            if (isLike) {
              thElement.innerHTML = `
                <img src="<%= request.getContextPath() %>/images/review/heart.png" alt="heart.png" style="width: 30px;">
                <p>${likeCount}</p>
              `;
            } else {
              thElement.innerHTML = `
                <img src="<%= request.getContextPath() %>/images/review/emptyheart.png" alt="emptyheart.png" style="width: 30px;">
                <p>${likeCount}</p>
              `;
            }
          }
        });
      },
    });
  });
};

document.querySelectorAll(".heart").forEach((heart) => {
  heart.addEventListener("click", (e) => {
    console.log(e.target.value);
    e.preventDefault();
    $.ajax({
      url: "<%= request.getContextPath() %>/review/like",
      method: "POST",
      data: {
        reviewNo: e.target.value,
      },
      success(responseData) {
        console.log(responseData);
        const { likeCount, isLike } = responseData;
        console.log(likeCount);
        console.log(isLike);

        const thElements = document.querySelectorAll(".th");
        thElements.forEach((thElement) => {
          if (thElement.dataset.reviewNo === e.target.value) {
            if (isLike) {
              thElement.innerHTML = `
                <input type="image" src="<%= request.getContextPath() %>/images/review/heart.png" alt="heart.png" style="width: 30px;" class="heart" value="${e.target.value}">
                <p>${likeCount}</p>
              `;
            } else {
              thElement.innerHTML = `
                <input type="image" src="<%= request.getContextPath() %>/images/review/emptyheart.png" alt="emptyheart.png" style="width: 30px;" class="heart" value="${e.target.value}">
                <p>${likeCount}</p>
              `;
            }
          }
        });
      },
    });
  });
});
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
	
	$.ajax({
		url : "<%= request.getContextPath() %>/review/reviewMore",
		data : {cpage},
		success(reviews) {
			console.log(reviews);
			const container = document.querySelector(".polaroid");
			
			reviews.forEach((Review)=>{
				const {reviewNo,writer, content, regDate,product,attachments} =Review;
				let renamedFile = "";
				let imgElements = "";
				
				for (let i = 0; i < attachments.length; i++) {
				    const attachment = attachments[i];
				    const { renamedFilename } = attachment;
				    renamedFile = renamedFilename;

				    imgElements += `<img src="<%= request.getContextPath()%>/upload/review/\${renamedFile}">`;
				  }
				
				
				container.innerHTML += imgElements + `
					<p class="info">
							<span class ="writer">\${writer}</span>
							<span class ="photoDate">\${regDate}</span>
						</p>
					<p class ="product">\${product}</p>
					<p class ="caption">\${content}</p>
				
					<tr>			
					<th colspan="2" id="th">
						<div>
				            <input type="hidden" name="reviewNo" value="\${reviewNo}"/>
				            <input type="image" src="<%= request.getContextPath() %>/images/review/heart.png" alt="heart.png" style="width: 30px;" class="heart" value="\${reviewNo}">
				            <p>0</p>
		          	 	</div>
						<%-- 첨부파일이 없는 게시물 수정 --%>
							<input type="button" value="수정하기" onclick="updateReview('\${reviewNo}');">
								
							<input type="button" value="삭제하기" onclick="deleteReview('\${reviewNo}');">
					</th>
				</tr>
				`;
			})
		},
		complete(){
			document.querySelector("#cpage").innerHTML = cpage;
			
			if(cpage === <%= totalPage%>|| cpage == 1){
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

function updateReview(reviewNo){
	location.href = "<%= request.getContextPath() %>/review/reviewUpdate?reviewNo=" + reviewNo;
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>