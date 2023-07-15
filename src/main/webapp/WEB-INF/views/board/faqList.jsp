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
<% boolean admin = loginMember != null && (loginMember.getMemberRole() == MemberRole.A); %>
<section class="faqContainer">
	<%	if (admin) { %>
		<input 
			type="button" id="btn-add" value="글쓰기" 
			onclick="location.href = '<%= request.getContextPath() %>/board/faqUpdate';"/>
	<%  } %>
	<% if(faqs != null) { %>
		<% for(FaqBoard faq : faqs){ %>
			<div class="title"><%= faq.getTitle() %></div>
			<p class="content"><%= faq.getContent() %></p>
			<% if(admin){ %>
				<input type="button" value="수정하기" onclick="updateFaqBoard()">
				<input type="button" value="삭제하기" onclick="deleteFaqBoard()">
			<form action="<%= request.getContextPath() %>/board/faqDelete" name="faqDeleteFrm" method="POST">
				<input type="hidden" name="no" value="<%= faq.getBoardNo() %>" />
			</form>
			<script>
				const deleteFaqBoard = () => {
					if(confirm("정말 이 게시글을 삭제하시겠습니까?"))
						document.faqDeleteFrm.submit();
				};
				
				const updateFaqBoard = () => {
					location.href = "<%= request.getContextPath() %>/board/faqUpdate?no=<%= faq.getBoardNo() %>";
				}
			</script>
			<% } %>
		<% } %>
	<% } %>
	<div class="title">title</div>
	<p class="content">content</p>
	<div class="title">title</div>
	<p class="content">content</p>
</section>

<script>
	$('div.title').click((e) => {
		$(e.target).next().slideToggle().siblings('p.content').slideUp();
	});


</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>