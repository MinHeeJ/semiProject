<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    
<section id="review-container">
	<h2>리뷰작성</h2>
	<form
		name="reviewCreateFrm"
		action="<%=request.getContextPath() %>/review/reviewCreate" 
		method="post"
		enctype="multipart/form-data">
		<table id="tbl-board-view">
		<tr>
			<th>제 목</th>
			<td><input type="text" name="title" required></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" name="writer" value="<%= %>" readonly/>
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
			<td><textarea rows="5" cols="40" name="content"></textarea></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" value="등록하기">
			</th>
		</tr>
	</table>
	</form>
</section>
<script>
/**
* boardCreateFrm 유효성 검사
*/
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
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>