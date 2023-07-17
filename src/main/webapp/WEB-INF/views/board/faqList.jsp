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
			<% if(admin){ %>
				<input type="button" value="수정하기" onclick="updateFaqBoard()">
				<input type="button" value="삭제하기" onclick="deleteFaqBoard()">
			<form action="<%= request.getContextPath() %>/board/faqDelete" name="faqDeleteFrm" method="POST">
				<input type="hidden" name="boardNo" value="<%= faq.getBoardNo() %>" />
			</form>
			<% } %>
		<% } %>
	<% } %>
</section>

<script>
	$('div.title').click((e) => {
		$(e.target).next().slideToggle().siblings('p.content').slideUp();
	});

	const deleteFaqBoard = (e) => {
		if(confirm("정말 이 게시글을 삭제하시겠습니까?"))
			document.forms["faqDeleteFrm"].submit();
	};
	
	const updateFaqBoard = (e) => {
<%-- 		location.href = "<%= request.getContextPath() %>/board/faqUpdate?no=<%= faq.getBoardNo() %>"; --%>
	}

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>