<%@page import="com.semi.mvc.review.model.vo.AttachmentReview"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.mvc.review.model.vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reviewUpdate.css" />
<%
	Review r = (Review) request.getAttribute("review");
	List<AttachmentReview> attachments = r.getAttachments();
%>

<section id="review-container">
<h2>리뷰 수정</h2>
<form action="<%=request.getContextPath() %>/review/reviewUpdate" method="post" enctype="multipart/form-data">
	<input type="hidden" name="reviewNo" value="<%= r.getReviewNo() %>" />
	<table id="tbl-review-view">
	
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="writer" value="<%= r.getWriter() %>" readonly/>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td >
			<% 
				if(attachments != null && !attachments.isEmpty()) {
					for (int i = 0; i < attachments.size(); i++) {
						AttachmentReview attach = attachments.get(i);
			%>
				<div style="padding: 0;">
					<img src="<%= request.getContextPath() %>/images/cart/salad.png" width="16px"> 
					<label for="delFile<%= i %>"><%= attach.getOriginalFilename() %> 삭제</label>
					<input type="checkbox" name="delFile" id="delFile<%= i %>" value="<%= attach.getNo() %>"/>				
				</div>	
			<% 
					}
				}
			%>
		
			<input type="file" name="upFile1" />
			<input type="file" name="upFile2" />
		</td>
		</th>
	</tr>
	<tr>
		<th>수정내용</th>
		<td><textarea rows="5" cols="50" name="content"><%= r.getContent() %></textarea></td>
	</th>
	</tr>
</table>
	
	<div class="button-container">
			<input type="submit" value="수정하기">
			<input type="button" value="취소" onclick="history.go(-1);">
	</div>	
	
</form>
</section>
<script>
document.reviewUpdateFrm.onsubmit = (e) => {
	const frm = e.target;
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	const contentVal = frm.content.value.trim();
	alert(contentVal);
	if(!/^(.|\n)+$/.test(contentVal)){
		alert("내용을 작성해주세요.");
		frm.content.select();
		return false;
	}
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>