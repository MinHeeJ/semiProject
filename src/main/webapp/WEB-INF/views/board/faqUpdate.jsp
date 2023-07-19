<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.semi.mvc.board.model.vo.FaqBoard" %>
<%@ page import="com.semi.mvc.board.model.vo.Attachment" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/board/boardTap.jsp" %>
<%
	FaqBoard faq = (FaqBoard) request.getAttribute("faq");
	List<Attachment> attachments = faq.getAttachments();
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/faq3.css"/>
<section class="faqUpdateContainer">
	<form name="faqUpdateFrm" action="<%= request.getContextPath() %>/board/faqUpdate" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="boardNo" value="<%= faq.getBoardNo() %>" />
		<table id="faqUpdateTable">
		<tr>
			<th>제 목</th>
			<td><input type="text" name="title" required></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" name="writer" value="<%= loginMember.getMemberId() %>" readonly/>
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
				<input type="submit" value="수정하기">
				<input type="button" value="취소" onclick="history.go(-1);">
			</th>
		</tr>
		</table>
	</form>
</section>
<script>
	document.faqUpdateFrm.onsubmit = (e) => {
		const frm = e.target;
		const title = e.target.title;
		
		if(!/^.+$/.test(title.value)) {
			alert("제목을 작성해주세요.");
			return false;
		}
		return true;
	};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>