<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<section class="faqContainer">
		<%	if (loginMember != null && loginMember.getMemberRole() == MemberRole.A) { %>
		<input 
			type="button" id="btn-add" value="글쓰기" 
			onclick="location.href = '<%= request.getContextPath() %>/board/boardCreate';"/>
	<%  } %>
</section>