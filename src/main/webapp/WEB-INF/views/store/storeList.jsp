<%@page import="com.semi.mvc.review.model.vo.Review"%>
<%@page import="com.semi.mvc.store.model.vo.Store"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	Review review = (Review) request.getAttribute("review");
	List<Store> stores = (List<Store>)request.getAttribute("stores");
	// 검색관련 
	String searchKeyword = request.getParameter("searchKeyword");
	
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/store.css" />
<% boolean admin = loginMember != null && (loginMember.getMemberRole() == MemberRole.A); %>

</head>
<body>
	

  <script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=53ca7ba233962018a7a8996d89d2622a&libraries=services,clusterer,drawing"></script>

<section id="storeList-container">

	<h2>매장조회</h2>
	
			
        	<div id="search-name">
            <form action="<%=request.getContextPath()%>/store/storeFinder">
                <input type="text" name="searchKeyword" size="25" placeholder="검색할 매장명을 입력하세요."/>
                <button class="searchbutton" type="submit">검색</button>			
            </form>	
           <%	if (admin) { %>
			<div id="search-container">
	       <input class="button" type="button" value="매장등록" onclick="location.href='<%= request.getContextPath() %>/store/storeEnroll';">
			</div>
			<%	}%>
        </div>
            
        
       

	<table id="tbl-store">
		<thead>
			<tr>
				<th>매장번호</th>
				<th>매장명</th>
				<th>주소</th>
				<th>연락처</th>
				 <%	if (admin) { %>
				<th>매장삭제</th>
			 <%	} else {%>
		 		<th></th>
			 <% } %>
			</tr>
		</thead>
		
		<tbody>
			<% 	if(stores == null || stores.isEmpty()) { %>
			<tr>
				<td colspan="4">조회 결과가 없습니다.</td>
			</tr>
			<%	
				} 
				else { 
					for(Store store : stores) {
			%>
			<tr>
				<td><%= store.getStoreNo() %></td>
				<td><%= store.getStoreName() %></td>
				<td><%= store.getAddress() %></td> 
				<td><%= store.getPhone() %></td> 
			 <%	if (admin) { %>
				<td>
					<input class="button" type="button" onclick="deleteStore('<%=store.getStoreNo()%>');" value="매장삭제">
				</td> 
				 <%} else { %>
			 	<td>
					<button id="btn1">지도보기</button>
					<input type="hidden" name="storeNo" value="<%= store.getStoreNo() %>">
				</td> 
			</tr>
			<% 		
				 }
					}
				} 
				
			%>
		</tbody>
	</table>
	<div id='pagebar'>
		<%= request.getAttribute("pagebar") %>
	</div>
	
</section>



<form action="<%= request.getContextPath() %>/store/storeDelete" name="storeDelFrm" method="POST" >
	<input type="hidden" name="storeNo" id="storeNo" value=""/>
</form>

<div id="backgroundPop">
	<div id="modalContent">
		<div id="map"></div>
		<button id="close">닫기</button>
	</div>
</div>

<script>


/* const deleteStore(storeNo) = (button) => {
	if(confirm("정말 매장을 삭제하시겠습니까?")){
		document.getElementById("storeNo").value = storeNo;
     
		//document.storeDelFrm.submit();
	}
} */

function deleteStore(storeNo){
	if(confirm("정말 매장을 삭제하시겠습니까?")){
		document.getElementById("storeNo").value = storeNo;
     
		document.storeDelFrm.submit();
	}
}

// 지도보기
document.querySelectorAll("#btn1").forEach((elem) => {
	elem.addEventListener('click', (e) => {
		console.log(1111111, e.target);
		const storeNo = e.target.parentNode.querySelector('input[name="storeNo"]').value;
		console.log(storeNo);
		$.ajax({
			 url : "<%= request.getContextPath() %>/store/lookMap",
			 data : {
				 storeNo : storeNo
			 },
			 success(store){
				 const {address} = store;
				 console.log(address);
				 var prevMapContainer = document.getElementById('map');
			     prevMapContainer.innerHTML = ''; 
				 var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		          mapOption = {
			            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			            level: 1 // 지도의 확대 레벨
			          };
				  var map = new kakao.maps.Map(prevMapContainer, mapOption);
				  // 지도를 생성합니다
				 // var map = new kakao.maps.Map(mapContainer, mapOption);
	
				  // 주소-좌표 변환 객체를 생성합니다
				  var geocoder = new kakao.maps.services.Geocoder();
	
				  // 주소로 좌표를 검색합니다
				  geocoder.addressSearch(address, function(result, status) {
	
					  console.log(result, " 12313131321");
	
				    // 정상적으로 검색이 완료됐으면
				    if (status === kakao.maps.services.Status.OK) {
	
				      var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
				      // 결과값으로 받은 위치를 마커로 표시합니다
				      var marker = new kakao.maps.Marker({
				        map: map,
				        position: coords
				      });
	
				   	  // 마커 이미지를 생성합니다
				      var imageSrc = '<%= request.getContextPath() %>/images/main/logo.png', // 마커이미지의 주소입니다    
				          imageSize = new kakao.maps.Size(50, 65), // 마커이미지의 크기입니다
				          imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	
				      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	
				      // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				      map.setCenter(coords);
				    }
				  });
				 },
				 complete() {
					 popOpen();
				 }
		});
	});
});

// 지도 모달창
function popOpen() {
	const modalPop = $('#map');
	document.querySelector("#backgroundPop").style.display = "inline-block";
	document.querySelector("#modalContent").style.display = "inline-block";
	
	$(modalPop).show();
}

// 모달창 닫기
document.querySelector("#close").onclick = () => {
	const modalPop = $('#map');
	document.querySelector("#backgroundPop").style.display = "none";
	document.querySelector("#modalContent").style.display = "none";
	
	$(modalPop).hide();
}

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>