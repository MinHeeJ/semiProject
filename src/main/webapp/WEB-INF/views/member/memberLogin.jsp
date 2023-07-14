<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<section id="login-container">
    <h2>로그인</h2>
    <form name="memberLoginFrm" action="${pageContext.request.contextPath}/member/login" method="POST">
        <div>
            <label for="memberId">아이디:</label>
            <input type="text" id="memberId" name="memberId" required>
        </div>
        <div>
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <input type="submit" value="로그인">
        </div>
    </form>
    <div>
        <a href="${pageContext.request.contextPath}/member/memberEnroll">회원가입</a>
    </div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<%
    // Login Logic
    String memberId = request.getParameter("memberId");
    String password = request.getParameter("password");

    if (memberId != null && password != null) {
        // Perform login authentication logic here
        // Example:
        if (memberId.equals("admin") && password.equals("admin123")) {
            // Successful login, redirect to home page or desired destination
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            // Invalid credentials, display error message
            out.println("Invalid credentials. Please try again.");
        }
    }
%>
