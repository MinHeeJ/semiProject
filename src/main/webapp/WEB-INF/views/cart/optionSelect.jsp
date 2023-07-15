<%@page import="com.semi.mvc.cart.model.vo.Ingredient"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<%
List<Ingredient> ingredients = (List) request.getAttribute("ingredients");
%>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style>
@font-face {font-family: 'Giants-Inline'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-1@1.1/Giants-Inline.woff2') format('woff2'); font-weight: normal; font-style: normal;}
@font-face {font-family: 'GongGothicMedium'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff') format('woff'); font-weight: normal; font-style: normal;}
@font-face {font-family: 'IBMPlexSansKR-Regular'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff'); font-weight: normal; font-style: normal;}
@font-face {font-family: 'GmarketSansMedium';src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');font-weight: normal;font-style: normal;}

.order-step { display: none; }
.order-step.active { display: block; vertical-align : middle;}
.stepNum {width: 60px; height : 60px; border-radius: 50%; display: inline-block; font-size : 40px; font-weight : bold; color : white; background-color : darkgreen; text-align: center; vertical-align : middle; margin : 5% 0 5% 1%;}
.stepNum span{display: inline-block; width:100%; height : 100%; margin-top: 20%}
#selectTitle {font-size : 40px; font-weight : bold; margin-left : 1%; vertical-align : middle;}
#changeStep{width: 100%; height : 30%; margin : 10% 0 10% 0;}
#changeStep button {color : white; background-color : darkgreen; font-size : 25px; font-weight : bold; width: 150px; height : 60px; border-radius: 10px; border-color: black; display: inline-block; cursor: pointer;}
#changeStep div {width: 45%; display: inline-block}
#optionSelectSection{width: 1200px; font-family:'GmarketSansMedium', Courier, monospace; vertical-align : middle;}
#optionSelectSection form div{text-align: center;}
.selectTitle {font-size : 40px; font-weight : bold; margin-left : 1%;vertical-align : middle;}
#bread {width:300px; height :300px; background-color: white; background-image: url('<%= request.getContextPath() %>/images/cart/bread.png'); background-repeat: no-repeat; background-size: contain; background-position-y : center;}
#saladBowl {width:300px; height :300px; background-color: white; background-image: url('<%= request.getContextPath() %>/images/cart/salad.png'); background-repeat: no-repeat; background-size: contain; background-position-y : center;}
#step1 button{border: 0px solid black; margin: 1% 4%; border-radius: 20px;}
#step1 button:hover{background-color: lightgreen;}
#step1 button:click{background-color: lightgreen;}
.labels{display: inline-block; font-size : 25px; font-weight : bold; width:300px; margin: 0% 4%;}
#optionselct-container { border: 3px solid darkgreen; margin-top: 3%}
</style>

<body>
	<section id="optionSelectSection">
	<div id="optionselct-container">
	<form id="orderForm" action="<%=request.getContextPath()%>/complete/select" method="POST">
		<div class="order-step active" id="step1">
			<div class = "stepNum"><span>1</span></div>
			<span id= "selectTitle">메인 선택</span>
			<br><br>
			<button type="button" id="bread"></button>
			<button type="button" id="saladBowl"></button>
			<br>
			<span id="labelForbread" class="labels">호밀빵</span>
			<span id="labelForSaladbowl" class="labels">샐러드볼</span>
			<input type="hidden" class="selectSalad" name="saladOrBread" value="3">
		</div>
		
		<%
		for (int i = 2; i <= 5; i++) {
		%>
		<div class="order-step" id="step<%=i%>">
			<div class = "stepNum"><span><%=i%></span></div>
			<span class= "selectTitle"><%=i%></span>
			<br><br>	
			<%
			for (int z = 0; z < ingredients.size(); z++) {
				Ingredient ingredient = ingredients.get(z);
				if (ingredient.getCategoryNo() == i) {
			%>
					<label for="<%=ingredient.getIngredientName()%>"><%=ingredient.getIngredientName()%></label>
					<input type="number" id="<%=ingredient.getIngredientName()%>" name="quantity" min="0" step="1" max="10" value="0"> 
					<input type="hidden" name="optionName" value = "<%=ingredient.getIngredientName()%>">
					<br>
			<% }} %>
		</div>
		<% } %>

		<div id="changeStep">
			<div id="changePrevious">
			<button type="button" onclick="previousStep()" id="previousButton" style="display: none;">이전</button>
			</div><div id="changeNext">
			<button type="button" onclick="nextStep()" id="nextButton">다음</button>
			<button type="submit" id="submitButton" style="display: none;">제출</button></div>
		</div>
	</form>
	</div>
	<br><br>
	</section>

	<script>
		let currentStep = 1;
		let totalSteps = 5;
		window.onload=()=>{
			const buttons = document.querySelectorAll("#step1 button");
			for(let i = 0; i <buttons.length; i++){
				buttons[i].onclick =(e) =>{
					document.querySelector(".selectSalad").value = i+1;
					buttons[i].style.backgroundColor = "lightgreen";
					if(i == 0)
						buttons[1].style.backgroundColor = "white";
					else
						buttons[0].style.backgroundColor = "white";
				};			
			}		
		};

		function previousStep() {
			if (currentStep > 1) {
				currentStep--;
				updateStepVisibility();
			}
			if (currentStep != totalSteps) {
				document.getElementById("nextButton").style.display = "inline-block";
				document.getElementById("submitButton").style.display = "none";
			}
		}

		function nextStep() {
			if(document.querySelector(".selectSalad").value == 3){
				alert("메인을 골라주세요!");
			} else {			
				if (currentStep < totalSteps) {
					currentStep++;
					updateStepVisibility();
				}
				if (currentStep === totalSteps) {
					document.getElementById("nextButton").style.display = "none";
					document.getElementById("submitButton").style.display = "inline-block";
				}
			
				const selectTitles = document.querySelectorAll(".selectTitle");
				for(let i = 0; i <selectTitles.length; i++){
					const selectTitle = selectTitles[i].innerHTML;
					if (selectTitle == 2) {
						selectTitles[i].innerHTML = "야채 선택";
					} else if (selectTitle == 3) {
						selectTitles[i].innerHTML= "소스 선택";
					} else if (selectTitle == 4) {
						selectTitles[i].innerHTML = "토핑 선택";
					} else if (selectTitle == 5) {
						selectTitles[i].innerHTML = "음료 선택";
					}
				}
			}
			
		}

		function updateStepVisibility() {
			let stepElements = document.getElementsByClassName("order-step");
			for (let i = 0; i < stepElements.length; i++) {
				stepElements[i].classList.remove("active");
			}
			document.getElementById("step" + currentStep).classList
					.add("active");

			if (currentStep === 1) {
				document.getElementById("previousButton").style.display = "none";
			} else {
				document.getElementById("previousButton").style.display = "inline-block";
			}
		}
		
	</script>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>