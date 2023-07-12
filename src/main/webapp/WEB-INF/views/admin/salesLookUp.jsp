<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />

	<h1>매출조회</h1>
    <div class="search">
        <select name="" id="">
            <option value="총매출">총매출</option>
            <option value="이번달매출">이번달매출</option>
            <option value="하루매출">하루매출</option>
            <option value="연매출">연매출</option>
        </select>
        <input type="button" class="img-button" id="btn1">
    </div>
    <div class="wrapper">
		<table>
			<thead>
				<tr>
                    <th>아이디</th>
					<th>상품</th>
					<th>주문일자</th>
					<th>금액</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
    <script>
    const select = document.querySelector('.search select');
    const th = document.querySelector('.wrapper th:last-child');
    
    select.addEventListener('change', () => {
      const selectedVal = select.value;
      th.innerHTML = selectedVal;
    });
    </script>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>