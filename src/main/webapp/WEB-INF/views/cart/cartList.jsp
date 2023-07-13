<%@page import="com.semi.mvc.cart.model.vo.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
List<Cart> carts = (List)request.getAttribute("carts");

%>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style>
#CartListSection { width : 1200px; text-align: center;}
#cartListTable{ border:1px solid black; border-collapse:collapse; margin: 2% auto 10% auto; text-align:center;}
#printCartList th {width: 80px; border:1px solid black; padding: 10px 0; text-align:center; background-color: rgb(216, 248, 225); height : 50px; font-size: 20px; font-weight: bold; vertical-align: middle;} 
#printCartList td {border:1px solid black; padding: 5px; text-align:left; text-align:center; height : 50px; font-size: 15px; vertical-align: middle;}
#productCol {width: 750px !important;}
#CartListSection h1{margin-top : 10%; font-size: 40px; font-weight: bold;}
#cartbuttons {width : 1200px; margin-top : 2%;}
#cartbuttons button{ width : 75px;}
#cartUpdate {margin-left: 76.2%; margin-right:0.2%}
</style>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<body>
	<section id="CartListSection">
	<h1>장 바 구 니</h1>
	<div id = "cartbuttons">
		<button id="cartUpdate">수정</button>
		<button id="cartDelete">삭제</button>	
	</div>
	<form id ="printCartList">
	<table id ="cartListTable">
        <thead>
            <tr>
                <th>선택</th>
                <th>번호</th>
                <th id="productCol">상품</th>
                <th>수량</th>
                <th>가격</th>
            </tr>
        </thead>
        <tbody>
        
        <%
        	for(int i = 0; i < carts.size(); i++){
        %>
      		<tr>
                <td><input type="checkbox"></td>
                <td><%= i +1 %></td>
                <td><%= carts.get(i).getProduct() %></td>
                <td><input type="number" min="1" max="10" value = "1"></td>
                <td><%= carts.get(i).getPrice() %></td>
            </tr>
        		      
        <%
        	}
        %>       
        </tbody>
    </table>
	<button id="order">주문하기</button>
	</form>	
	
	</section>

	<script>
	
	</script>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>