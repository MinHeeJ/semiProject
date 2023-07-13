<%@page import="com.semi.mvc.cart.model.vo.SelectedOption"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%

List<SelectedOption> selectedOption = (List)request.getAttribute("selectedOption");
String saladOrBread = (String)request.getAttribute("saladOrBread");
int totalPrice = 0;
int totalCalorie =0;

%>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style>
#beforeCartSection { width : 1200px; text-align: center;}
#receipt{ display: inline-block; width: 40%; border-left: 2.5px solid black; border-right: 2.5px solid black; margin : 3% 0 3% 0;}
#receiptTitle {font-size : 30px; font-weight: bold; margin : 3% 0 3% 0;}
#receipt h2 {margin-left: 20px; text-align: left; font-size : 20px; font-weight: bold; }
#optionPrint {width : 100%}
#optionPrint .optionsLeft {display: inline-block; margin-left: 20px; text-align: left; font-size : 15px; width : 45%}
#optionPrint .optionsRight {display: inline-block; margin-right: 20px; text-align: right; font-size : 15px; width : 45%}
.totals {font-size : 23px; font-weight: bold;}
#selectConfirm h1 {margin-top : 3%; font-size : 25px; font-weight: bold;}
#selectConfirm button {display: inline-block; width : 150px; height: 50px; font-size : 20px; font-weight: bold; margin: 3% 1%; border: 1px solid black; background-color: white; border-radius : 10px}
#selectConfirm button:hover {background-color : darkgreen; color: white}
</style>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<body>
	<section id="beforeCartSection">
		<h1 id= "receiptTitle"> 🥗 <%= selectedOption.get(0).getMemberId()%>님의 맞춤형 샐러드가 완성되었습니다 🥗</h1>
		<div id="receipt">
		<img src="<%= request.getContextPath() %>/images/cart/receiptTop.png" alt="" id="receipTop"  width="100%"/>
		<h2><%= saladOrBread.equals("2")? "샐러드볼" : "호밀빵"%></h2>
		<br>
		<% for(SelectedOption sOption : selectedOption){ %>
		<div id="optionPrint">
			<span class="optionsLeft"> - <%= sOption.getIngredientName() %> [ <%= sOption.getCount() %> ]</span>
			<span class="optionsRight"><%=sOption.getPrice()%> 원</span>	<br>	
			<% 
				totalPrice += sOption.getPrice();
				totalCalorie += sOption.getCalorie();
			%>		
		</div>
		<% } %>
		<br>
		<img src="<%= request.getContextPath() %>/images/cart/line.png" alt="" width="100%"/>
		<br>
		<span  class="totals">✨ Total Price : <%= totalPrice %> 원 ✨</span><br>	
		<span  class="totals">✨ Total Calorie : <%= totalCalorie %> kcal ✨</span><br>	<br>
		<img src="<%= request.getContextPath() %>/images/cart/receiptBottom.png" alt="" id="receipBottom" width="100%"/>
		</div>
		
		<div id = "selectConfirm">
			<h1>장바구니에 담으시겠습니까?</h1>
			<form action="<%=request.getContextPath()%>/complete/select">
				<input type = "hidden" id="confirmOptions" value = "<%= selectedOption %>">
				<button type = "button" id= "goToCart"> 예 </button>
				<button type = "button" id="goBack">아니오</button>
			</form>
		
		</div>
	</section>

	<script>
		document.querySelector("#goToCart").onclick=()=>{
			
			
		};
		
	</script>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>