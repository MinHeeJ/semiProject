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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/cart.css" />
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