<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.semi.mvc.board.model.vo.FaqBoard" %>
<%@ page import="com.semi.mvc.board.model.vo.Attachment" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/board/boardTap.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/faq3.css"/>
<%
	List<FaqBoard> faqs = (List<FaqBoard>) request.getAttribute("faqs");
%>
<% boolean admin = loginMember != null && (loginMember.getMemberRole() == MemberRole.A); %>
<section class="faqContainer">
	<%	if (admin) { %>
		<div class="btnAddWrapper">
		<input 
			type="button" id="btn-add" value="글쓰기" 
			onclick="location.href = '<%= request.getContextPath() %>/board/faqCreate';"/>
		</div>
	<%  } %>
	<% if(faqs != null) { %>
		<% for(FaqBoard faq : faqs){ %>
			<div class="title"><%= faq.getTitle() %></div>
			<% List<Attachment> attachs = faq.getAttachments(); %>
			<% if (attachs != null && !attachs.isEmpty()) { %>
				<div class="content">
					<% for(Attachment attach : attachs){ %>
						<a href="<%= request.getContextPath() %>/upload/faq/<%= attach.getRenamedFilename() %>">
							<img src="<%= request.getContextPath() %>/upload/faq/<%= attach.getRenamedFilename() %>">
						</a>
					<% } %>
				<p>
				<%= faq.getContent() %>
				<% if(admin){ %>
					<div class="btnWrapper">
					<button class="btn-update" value="<%= faq.getBoardNo() %>">수정</button>
					<button class="btn-delete" value="<%= faq.getBoardNo() %>">삭제</button>
					</div>
				<% } %>		
				</p>
				</div>
			<% }else{ %>
				<div class="content">
				<p>
				<%= faq.getContent() %>
				<% if(admin){ %>
					<div class="btnWrapper">
					<button class="btn-update" value="<%= faq.getBoardNo() %>">수정</button>
					<button class="btn-delete" value="<%= faq.getBoardNo() %>">삭제</button>
					</div>
				<% } %>				
				</p>
				</div>
			<% } %>
		<% } %>
	<% } %>
	<form 
		action="<%= request.getContextPath() %>/board/faqDelete" 
		name="FaqDelFrm"
		method="POST">
		<input type="hidden" name="boardNo" />
	</form>
		<form 
		action="<%= request.getContextPath() %>/board/faqUpdate" 
		name="FaqUpFrm"
		method="GET"
		enctype="multipart/form-data">
		<input type="hidden" name="boardNo" />
	</form>
</section>

<script>
	$('div.title').click((e) => {
		$(e.target).next().slideToggle().siblings('.content').slideUp();
	});

	document.querySelectorAll(".btn-delete").forEach((button) => {
		button.onclick = (e) => {
			if(confirm("해당 글을 삭제하시겠습니까?")){
				const frm = FaqDelFrm;
				const {value} = e.target;
				console.log(value);
				frm.boardNo.value = value;
				frm.submit();
			}
		}
	});
	
	document.querySelectorAll(".btn-update").forEach((button) => {
		button.onclick = (e) => {
			if(confirm("해당 글을 수정하시겠습니까?")){
				const frm = document.FaqUpFrm;
				const {value} = e.target;
				console.log(value);
				frm.boardNo.value = value;
				frm.submit();
			}
		}
	});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>