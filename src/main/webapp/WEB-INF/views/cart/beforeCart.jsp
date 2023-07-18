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
div {vertical-align: middle;}
@font-face {font-family: 'SBAggroB'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff'); font-weight: normal; font-style: normal;}
@font-face {font-family: 'PyeongChangPeace-Bold'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-02@1.0/PyeongChangPeace-Bold.woff2') format('woff2');font-weight: 700;font-style: normal;}

#beforeCartSection { width : 1200px; text-align: center; border: 4px solid darkgreen; margin-top: 3%; border-radius: 30px;  overflow: hidden; margin-bottom: 12%}
#receipt{ display: inline-block; width: 40%; border-left: 2.5px solid black; border-right: 2.5px solid black; margin : 3% 0 3% 0; animation: opacityAni 0.7s linear;}
#receiptTitle {font-size : 43px !important; margin : 3% 0 20% 0; font-family: 'SBAggroB' !important; font-weight: bold; -webkit-text-stroke: 1px darkGreen;}
h1#receiptTitle+h1{}
#receipt h2 {margin-left: 20px; text-align: left; font-size : 20px; font-weight: bold;}
#optionPrint {width : 100%}
#optionPrint .optionsLeft {display: inline-block; margin-left: 20px; text-align: left; font-size : 15px; width : 45%}
#optionPrint .optionsRight {display: inline-block; margin-right: 20px; text-align: right; font-size : 15px; width : 45%}
.totals {font-size : 23px; font-weight: bold;}
#selectConfirm h1 {font-family: 'NanumSquareNeo-Variable'; margin-top : 3%; font-size : 25px; font-weight: bold;}
#selectConfirm button {font-family: 'NanumSquareNeo-Variable'; display: inline-block; width : 150px; height: 50px; font-size : 20px; font-weight: bold; margin: 3% 1%; border: 1px solid black; background-color: white; border-radius : 10px}
#selectConfirm button:hover {background-color : darkgreen; color: white}
#selectConfirm {display: inline-block; width: 45%; margin-left:5%;}
@font-face {font-family: 'NanumSquareNeo-Variable'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');font-weight: normal;font-style: normal;}
#completeAddCart button {display: inline-block; width : 220px; height: 75px; font-size : 23px; font-weight: bold; margin: 2% 1%; border: 3px solid black; color: white; background-color: darkgreen; border-radius : 10px}
#backgroundPop { display: none; width: 100%; height: 100%; position: fixed; opacity : 0.1; top: 0; left: 0; right: 0; background-color: black; z-index: 999;}
#completeAddCart {font-family: 'NanumSquareNeo-Variable'; display: none; overflow:hidden; position: absolute; top: 50%; left: 50%; transform:translate(-50%,-50%); border: 5px solid darkgreen; border-radius: 20px; width: 700px; font-size : 30px; font-weight: bold; height: 500px; background: #fff; z-index: 1000; text-align: center; vertical-align: middle;}
#completeAddCart button:hover {background-color : white; color: darkgreen; border: 3px solid darkgreen; }
#completeAddCart img{width: 230px ; height: 230px}
#completeAddCart img {animation: slideRight 2s linear;}
@keyframes slideRight {0% {transform: translateX(-120%);} 100% {transform: translateX(0%);}}
@keyframes opacityAni {0% {transform: translateY(100%);} 100% {transform: translateY(0%);}}
#completeAddCart img.slideAnimation {animation: slideRight 2.5s linear 1;}
</style>

<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<body>
	<section id="beforeCartSection">
	
		
		
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
			<h1 id= "receiptTitle"><%= selectedOption.get(0).getMemberId()%>님 만의 <br><br>🥗 맞춤형 샐러드 완성! 🥗</h1>
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
		
	</section>
	<div id="backgroundPop"></div>
	<div id = "completeAddCart">
		<br><br>
		<img src="<%= request.getContextPath() %>/images/cart/cartimg.png"><br>
			<h1>장바구니 담기가 완료되었습니다.</h1>
			<br>
			<button type="button">장바구니로 가기</button>
			<button type="button" id="createNew">새로운 주문 추가</button>
	</div>

	<script>
	
	
	function popOpen() {

	    const modalPop = $('#completeAddCart');
	    
	    document.querySelector("#backgroundPop").style.display = "inline-block"; 

	    $("#backgroundPop").css('display', 'inline-block');	    
		$(modalPop).show();
		$("#completeAddCart img").addClass("slideAnimation");

	}
	
	document.querySelector("#goToCart").onclick=(e)=>{
		popOpen();
	}
	
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

					document.querySelector("#selectConfirm").style.display = "none";					
					document.querySelector("#completeAddCart").style.display = "block";
				}
			
			});
			
		};
		document.querySelector("#goBack").onclick=()=>{
			 if(confirm('초기 선택화면으로 돌아가시겠습니까?'))
				 window.location.href = '<%= request.getContextPath() %>/OnlinOrder';    
		};
		document.querySelector("#createNew").onclick=()=>{
			window.location.href = '<%= request.getContextPath() %>/OnlinOrder';    
		};
		document.querySelector("#completeAddCart button").onclick=()=>{
			window.location.href = '<%= request.getContextPath()%>/cart/cartList.jsp';    
		};		
		
	</script>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>