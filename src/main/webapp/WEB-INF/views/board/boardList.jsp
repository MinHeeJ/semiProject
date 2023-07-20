<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.semi.mvc.board.model.vo.Board" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/board/boardTap.jsp" %>
<%
	List<Board> boards = (List<Board>) request.getAttribute("boards");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board2.css" />
<section id="board-container">
	<h2>게시판 </h2>
	
	<%	if (loginMember != null) { %>
		<input 
			type="button" id="btn-add" value="글쓰기" 
			onclick="location.href = '<%= request.getContextPath() %>/board/boardCreate';"/>
	<%  } %>
	
	<table id="tbl-board">
		<thead>
			<tr>
				<th class="t1">번호</th>
				<th class="t2">제목</th>
				<th class="t3">작성자</th>
				<th class="t4">작성일</th>
				<th class="t5">첨부파일</th><%--첨부파일이 있는 경우 /images/file.png 표시 width:16px --%>
			</tr>
		</thead>
		<tbody>
			<% 
				if(boards != null && !boards.isEmpty()){ 
					for(Board board : boards){
			%>
						<tr>
							<td class="t1"><%= board.getBoardNo() %></td>
							<td class="t2">
								<% if(loginMember.getMemberId().equals(board.getWriter()) || loginMember.getMemberRole() == MemberRole.A) { %>
									<a href="<%= request.getContextPath() %>/board/boardDetail?no=<%= board.getBoardNo() %>"><%= board.getTitle() %></a>
									<%	if(board.getCommentCnt() > 0) { %>
									<%-- [<%= board.getCommentCnt() %>] --%>
									✉		
									<% } %>
								<% }else{ %>
									<%= board.getTitle() %>
								<% } %>
							</td>
							<td class="t3"><%= board.getWriter() %></td>
							<td class="t4"><%= board.getRegDate() %></td>
							<td class="t5">
								<%	if (board.getAttachCnt() > 0) { %>
									<img src="<%= request.getContextPath() %>/images/board/file.png" alt="" style="width:16px;" />
								<% 	} %>
							</td>
						</tr>
			<%		
					}
				} 
				else { 
			%>
				<tr>
					<td colspan="6">조회된 게시글이 없습니다.</td>
				</tr>
			<%  } %>
		</tbody>
	</table>

	<div id='pagebar'>
		<%= request.getAttribute("pagebar") %>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>