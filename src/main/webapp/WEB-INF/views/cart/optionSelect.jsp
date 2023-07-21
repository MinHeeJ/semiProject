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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/cart.css" />
<style>
#bread {width:300px; height :300px; background-color: white; background-image: url('<%= request.getContextPath() %>/images/cart/bread.png'); background-repeat: no-repeat; background-size: contain; background-position-y : center;}
#saladBowl {width:300px; height :300px; background-color: white; background-image: url('<%= request.getContextPath() %>/images/cart/salad.png'); background-repeat: no-repeat; background-size: contain; background-position-y : center;}
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
			%>		<div class="optionContainer">
					<label for="<%=ingredient.getIngredientName()%>"><%=ingredient.getIngredientName()%> (<%= ingredient.getWeight() %>)</label>
					<input type="number" id="<%=ingredient.getIngredientName()%>" name="quantity" min="0" step="1" max="10" value="0"> 
					<input type="hidden" name="optionName" value = "<%=ingredient.getIngredientName()%>">
					<input type="hidden" name="cal" value = "<%=ingredient.getCalorie()%>">
					<input type="hidden" name="IngredientPrice" value = "<%=ingredient.getPrice()%>">
					</div>
			<%
					if(z%2 == 1){
			%>			<br><%		
					}}
			} %>
		</div>
		<% } %>
		<div id ="totals">
		<p id="totalCalorie">총 칼로리 : 0kcal</p>
		<p id="totalPrice">총 가격 : 0원</p>
		</div>
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
		
		document.querySelector("#optionSelectSection").onclick = () =>{
			selectOptionControl();
		};
		
		const selectOptionControl = () =>{
		
			  const saladOrBread = document.querySelector("[name=saladOrBread]");			
			  const quantities = document.querySelectorAll("[name= quantity]");
			  const totalCalorieElement = document.getElementById("totalCalorie");
			  const totalPriceElement = document.getElementById("totalPrice");
			
			  let totalPrice = 0;
			  let totalCal = 0;
			  
			  if(saladOrBread.value == 1) {			  
				  totalCal += 270;
				  totalPrice += 2000;
			  }
			  quantities.forEach((quantity) => {

			    	const calInput = quantity.nextElementSibling.nextElementSibling;
					const cal = parseInt(calInput.value);
					const quantityValue = parseInt(quantity.value);
					
					const priceInput = quantity.nextElementSibling.nextElementSibling.nextElementSibling;
					const price = parseInt(priceInput.value);
					const re= /^[0-9]+$/;
					totalCal += cal * quantityValue;
					totalPrice += price * quantityValue;
					
					 quantity.onblur = (e) => {

						if(e.target.value > 10){
							alert("하나의 재료의 수량은 10개를 추가할 수 없습니다!");
							e.target.value = 10;
						} else if(!re.test(e.target.value)) {
							alert("숫자만 입력해주세요.");
							e.target.value = 0;
						}				 						
			         };
		
			  });
			  
			  totalCalorieElement.innerHTML = `총 칼로리 : \${totalCal}kcal`;
			  totalPriceElement.innerHTML = `총 가격 : \${totalPrice}원`;
		  
		};

		
		document.querySelector("#orderForm").onsubmit=(e)=>{			
			const quantities = document.querySelectorAll("[name = quantity]");
			let bool = true;

			quantities.forEach((quantity)=>{
				if(quantity.value != 0)
					bool = false;
			
			})			
			if(bool){
				e.preventDefault();
				alert("하나 이상의 옵션을 선택해야합니다!");
			}
		}

		let currentStep = 1;
		let totalSteps = 5;
		window.onload=()=>{
			const buttons = document.querySelectorAll("#step1 button");
			
			
			for(let i = 0; i <buttons.length; i++){
				buttons[i].onclick =(e) =>{
					document.querySelector(".selectSalad").value = i+1;
					buttons[i].style.backgroundColor = "rgb(196, 230, 196)";
					if(i == 0){
						buttons[1].style.backgroundColor = "white";
			
					}
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
						selectTitles[i].innerHTML= "토핑 선택";
					} else if (selectTitle == 4) {
						selectTitles[i].innerHTML = "소스 선택";
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