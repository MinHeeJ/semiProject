<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/order.css" />
<body>
    
    <div class="veg-wrapper">	
      
      <div class="image">
        <img src="<%= request.getContextPath() %>/images/order/v2.png"/>
        <img src="<%= request.getContextPath() %>/images/order/v5.png"/>
        <img src="<%= request.getContextPath() %>/images/order/v1.png"/>
        <img src="<%= request.getContextPath() %>/images/order/v3.png"/>
	    <img src="<%= request.getContextPath() %>/images/order/v6.png"/>
      </div>
      
      <h1>주문완료</h1>
      
        <img src="<%= request.getContextPath() %>/images/order/v4.png"/>

      <div class="text">
        <h2>주문이 완료되었습니다.</h2>
        <h2>주문해주셔서 감사합니다.</h2>
      </div>

      <div class="btn-order">
        <form
	    	name="orderListFrm"
	    	action="<%= request.getContextPath() %>/order/orderList">
    		<input type="hidden" name="memberId" value="<%= loginMember %>"/>
	        <button id="btn1" type="button">메인화면으로</button>
        	<button>주문내역확인</button>
    	</form>
      </div>

   	</div>
          
</body>
<script>
btn1.onclick = () => {
	location.href = "<%= request.getContextPath() %>/index.jsp";
};
window.onload = () => {
	showImages();
}
const showImages = () => {
	let i = 0;
	const images = document.querySelectorAll("img");
	const interval = setInterval(() => {
		images[i].style.opacity = 1;
		i++;
		if(i >= images.length) {
			clearInterval(interval);
		}
	}, 400);
};
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>