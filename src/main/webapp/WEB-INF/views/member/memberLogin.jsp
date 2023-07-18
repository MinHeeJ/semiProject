<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section id="login-container">
    <h2>로그인</h2>
    
    <%-- 에러 메시지가 있는 경우 표시 --%>
    <% String errorMsg = (String) session.getAttribute("msg"); %>
    <% if (errorMsg != null && !errorMsg.isEmpty()) { %>
        <p class="error-msg"><%= errorMsg %></p>
    <% } %>
    
    
    
    <%-- 잘못된 아이디가 있는 경우 표시 --%>
    <% String invalidId = (String) session.getAttribute("invalidId"); %>
    <% if (invalidId != null && !invalidId.isEmpty()) { %>
        <p class="error-msg">존재하지 않는 아이디입니다: <%= invalidId %></p>
    <% } %>
    
    <%-- 로그인 후에는 로그인 폼을 숨김 --%>
    <% if (loginMember == null) { %>
        <form name="loginFrm" action="${pageContext.request.contextPath}/member/memberLogin" method="POST">
            <div>
                <label for="memberId">아이디:</label>
                <input type="text" id="memberId" name="memberId" value="<%= invalidId %>" required>
            </div>
            <div>
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <label for="saveId">아이디 저장:</label>
                <input type="checkbox" id="saveId" name="saveId">
            </div>
            <div>
                <input type="submit" value="로그인">
            </div>
        </form>
        
        <div>
            <a href="${pageContext.request.contextPath}/member/memberEnroll">회원가입</a>
        </div>
    <% } %>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>