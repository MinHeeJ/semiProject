<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.semi.mvc.board.model.vo.FaqBoard" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/faq.css" />
<%
	List<FaqBoard> faqs = (List<FaqBoard>) request.getAttribute("FaqBoard");
%>
<section class="faqContainer">
	<% boolean admin = loginMember != null && (loginMember.getMemberRole() == MemberRole.A); %>
	<%	if (admin) { %>
		<input 
			type="button" id="btn-add" value="글쓰기" 
			onclick="location.href = '<%= request.getContextPath() %>/board/faqUpdate';"/>
	<%  } %>
	<% if(faqs != null) { %>
		<% for(FaqBoard faq : faqs){ %>
			<div class="title">faq.getTitle()</div>
			<p class="content">faq.getContent()</p>
			<% if(admin){ %>
			<input type="button" id="btn-update" value="수정" onclick="location.href = '<%= request.getContextPath() %>/board/faqUpdate?no=<%= faq.getBoardNo() %>';"/>
			<% } %>
		<% } %>
	<% } %>
	<div class="title">title</div>
	<p class="content">content</p>
	<div class="title">title</div>
	<p class="content">content</p>
<script>
	$('div.title').click((e) => {
		$(e.target).next().slideToggle().siblings('p.content').slideUp();
	});
	
</script>
</section>