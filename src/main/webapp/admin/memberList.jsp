<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<section id="memberList-container">
	<h1>회원 전체 조회</h1>
	
    <div id="memberList-wrapper">
    <form id="memberList">
		<table id="tbl-member">
            <thead>
                <tr>
                    <th>선택</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>주소</th>
                    <th>성별</th>
                    <th>회원권한</th>
                </tr>
            </thead>
			<tbody></tbody>
		</table>
		<button id="deleteMember">삭제</button>
    </form>
	</div>
</section>
<script>
window.onload = () => {
	findAll();
};

const findAll = () => {
	$.ajax({
		url : "<%= request.getContextPath() %>/admin/memberList",
		success(members) {
			//console.log(members);
			
			const tbody = document.querySelector("#tbl-member tbody");
			tbody.innerHTML = "";
			
			[...members].forEach((member) => {
				//console.log(member);
				const{memberId, name, phone, address, gender, memberRole} = member;
				tbody.innerHTML += `
	                <tr>
	                    <td><input type="checkbox" name="checkedOrNot" value="\${memberId}"></td>
	                    <td>\${memberId}</td>
	                    <td>\${name}</td>
	                    <td>\${phone}</td>
	                    <td>\${address}</td>
	                    <td>\${gender}</td>
	                    <td>
	                    	<select class="member-role" data-member-id="\${memberId}">
	                    		<option value="U" \${memberRole} == \${memberRole}.U ? "selected" : "" %>일반</option>
	                    		<option value="A" \${memberRole}) == \${memberRole}.A ? "selected" : "" %>관리자</option>
	                    	</select>
	                    </td>
	                </tr>
				`;
			});
			
		}
	});
};

// 삭제하기
document.querySelector("#deleteMember").onclick = (e) => {
	if(confirm('삭제하시겠습니까?')) {
		
		document.querySelector("#memberList").onsubmit = (e) => {
			console.log(123);
			e.preventDefault();
			
			const frmData = new FormData(e.target);
			
			$.ajax({
				url : "<%= request.getContextPath() %>/admin/memberDelete",
				data : frmData,
				processData : false, 
				contentType : false, 
				method : "POST",
				success(responseData) {
					const {result} = responseData;
					alert(result);
					findAll();
				}
			});
		}
	}
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>