<%@page import="com.semi.mvc.order.model.vo.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<%
	List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<section>
	<h1>주문내역 전체조회</h1>
	
    <div>
        <table>
            <thead>
              <tr>
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
					<td>조회 결과가 없습니다.</td>
				</tr>
            <% } 
            	else { 
            		for(Order order : orders) { %>
		              <tr>
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