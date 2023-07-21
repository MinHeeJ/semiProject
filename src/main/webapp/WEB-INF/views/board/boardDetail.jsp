<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.semi.mvc.board.model.vo.Board" %>
<%@ page import="com.semi.mvc.board.model.vo.BoardComment" %>
<%@ page import="com.semi.mvc.board.model.vo.Attachment" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/board/boardTap.jsp" %>
<%
	Board board = (Board) request.getAttribute("board");
	List<Attachment> attachments = board.getAttachments();
	List<BoardComment> boardComments = (List<BoardComment>) request.getAttribute("boardComments");
%>
<script>
	window.onload = () => {
		<% if(loginMember.getMemberRole() == MemberRole.A || (loginMember.getMemberId()).equals(board.getWriter())) { %>

		<% }else{ %>
			alert("접근권한이 없습니다");
			location.href = "<%= request.getContextPath() %>"
		<% } %>
	}
</script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board2.css" />
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		<tr>
			<th>글번호</th>
			<td><%= board.getBoardNo() %></td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><%= board.getTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%= board.getWriter() %></td>
		</tr>
		<tr>
			<th>내 용</th>
			<td>
				<% if (attachments != null && !attachments.isEmpty()) { %>
					<div class="content">
						<% for(Attachment attach : attachments){ %>
							<a href="<%= request.getContextPath() %>/upload/board/<%= attach.getRenamedFilename() %>">
								<img src="<%= request.getContextPath() %>/upload/board/<%= attach.getRenamedFilename() %>">
							</a>
						<% } %>
					<p><%= board.getContent() %><p>
					</div>
				<% }else{ %>
					<p><%= board.getContent() %><p>
				<% } %>
			</td>
		</tr>
		<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
		<% 	
			boolean canEdit = loginMember != null 
					&& (loginMember.getMemberId().equals(board.getWriter()) 
							|| loginMember.getMemberRole() == MemberRole.A);
			if (canEdit) { %>
		<tr>			
			<th colspan="2">
				<%-- 첨부파일이 없는 게시물 수정 --%>
				<input type="button" value="수정하기" onclick="updateBoard()">
				<input type="button" value="삭제하기" onclick="deleteBoard()">
			</th>
		</tr>
		<% 	} %>
	</table>
	
	<hr style="margin-top:30px;" />	
    
	<div class="comment-container">
		<%	if(loginMember != null && loginMember.getMemberRole() == MemberRole.A && (boardComments == null || boardComments.isEmpty())) { %>
        <div class="comment-editor">
            <form
				action="<%=request.getContextPath()%>/board/boardCommentCreate" 
				method="post" 
				name="boardCommentFrm">
                <input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>" />
                <input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />  
				<textarea name="content" cols="60" rows="3"></textarea>
                <button type="submit" id="btn-comment-enroll1">등록</button>
            </form>
        </div>
        <% } %>
		<!--table#tbl-comment-->
		<%	if(boardComments != null && !boardComments.isEmpty()) { %>
			<table id="tbl-comment">
				<%
					for(BoardComment bc : boardComments) {
						boolean canRemove = 
								loginMember != null && 
								(loginMember.getMemberId().equals(bc.getWriter())
								  || MemberRole.A == loginMember.getMemberRole());
				%>
				<tr>
					<th>글번호</th>
					<td><%= bc.getBoardNo() %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%= bc.getWriter() %></td>
				</tr>
				<tr>
					<th>내 용</th>
					<td>
						<p><%= bc.getContent() %><p>
					</td>
				</tr>
				<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
				<% if (loginMember.getMemberRole() == MemberRole.A) { %>
				<tr>			
					<th colspan="2">
						<%-- 첨부파일이 없는 게시물 수정 --%>
						<input type="button" value="수정하기" onclick="updateComment()">
						<input type="button" value="삭제하기" onclick="deleteComment()">
					</th>
				</tr>
				<% } %>
			</table>
			
			<% if(loginMember != null && loginMember.getMemberId().equals(board.getWriter()) && (boardComments != null && !boardComments.isEmpty())) { %>
				<div class="addQuestion">
					<input 
					type="button" id="btn-add" value="추가질문하기" 
					onclick="location.href = '<%= request.getContextPath() %>/board/boardCreate';"/>
				</div>
			<% } %>	
			
			<% } %>
		<% } %>
	</div>
	<br>
	<br>
	<br>
	<br>
	<script>
	
	// 이벤트버블링을 이용한 폼유효성 검사 
	document.addEventListener("submit", (e) => {
		
		// 특정선택자와 매칭여부 matches
		if (e.target.matches("form[name=boardCommentFrm]")) {			
			<% 	if (loginMember == null) { %>
				loginAlert();
				e.preventDefault();
				return;
			<% 	} %>
			
			const frm = e.target;
			const content = frm.content;
			
			if(!/^(.|\n)+$/.test(content.value)) {
				alert("내용을 작성해주세요.");
				e.preventDefault();
				return;
			}
		}
		
	});
	
	const loginAlert = () => {
		alert("로그인후 댓글을 작성할 수 있습니다.");
		document.querySelector("#memberId").focus();
	};

	</script>
	
	
	
</section>
<% if(canEdit) { %>
<form action="<%= request.getContextPath() %>/board/boardDelete" name="boardDeleteFrm" method="POST">
	<input type="hidden" name="no" value="<%= board.getBoardNo() %>" />
</form>
<form action="<%= request.getContextPath() %>/board/boardCommentDelete" name="boardCommentDeleteFrm" method="POST">
	<% if (!boardComments.isEmpty()) { %>
	<input type="hidden" name="no" value="<%= boardComments.get(0).getCommentNo() %>" />
	<input type="hidden" name="boardNo" value="<%= boardComments.get(0).getBoardNo() %>"/>
	<% } %>
</form>
	</form>
		<form 
		action="<%= request.getContextPath() %>/board/boardCommentUpdate" 
		name="boardCommentUpdateFrm"
		method="GET">
		<% if (!boardComments.isEmpty()) { %>
		<input type="hidden" name="no" value="<%= boardComments.get(0).getCommentNo() %>" />
		<input type="hidden" name="boardNo" value="<%= boardComments.get(0).getBoardNo() %>"/>
		<% } %>
	</form>
<% } %>
<script>
/**
 * POST /board/boardDelete
 * - no전송
 * - 저장된 파일 삭제 : java.io.File 
 */
const deleteBoard = () => {
	if(confirm("정말 이 게시글을 삭제하시겠습니까?"))
		document.boardDeleteFrm.submit();
};	

const updateBoard = () => {
	location.href = "<%= request.getContextPath() %>/board/boardUpdate?no=<%= board.getBoardNo() %>";
};
const deleteComment = () => {
	if(confirm("정말 이 게시글을 삭제하시겠습니까?"))
		document.boardCommentDeleteFrm.submit();
};	

const updateComment = () => {
	<% if(boardComments != null && !boardComments.isEmpty()) { %>
		location.href = "<%= request.getContextPath() %>/board/boardCommentUpdate?no=<%= boardComments.get(0).getBoardNo() %>";
	<% } %>
};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>