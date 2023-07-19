<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/memberEnroll.css" /> <!-- CSS 파일 연결 -->
<section id="enroll-container">
    <h2>킥킥! 건강합시다!</h2>
    <form name="memberEnrollFrm" action="" method="POST">
        <table>
            <tr>
                <th>아이디<sup>: </sup></th>
                <td>
                    <input type="text" placeholder="4글자이상" name="memberId" id="_memberId"  required>
                </td>
            </tr>
            <tr>
                <th></th>
                <td>
                    <input type="button" value="중복검사" class="duplicate-btn" onclick="checkIdDuplicate();"/>
                    <input type="hidden" id="idValid" value="0"/>
                    <%-- id검사여부 확인용: 0-유효하지않음, 1-유효한 아이디 --%>
                </td>
            </tr>
            <br>
            <br>
            
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
            <br>
            <tr>
                <th>이름<sup>: </sup></th>
                <td>    
                <input type="text"  name="name" id="name"  required><br>
                </td>
            </tr>
            <br>
            <br>
            <tr>
                <th>휴대폰<sup>: </sup></th>
                <td>    
                    <input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11"  required><br>
                </td>
            </tr>           
            <br> 
            <tr>
                <th>주소<sup>: </sup></th>
                <br>
                <td>    
                    <input type="text" placeholder="시/도" name="city" id="city"  required>
                    <input type="text" placeholder="구/군" name="district" id="district"  required>
                    <input type="text" placeholder="상세주소" name="address" id="address"  required><br>
                </td>
            </tr>            
            <br>
            <tr>
                <th>성별 </th>
                <td>
                    <input type="radio" name="gender" id="gender0" value="M">
                    <label for="gender0">남</label>
                    <input type="radio" name="gender" id="gender1" value="F">
                    <label for="gender1">여</label>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
        <div class="button-container">
            <div class="centered-buttons">
                <input type="submit" value="가입" class="submit-btn">
                <input type="reset" value="취소" class="cancel-btn" onclick="location.href='<%= request.getContextPath() %>/';">
            </div>
        </div>
    </form>
</section>
  <br>
  <br>
  <br>
  <br>

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
    
    const frm = document.createElement("form");
    frm.action = "<%= request.getContextPath() %>/member/checkIdDuplicate";
    frm.method = "POST";
    
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = "memberId";
    input.value = memberId;
    
    frm.appendChild(input);
    
    popup.document.body.appendChild(frm);
    
    frm.submit();
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
