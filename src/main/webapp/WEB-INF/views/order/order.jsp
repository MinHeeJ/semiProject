<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<style>
/*메인 네비바까지*/
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
	display: block;
}

ol, ul {
	list-style: none;
}
blockquote, q {
	quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
	content: '';
	content: none;
}
table {
	border-collapse: collapse;
	border-spacing: 0;
}

a, ul, li{
    text-decoration: none;
    color: #000;
}

body {
	line-height: 1;
    max-width:1200px;
    margin: 0 auto;
}

header{
    text-align:center;
}

header > .header_image{
    display: inline-block;
    height: 100%;
    width:280px;
}

header > .header_image > img{
    width: 100%;
}

header > nav{
    height: 3.125rem;
    line-height: 3.125rem;
    background-color:#086528;
    border-radius: 5px;
}

header > nav > ul{
    display: flex;
    justify-content: space-evenly;
}

header > nav > ul > li > a{
    display: inline-block;
    height: 100%;
    padding: 0 30px;
    color: #fff;
    font-weight: bold;
    font-size:20px;
}


/*메인영역*/
.wrapper{
    text-align: center;
}
.text{
    font-size: 40px;
    font-weight: 600;
    padding: 50px;
}
.image img{
    width: 400px;
}

img{
    width: 200px;  
}
</style>
<% loginMember = "honggd"; %>
<body>
    
    <div class="wrapper">	
      
      <h1>주문완료</h1>
    
      <div class="image">
        <img src=""/></a>
      </div>

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
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>