<%@page import="com.semi.mvc.order.model.vo.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<style>
h1 {
	font-size: 50px;
	text-align: center;
}
table#tbl-orderList {
	width: 990px;
	margin: 0 auto;
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
}
table#tbl-orderList th {
	width: 150px; 
	border: 1px solid; 
	padding: 10px; 
	text-align: center; 
}
table#tbl-orderList td {
	border: 1px solid; 
	padding: 10px; 
	text-align: center;
}
</style>
<%
	List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<section>
	<h1>주문내역 전체조회</h1>
    <div>
        <table id="tbl-orderList">
            <thead>
              <tr>
                <th>주문번호</th>
                <th>주문일자</th>
                <th>상품</th>
                <th>수량</th>
                <th>금액</th>
                <th>처리상태</th>
              </tr>
            </thead>
            
            <tbody>
            <% if(orders == null || orders.isEmpty()) { %>
            	<tr>
					<td colspan="6">조회 결과가 없습니다.</td>
				</tr>
           	<% } else {
				    for (int i = 0; i < orders.size(); i++) {
				        Order order = orders.get(i); %>
				    <tr>
			            <td rowspan="<%= orders.size() %>"><%= order.getOrderNo() %></td>
		                <td><%= order.getOrderDate() %></td>
		                <td><%= order.getProduct() %></td>
		                <td><%= order.getCount() %></td>
		                <td><%= order.getPrice() %></td>
		                <td><%= order.getState() %></td>
		              </tr>
            <%
            		}
            	} 
            %>
            </tbody>
          </table>
    </div>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>