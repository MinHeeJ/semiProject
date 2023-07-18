<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.semi.mvc.board.model.vo.Board" %>
<%@ page import="com.semi.mvc.board.model.vo.BoardComment" %>
<%@ page import="com.semi.mvc.board.model.vo.Attachment" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Board board = (Board) request.getAttribute("board");
	List<Attachment> attachments = board.getAttachments();
	List<BoardComment> boardComments = (List<BoardComment>) request.getAttribute("boardComments");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
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
		<% 	
			if (attachments != null && !attachments.isEmpty()) { 
				for(Attachment attach : attachments) {
		%>
					<tr>
						<th>첨부파일</th>
						<td>
							<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
							<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width=16px>
							<a href="<%= request.getContextPath() %>/board/fileDownload?no=<%= attach.getBoardNo() %>"><%= attach.getOriginalFilename() %></a>
						</td>
					</tr>
		<% 	
				}
			} 
		%>
		<tr>
			<th>내 용</th>
			<td>
				<textarea readonly style="resize: none;" rows="10"><%= board.getContent() %></textarea>
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
		<%	if(boardComments == null || boardComments.isEmpty()) { %>
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
						<textarea readonly style="resize: none;" rows="10"><%= board.getContent() %></textarea>
					</td>
				</tr>
				<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
				<% if (canEdit) { %>
				<tr>			
					<th colspan="2">
						<%-- 첨부파일이 없는 게시물 수정 --%>
						<input type="button" value="수정하기" onclick="updateComment()">
						<input type="button" value="삭제하기" onclick="deleteComment()">
					</th>
				</tr>
				<% 	} %>
			</table>
		<% 	} %>
	</div>
	<form 
		action="<%= request.getContextPath() %>/board/boardCommentDelete" 
		name="boardCommentDelFrm"
		method="POST">
		<input type="hidden" name="no" />
		<input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>"/>
	</form>
	<script>
	document.querySelectorAll(".btn-delete").forEach((button) => {
		button.onclick = (e) => {
			if(confirm("해당 댓글을 삭제하시겠습니까?")){
				const frm = document.boardCommentDelFrm;
				const {value} = e.target;
				console.log(value);
				frm.no.value = value;
				frm.submit();
			}
		}
	});
	
	document.querySelectorAll(".btn-reply").forEach((button) => {
		button.onclick = (e) => {
			const {value} = e.target;
			const parentTr = e.target.parentElement.parentElement;
			console.log(parentTr);
			
			const tr = `
				<tr>
					<td colspan="2">
						<form
							action="<%=request.getContextPath()%>/board/boardCommentCreate" 
							method="post"
							name="boardCommentFrm">
			                <input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>" />
			                <input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />
			                <input type="hidden" name="commentLevel" value="2" />
			                <input type="hidden" name="commentRef" value="\${value}" />    
							<textarea name="content" cols="60" rows="1"></textarea>
			                <button type="submit" class="btn-comment-enroll2">등록</button>
			            </form>
					</td>
				</tr>
			`;
			// beforebegin 시작태그전 - 이전형제요소로 추가
			// afterbegin 시작태그후 - 첫자식요소로 추가
			// beforeend 종료태그전 - 마지막요소로 추가
			// afterend 종료태그후 - 다음형제요소로 추가
			parentTr.insertAdjacentHTML('afterend', tr);
			
			button.onclick = null; // 이벤트핸들러 제거 (1회용)
		};
	});
	
	// 이벤트버블링을 이용한 textarea focus핸들러
	// focus, blur 버블링되지 않음. 대신 focusin, focusout 사용.
	document.addEventListener("focusin", (e) => {
		if(e.target.matches("form[name=boardCommentFrm] textarea")) {
			<% 	if (loginMember == null) { %>
				loginAlert();
			<% 	} %>
		}
	});
	
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
		document.boardDeleteFrm.submit();
};	

const updateComment = () => {
	location.href = "<%= request.getContextPath() %>/board/boardUpdate?no=<%= boardComments.get(0).getBoardNo() %>";
};
</script>
<% }} %>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>