<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/memberEnroll.css" />
<section id="enroll-container">
    <h2>회원 가입 정보 입력</h2>
  <br>
  <br>
    
    <form 
        name="checkIdDuplicateFrm" 
        action="<%= request.getContextPath() %>/member/checkIdDuplicate">
        <input type="hidden" name="memberId"/>
    </form>
    <form name="memberEnrollFrm" action="" method="POST">
        <table>
            <tr>
                <th>아이디<sup>: </sup></th>
                <td>
                    <input type="text" placeholder="4글자이상" name="memberId" id="_memberId"  required>
                </td>           
               <tr>
                <th></th>
                 <td>
                    <input type="button" value="중복검사" class="duplicate-btn" onclick="checkIdDuplicate();"/>
                    <input type="hidden" id="idValid" value="0"/>
                    <%-- id검사여부 확인용: 0-유효하지않음, 1-유효한 아이디 --%>
                </td>
            </tr>
            <tr>
                <th>패스워드<sup>: </sup></th>
                <td>
                    <input type="password" placeholder="비밀번호 입력" name="password" id="_password"  required><br>
                </td>
            </tr>
            <tr>
                <th>패스워드확인<sup>: </sup></th>
                <td>    
                    <input type="password" placeholder="비밀번호 재입력"id="passwordConfirmation" required><br>
                </td>
            </tr>  
            <tr>
                <th>이름<sup>: </sup></th>
                <td>    
                <input type="text"  name="name" id="name"  required><br>
                </td>
            </tr>
            <tr>
                <th>휴대폰<sup>: </sup></th>
                <td>    
                    <input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11"  required><br>
                </td>
            </tr>            
            <tr>
                <th>주소<sup>: </sup></th>
                <td>    
                    <input type="text" placeholder="시/도" name="city" id="city"  required>
                    <input type="text" placeholder="구/군" name="district" id="district"  required>
                    <input type="text" placeholder="상세주소" name="address" id="address"  required><br>
                </td>
            </tr>            
            <tr>
                <th>성별 </th>
                <td>
                    <input type="radio" name="gender" id="gender0" value="M" required>
                    <label for="gender0">남</label>
                    <input type="radio" name="gender" id="gender1" value="F" required>
                    <label for="gender1">여</label>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
        <div class="centered-buttons">
        <input type="submit" value="가입" class="submit-btn" >
        <input type="reset" value="취소" class="cancel-btn" onclick="location.href='<%= request.getContextPath() %>/';">
   		</div>
    </form>
</section>
<script>
/**
 * 중복검사 이후 아이디 변경시 #idValid값을 리셋(0)한다.
 */
document.querySelector("#_memberId").onchange = () => {
    document.querySelector("#idValid").value = "0";    
};

/**
 * 아이디 중복검사 함수
 * - 팝업창으로 폼을 제출
 */
 const checkIdDuplicate = () => {
	    const memberId = document.querySelector("#_memberId").value;
	    
	    if (!/^\w{4,}$/.test(memberId)) {
	        alert("아이디는 영문자/숫자 4글자 이상이어야 합니다.");
	        return false;
	    }
	    
	    const title = "checkIdDuplicatePopup";
	    const popup = open("", title, "width=500px, height=300px");
	    
	    const frm = document.checkIdDuplicateFrm;
	    frm.target = title; // 폼의 제출대상으로 팝업창으로 연결
	    frm.memberId.value = memberId;
	    frm.submit();
	}


// 비밀번호 일치여부
document.querySelector("#passwordConfirmation").onblur = (e) => {
    const pw1 = document.querySelector("#_password");
    const pw2 = e.target;
    
    if(pw1.value !== pw2.value) {
        alert("비밀번호가 일치하지 않습니다.");
        pw1.select();
    }
};

// 폼 유효성검사
document.memberEnrollFrm.onsubmit = (e) => {
    const frm = e.target;
    const memberId = e.target.memberId;
    const password = e.target.password;
    const passwordConfirmation = e.target.querySelector("#passwordConfirmation");
    const name = e.target.name;
    const phone = e.target.phone;
    const idValid = document.querySelector("#idValid");
    
    // 아이디 검사 - 영문자/숫자 4글자 이상
    if (!/^\w{4,}$/.test(memberId.value)) {
        alert("아이디는 영문자/숫자 4글자 이상이어야 합니다.")
        return false;
    }
    // 아이디 중복검사 
    if (idValid.value !== "1") {
        alert("아이디 중복검사 해주세요.");
        memberId.select();
        return false;
    }
    // 비밀번호 검사 - 영문자/숫자/특수문자!@#$% 4글자 이상
    if (!/^[\w!@#$%]{4,}$/.test(password.value)) {
        alert("비밀번호는 영문자/숫자/특수문자 !@#$% 4글자 이상이어야 합니다.");
        return false;
    }
    if (password.value !== passwordConfirmation.value) {
        alert("두 비밀번호가 일치하지 않습니다.");
        return false;
    }
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
</script>
  <br>
  <br>
  <br>
  <br>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
