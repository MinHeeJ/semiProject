<%@page import="com.semi.mvc.board.model.vo.Attachment"%>
<%@page import="java.util.List"%>
<%@ page import="com.semi.mvc.board.model.vo.Board" %>
<%@ page import="com.semi.mvc.board.model.vo.BoardComment" %>
<%@ page import="com.semi.mvc.board.model.vo.Attachment" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<%
	Board board = (Board) request.getAttribute("board");
	List<Attachment> attachments = board.getAttachments();
	List<BoardComment> boardComments = (List<BoardComment>) request.getAttribute("boardComments");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<section id="board-container">
<h2>게시판 수정</h2>
<form action="<%=request.getContextPath() %>/board/boardCommentUpdate" method="post">
	<input type="hidden" name="no" value="<%= boardComments.get(0).getBoardNo() %>" />
	<table id="tbl-board-view">
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="writer" value="<%= boardComments.get(0).getWriter() %>" readonly/>
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="50" name="content"><%= boardComments.get(0).getContent() %></textarea></td>
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
document.boardUpdateFrm.onsubmit = (e) => {
	const frm = e.target;
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	const titleVal = frm.title.value.trim(); // 좌우공백	
					   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	const contentVal = frm.content.value.trim();
	if(!/^(.|\n)+$/.test(contentVal)){
		alert("내용을 작성해주세요.");
		frm.content.select();
		return false;
	}
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>