<%@page import="com.semi.mvc.cart.model.vo.SelectedOption"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%

List<SelectedOption> selectedOption = (List)request.getAttribute("selectedOption");
String saladOrBread = (String) request.getAttribute("saladOrBread");
int totalPrice = 0;
int totalCalorie =0;
String memberId = "";

%>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style>
#beforeCartSection { width : 1200px; text-align: center;}
#receipt{ display: inline-block; width: 40%; border-left: 2.5px solid black; border-right: 2.5px solid black; margin : 3% 0 3% 0;}
#receiptTitle {font-size : 30px; font-weight: bold; margin : 3% 0 3% 0;}
#receipt h2 {margin-left: 20px; text-align: left; font-size : 20px; font-weight: bold;}
#optionPrint {width : 100%}
#optionPrint .optionsLeft {display: inline-block; margin-left: 20px; text-align: left; font-size : 15px; width : 45%}
#optionPrint .optionsRight {display: inline-block; margin-right: 20px; text-align: right; font-size : 15px; width : 45%}
.totals {font-size : 23px; font-weight: bold;}
#selectConfirm h1 {margin-top : 3%; font-size : 25px; font-weight: bold;}
#selectConfirm button {display: inline-block; width : 150px; height: 50px; font-size : 20px; font-weight: bold; margin: 3% 1%; border: 1px solid black; background-color: white; border-radius : 10px}
#selectConfirm button:hover {background-color : darkgreen; color: white}
#completeAddCart {display : "none"; width: 100%; height: 800px; font-size : 50px; font-weight: bold;}
#completeAddCart button {display: inline-block; width : 200px; height: 50px; font-size : 20px; font-weight: bold; margin: 3% 1%; border: 1px solid black; color: white; background-color: darkgreen; border-radius : 10px}
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
				memberId = sOption.getMemberId();
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
			<form id="addCartForm">
				<input type = "hidden" name="confirmOptions" value = "<%= selectedOption %>">
				<input type = "hidden" name="totalPrice" value = "<%= totalPrice %>">
				<input type = "hidden" name="saladOrBread" value = "<%= saladOrBread.equals("2")? "샐러드볼" : "호밀빵"%>">
				<input type = "hidden" name="memberId" value = "<%= memberId %>">
				<button id= "goToCart"> 예 </button>
				<button type = "button" id="goBack">아니오</button>
			</form>
		</div>
		<div id = "completeAddCart">
			<h1>장바구니 담기가 완료되었습니다.</h1>	
			<button type="button">장바구니로 가기</button>
		</div>
	</section>

	<script>
	
		window.onload=()=>{
			
			if(document.querySelector("#completeAddCart").style.display == "block"){
				document.querySelector("#selectConfirm").style.display = "none";	
			} else {
				document.querySelector("#completeAddCart").style.display = "none"
			}
			
		};
		
		document.querySelector("#addCartForm").onsubmit=(e)=>{
			e.preventDefault();
			const frmData = new FormData(e.target); 
			$.ajax({				
				url : "<%= request.getContextPath()%>/add/to/cart",
				data : frmData,
				processData : false, 
				contentType : false, 
				method : "POST",
				dataType : "json",
				success(responseData){
					const {result, message} = responseData;
					alert(message);
					document.querySelector("#selectConfirm").style.display = "none";					
					document.querySelector("#completeAddCart").style.display = "block";
				}
			
			});
			
		};
		document.querySelector("#goBack").onclick=()=>{
			 if(confirm('초기 선택화면으로 돌아가시겠습니까?'))
				 window.location.href = '<%= request.getContextPath() %>/OnlinOrder';    
		};
		document.querySelector("#completeAddCart button").onclick=()=>{
			window.location.href = '<%= request.getContextPath()%>/cart/cartList.jsp';    
		};		
		
	</script>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>