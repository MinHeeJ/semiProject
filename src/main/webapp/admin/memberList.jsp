<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/list.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<section id="memberListSection">
	<div class="member_wrapper">
		<h1>회원 전체 조회</h1>
	</div>
	
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
		<button id="delete">삭제</button>
    </form>
    <div>
	<!-- 회원권한 수정 -->
	<form
		name="memberRoleUpdateFrm"
		action="<%= request.getContextPath() %>/admin/memberRoleUpdate"
		method="POST">
		<input type="hidden" name="memberRole"/>
		<input type="hidden" name="memberId"/>
	</form>
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
				const optionU = memberRole === "U" ? "selected" : "";
				const optionA = memberRole === "A" ? "selected" : "";
				
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
	                    		<option value="U" \${optionU} %>일반</option>
	                    		<option value="A" \${optionA} %>관리자</option>
	                    	</select>
	                    </td>
	                </tr>
				`;
			});
			
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
			
		}
	});
};



// 삭제하기 //선택한 회원 없으면 삭제 x
document.querySelector("#delete").onclick = (e) => {
	let flag = true;
	 
	const checkboxes = document.querySelectorAll("input[name=checkedOrNot]");
	  
    checkboxes.forEach((checkbox) => {
		if (checkbox.checked) 		   
		    flag = false;
	});
    if(flag){
    	 alert('선택하신 회원이 없습니다.');
		    e.preventDefault();
    }
	if(!flag && confirm('삭제하시겠습니까?')) {
		
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
					findAll();
					
				}
			});
		}
	}
}


</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>