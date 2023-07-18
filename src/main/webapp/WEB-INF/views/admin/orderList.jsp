<%@page import="com.semi.mvc.order.model.vo.State"%>
<%@page import="com.semi.mvc.order.model.vo.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/list.css" />
<%
	List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<section id="orderListSection">
	<div class="wrapper">
		<h1>주문내역 전체조회(관리자용)</h1>
		<div class="checkbox">
			<input type="checkbox" value="주문접수완료" checked>
			<label for="state">주문접수완료</label>
			<input type="checkbox" value="주문처리완료" checked>
			<label for="state">주문처리완료</label>
		</div>
    <div>
        <table id="tbl-orderList">
            <thead>
              <tr>
              	<th>주문번호</th>
                <th>회원아이디</th>
                <th>상품</th>
                <th>수량</th>
                <th>주문일자</th>
                <th>금액</th>
                <th>처리상태</th>
              </tr>
            </thead>
            
            <tbody>
            <% if(orders == null || orders.isEmpty()) { %>
            	<tr>
					<td colspan="7">조회 결과가 없습니다.</td>
				</tr>
           	<% } else {
				    for (int i = 0; i < orders.size(); i++) {
				        Order order = orders.get(i); %>
				    <tr>
			            <td><%= order.getOrderNo() %></td>
		                <td><%= order.getMemberId() %></td>
		                <td><%= order.getProduct() %></td>
		                <td><%= order.getCount() %></td>
		                <td><%= order.getOrderDate() %></td>
		                <td><%= order.getPrice() %>원</td>
		                <td>
		                  <select class="state" data-order-no="<%= order.getOrderNo() %>">
		                    <option value="주문접수완료" <%= order.getState().equals(State.orderComplete.getState()) ? "selected" : "" %>>주문접수완료</option>
		                    <option value="주문처리완료" <%= order.getState().equals(State.complete.getState()) ? "selected" : "" %>>주문처리완료</option>
		                  </select>
		                </td>
		             </tr>
            <%
            		}
            	} 
            %>
            </tbody>
          </table>
    </div>
    </div>
</section>
<!-- 처리상태 수정 -->
<form
	name="stateUpdateFrm"
	action="<%= request.getContextPath() %>/admin/stateUpdate"
	method="POST">
	<input type="hidden" name="state"/>
	<input type="hidden" name="orderNo"/>
</form>
<script>
// 선택한 체크박스만 보이게
document.querySelectorAll("input[type=checkbox]").forEach((checkbox) => {
    checkbox.addEventListener("change", () => {
        const checkboxes = document.querySelectorAll("input[type=checkbox]");
        const tr = document.querySelectorAll("#tbl-orderList tbody tr");

        for(let i=0; i<tr.length; i++) {
            const stateVal = tr[i].querySelector(".state").value;
            let flag = true;
            
            for(let j=0; j<checkboxes.length; j++) {
            	if(checkboxes[j].checked && checkboxes[j].value === stateVal) {
            		flag = false;
            		break;
            	}
            }
           	tr[i].style.display = flag ? 'none' : 'table-row';
        }
    });
});

// 처리상태 수정
document.querySelectorAll("select.state").forEach((elem) => {
	elem.addEventListener("change", (e) => {
		
		if(confirm("처리상태를 수정하시겠습니까?")) {
			const stateVal = e.target.value;
			const orderNoVal = e.target.dataset.orderNo;
			
			const frm = document.stateUpdateFrm;
			frm.state.value = stateVal;
			frm.orderNo.value = orderNoVal;
			frm.submit();
		}
		else {
			e.target.querySelector("option[selected]").selected = true;
		}
	});
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>