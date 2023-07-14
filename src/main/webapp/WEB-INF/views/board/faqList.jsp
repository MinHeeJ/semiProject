<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.semi.mvc.board.model.vo.FaqBoard" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/faq.css" />
<section class="faqContainer">
	<%	if (loginMember != null && (loginMember.getMemberRole() == MemberRole.A)) { %>
		<input 
			type="button" id="btn-add" value="글쓰기" 
			onclick="location.href = '<%= request.getContextPath() %>/board/faqCreate;"/>
	<%  } %>

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