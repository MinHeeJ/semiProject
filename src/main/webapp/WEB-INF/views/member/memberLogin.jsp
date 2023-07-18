<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section id="login-container">
    
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
    
    <%-- 잘못된 비밀번호가 있는 경우 표시 --%>
    <% String invalidPassword = (String) session.getAttribute("invalidPassword"); %>
    <% if (invalidPassword != null && !invalidPassword.isEmpty()) { %>
        <p class="error-msg">비밀번호가 일치하지 않습니다.</p>
    <% } %>
    
    <form name="loginFrm" action="${pageContext.request.contextPath}/member/memberLogin" method="POST">
        <div>
            <label for="memberId">아이디:</label>
            <input type="text" id="memberId" name="memberId" required>
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
</section>

<% if(loginMember != null) { %>
    <script src="<%= request.getContextPath() %>/js/ws.js"></script>
<% } %>

<script>
    window.onload = () => {
        <% if(msg != null) { %>
            alert('<%= msg %>');
        <% } %>
        
        <% if(loginMember == null) { %>
            document.loginFrm.onsubmit = (e) => {
                // 아이디
                const memberId = e.target.memberId;
                if(!/^\w{4,}$/.test(memberId.value)) {
                    alert("아이디는 4글자 이상 입력하세요.");
                    e.preventDefault();
                    return;
                }
                
                // 비밀번호
                const password = e.target.password;
                if(!/^.{4,}$/.test(password.value)) {
                    alert("비밀번호는 4글자 이상 입력하세요.");
                    e.preventDefault();
                    return;
                }
            };
        <% } %>
    };
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
