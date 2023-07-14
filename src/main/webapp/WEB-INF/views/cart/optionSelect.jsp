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
.order-step { display: none; }
.order-step.active { display: block;}
.stepNum {width: 60px; height : 60px; border-radius: 50%; display: inline-block; font-size : 50px; font-weight : bold; color : white;
		  background-color : darkgreen; text-align: center; vertical-align : center; margin : 5% 0 5% 1%;}
#selectTitle {font-size : 40px; font-weight : bold; margin-left : 1%;}
#changeStep{width: 100%; height : 30%; margin : 10% 0 10% 0;}
#changeStep button {color : white; background-color : darkgreen; font-size : 20px; font-weight : bold; width: 80px; height : 40px;
	border-radius: 10px; border-color: black; display: inline-block;}
#nextButton {position: absolute; right: 30%; transform: translateY(-50%);}
#previousButton {position: absolute; left: 30%; transform: translateY(-50%);}
#submitButton {position: absolute; right: 30%; transform: translateY(-50%);}
#optionSelectSection{width: 1200px;}
#optionSelectSection form div{text-align: center;}
.selectTitle {font-size : 40px; font-weight : bold; margin-left : 1%;}

</style>

<body>
	<section id="optionSelectSection">
	<form id="orderForm" action="<%=request.getContextPath()%>/complete/select" method="POST">
		<div class="order-step active" id="step1">
			<div class = "stepNum">1</div>
			<span id= "selectTitle">메인 선택</span>
			<br><br>
			<img src="<%= request.getContextPath() %>/images/cart/HanSohee.jpg" alt="" id="bread"  width="300px"/>
			<img src="<%= request.getContextPath() %>/images/cart/goYoonjung.jpg" alt="" id="saladBowl" width="300px"/>
			<input type="hidden" class="selectSalad" name="saladOrBread">
		</div>
		
		<%
		for (int i = 2; i <= 5; i++) {
		%>
		<div class="order-step" id="step<%=i%>">
			<div class = "stepNum"><%=i%></div>
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

		<span name="totalPrice"></span>
		<div id="changeStep">
			<button type="button" onclick="previousStep()" id="previousButton" style="display: none;">이전</button>
			<button type="button" onclick="nextStep()" id="nextButton">다음</button>
			<button type="submit" id="submitButton" style="display: none;">제출</button>
		</div>
	</form>

	<br><br>
	</section>

	<script>
		let currentStep = 1;
		let totalSteps = 5;
		window.onload=()=>{
			const images = document.querySelectorAll("#step1 img");
			for(let i = 0; i <images.length; i++){
				console.log(images);
				images[i].onclick =(e) =>{
					document.querySelector(".selectSalad").value = i+1;
					console.log(document.querySelector(".selectSalad").value);
				};			
			}		
		};

		function previousStep() {
			if (currentStep > 1) {
				currentStep--;
				updateStepVisibility();
			}
			if (currentStep != totalSteps) {
				document.getElementById("nextButton").style.display = "block";
				document.getElementById("submitButton").style.display = "none";
			}
		}

		function nextStep() {
			if (currentStep < totalSteps) {
				currentStep++;
				updateStepVisibility();
			}
			if (currentStep === totalSteps) {
				document.getElementById("nextButton").style.display = "none";
				document.getElementById("submitButton").style.display = "block";
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
				document.getElementById("previousButton").style.display = "block";
			}
		}
		
	</script>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>