<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.semi.mvc.member.model.vo.Gender"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/memberDetail.css" />
<section id="login-container">

<%
	//로그인된 회원 정보를 변수에 저장(마이페이지 이동시 빈칸에 회원 목록 나오게 끔)
	String memberId = loginMember.getMemberId(); 
	String name = loginMember.getName();
	Gender gender = loginMember.getGender();
	String phone = loginMember.getPhone();
	String address = loginMember.getAddress();
	
	String[] adds = address.split(" ");
	String city = adds[0]; // 시/도
	String district = adds[1]; // 구/군
	String detailAd = adds[2]; // 상세주소 */
%>

<section id="enroll-container">
	<h2>회원 정보</h2>
	<form 
		name="memberUpdateFrm"
		action="<%= request.getContextPath() %>/member/memberUpdate" 
		method="post">
		<table>
			<tr>
				<th>아이디<sup>*</sup></th>
				<td>
					<input type="text" name="memberId" id="memberId" value="<%= memberId %>" readonly>
				</td>
			</tr>
			<tr>
				<th>이름<sup>*</sup></th>
				<td>	
				<input type="text"  name="name" id="name" value="<%= name %>"  required><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
			       		 <input type="radio" name="gender" id="gender0" value="M" <%= gender == Gender.M ? "checked" : "" %>>
						 <label for="gender0">남</label>
						 <input type="radio" name="gender" id="gender1" value="F" <%= gender == Gender.F ? "checked" : "" %>>
						 <label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>휴대폰<sup>*</sup></th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="<%= phone %>" required><br>
				</td>
			</tr>
			<tr>
                <th>주소<sup>: </sup></th>
                <td>    
                    <input type="text" placeholder="시/도" name="city" id="city" value="<%= city %>" required>
                    <input type="text" placeholder="구/군" name="district" id="district" value="<%= district %>" required>
                    <input type="text" placeholder="상세주소" name="address" id="address" value="<%= address %>" required><br>
                </td>
            </tr>            
		</table>
        <input type="submit" value="정보수정"/>
	</form>
    <form 
        name="memberDelFrm"
        action="<%= request.getContextPath() %>/member/memberDelete" 
        method="post"
        onsubmit="return confirm('정말로 탈퇴하시겠습니까?')">
        <input type="submit" value="탈퇴하기"/>
    </form>
</section>
  <br>
  <br>
  <br>
  <br>

<form name="memberDelFrm" action="<%= request.getContextPath() %>/member/memberDelete" method="post"></form>
<script>
//폼 유효성검사
document.memberUpdateFrm.onsubmit = (e) => {
	const frm = e.target;
	const name = e.target.name;
	const phone = e.target.phone;

	// 이름 검사 - 한글2글자 이상
	if (!/^[가-힣]{2,}$/.test(name.value)) {
		alert("이름은 한글2글자 이상이어야 합니다.");
		return false;
	}
	// 전화번호 검사 - 01012345678 010으로 시작하고 숫자8자리 여부 확인
	if (!/^010\d{8}$/.test(phone.value)) {
		alert("전화번호는 010으로 시작하고 숫자8자리여야 합니다.");
		return false;
	}
	
};

const deleteMember = () => {
	if(confirm("정말 탈퇴하시겠습니까?"))
		document.memberDelFrm.submit();
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
