<%@page import="com.semi.mvc.member.model.vo.MemberRole"%>
<%@page import="com.semi.mvc.member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Member> members = (List<Member>) request.getAttribute("members");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<section id="memberList-container">
	<h1>회원 전체 조회</h1>
	
    <div id="memberList-wrapper">
		<table id="tbl-member">
            <thead>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>주소</th>
                    <th>성별</th>
                    <th>회원권한</th>
                </tr>
            </thead>
			<tbody>
			<% if(members == null || members.isEmpty()) { %>
				<tr>
					<td>조회 결과가 없습니다.</td>
				</tr>
			<%
				} 
				else {
					for(Member member : members) {
			%>
		                <tr>
		                    <td><%= member.getMemberId() %></td>
		                    <td><%= member.getName() %></td>
		                    <td><%= member.getPhone() %></td>
		                    <td><%= member.getAddress() %></td>
		                    <td><%= member.getGender() %></td>
		                    <td>
		                    	<select class="member-role" data-member-id="<%= member.getMemberId() %>">
		                    		<option value="U" <%= member.getMemberRole() == MemberRole.U ? "selected" : "" %>>일반</option>
		                    		<option value="A" <%= member.getMemberRole() == MemberRole.A ? "selected" : "" %>>관리자</option>
		                    	</select>
		                    </td>
		                    <td>
		                        <input type="button" value="삭제" onclick="deleteMember();">
		                    </td>
		                </tr>
            <%
					}
            	} 
            %>
            </tbody>
		</table>
	</div>
</section>
<!-- 회원권한 수정 -->
<form
	name="memberRoleUpdateFrm"
	action="<%= request.getContextPath() %>/admin/memberRoleUpdate"
	method="POST">
	<input type="hidden" name="memberRole"/>
	<input type="hidden" name="memberId"/>
</form>
<!-- 회원 삭제 -->
<form
	name="memberDeleteFrm"
	action="<%= request.getContextPath() %>/admin/memberDelete"
	method="POST">
	<% for(Member member : members) { %>
		<input type="hidden" name="memberId" value="<%= member.getMemberId() %>"/>
	<% } %>
</form>
<script>
// 회원삭제
const deleteMember = () => {
	if(confirm("회원을 삭제하시겠습니까?"))
		document.memberDeleteFrm.submit();
};

// 회원권한 수정
document.querySelectorAll("select.member-role").forEach((elem) => {
	elem.addEventListener("change", (e) => {
		
		if(confirm("회원권한을 수정하시겠습니까?")) {
			const memberRoleVal = e.target.value;
			const memberIdVal = e.target.dataset.memberId;
			
			const frm = document.memberRoleUpdateFrm;
			frm.memberRole.value = memberRoleVal;
			frm.memberId.value = memberIdVal;
			frm.submit();
		} 
		else {
			// option태그에 있는 selected속성이 있는 태그를 찾아서 selected속성을 true로 지정 -> 원래값 취소
			e.target.querySelector("option[selected]").selected = true;
		}
	});
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>