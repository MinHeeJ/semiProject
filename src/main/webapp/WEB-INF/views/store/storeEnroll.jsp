<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/store.css" />
<section id=enroll-container>
	<h2>매장 추가 정보 입력</h2>
	<form 
		name="checkNameDuplicateFrm" 
		action="<%= request.getContextPath() %>/store/checkNameDuplicate">
		<input type="hidden" name="storeName"/>
	</form>
	<form name="storeEnrollFrm" action="" method="POST">
		<table>
			<tr>
				<th>매장명<sup>*</sup></th>
				<td>
					<input type="text" placeholder="4글자이상" name="storeName" id="_storeName" required>
					<input type="button" value="중복검사" onclick="checkNameDuplicate();"/>
					<input type="hidden" id="nameValid" value="0"/>
					<%-- id검사여부 확인용: 0-유효하지않음, 1-유효한 아이디 --%>
				</td>
			</tr>
			
			
			 
			<tr>
				<th>주소 <sup>*</sup></th>
				<td>	
				<input type="text"  name="address" id="address"  required><br>
				</td>
			</tr>
			
			
			<tr>
				<th>연락처<sup>*</sup></th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="01012341234" required><br>			
				</td>
			</tr>
			
		</table>
		<input type="submit" value="매장등록" >
		<input type="reset" value="취소">
	</form>
</section>
<script>
/**
 * 중복검사 이후 아이디 변경시 #idValid값을 리셋(0)한다.
 */
document.querySelector("#_storeName").onchange = () => {
	document.querySelector("#nameValid").value = "0";	
};

/**
 * 아이디 중복검사 함수
 * - 팝업창으로 폼을 제출
 */
const checkNameDuplicate = () => {
	const title = "checkNameDuplicatePopup";
	const popup = open("", title, "width=500px, height=300px");
	
	const frm = document.checkNameDuplicateFrm;
	frm.target = title; // 폼의 제출대상으로 팝업창으로 연결
	frm.storeName.value = document.querySelector("#_storeName").value;
	frm.submit();
}



// 폼 유효성검사
document.storeEnrollFrm.onsubmit = (e) => {
	const frm = e.target;
	const storeName = e.target.storeName;
	const address = e.target.address;
	//const tel1 = document.getElementById("tel1");
//	const tel2 = document.getElementById("tel2");
	//const tel3 = document.getElementById("tel3");
	const phone = e.target.phone;

	// 아이디 중복검사 
	if (nameValid.value !== "1") {
		alert("매장명 중복검사 해주세요.");
		storeName.select();
		return false;
	}
	
	// 전화번호 검사 - 01012345678 010으로 시작하고 숫자8자리 여부 확인
	if (!/^010\d{8}$/.test(phone.value)) {
		alert("전화번호는 010으로 시작하고 숫자8자리여야 합니다.");
		return false;
	}
	
	
	
};


</script>