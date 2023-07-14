<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String storeName = request.getParameter("storeName");
	boolean available = (boolean) request.getAttribute("available");
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장명중복검사</title>
<style>
div#checkName-container{text-align:center; padding-top:50px;}
span#available {color:green; font-weight:bold;}
span#duplicated {color:red; font-weight:bold;}
</style>
</head>
	<body>
		<div id="checkName-container">
		<%	if (available) { %>
			<p>
				<span id="available"><%= storeName %></span>는 사용가능합니다.
			</p>
			<button onclick="popupClose();">닫기</button>
		<% 	} else { %>
			<p>
				<span id="duplicated"><%= storeName %></span>는 이미 사용중입니다.
			</p>
			<form 
				name="checkNameDuplicateFrm">
				<input type="text" name="storeName" placeholder="매장명을 입력하세요"/>
				<input type="submit" value="중복검사" />
			</form>
			
		<%  } %>
		</div>
		<script>
		const popupClose = () => {
			// 부모창 window를 가리키는 변수
			opener.document.storeEnrollFrm.storeName.value = "<%= storeName %>";
			opener.document.storeEnrollFrm.nameValid.value = "1";
			self.close(); // 현재 팝업창 닫기
		};
		</script>
</body>
</html>