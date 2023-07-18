<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.semi.mvc.board.model.vo.FaqBoard" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/faq.css" />
<%
	List<FaqBoard> faqs = (List<FaqBoard>) request.getAttribute("faqs");
%>
<% boolean admin = loginMember != null && (loginMember.getMemberRole() == MemberRole.A); %>
<section class="faqContainer">
	<%	if (admin) { %>
		<input 
			type="button" id="btn-add" value="글쓰기" 
			onclick="location.href = '<%= request.getContextPath() %>/board/faqCreate';"/>
	<%  } %>
	<% if(faqs != null) { %>
		<% for(FaqBoard faq : faqs){ %>
			<div class="title"><%= faq.getTitle() %></div>
			<p class="content"><%= faq.getContent() %></p>
			<p><%= faq.getBoardNo() %></p>
			<% if(admin){ %>
				<button class="btn-update" value="<%= faq.getBoardNo() %>">수정</button>
				<button class="btn-delete" value="<%= faq.getBoardNo() %>">삭제</button>
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
		method=""
		enctype="multipart/form-data">
		<input type="hidden" name="boardNo" />
	</form>
</section>

<script>
	$('div.title').click((e) => {
		$(e.target).next().slideToggle().siblings('p.content').slideUp();
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