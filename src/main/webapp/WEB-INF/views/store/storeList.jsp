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
<style>
#map { width:500px; height:400px; }
</style>
</head>
<body>
	

	
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=53ca7ba233962018a7a8996d89d2622a&libraries=services"></script>
  <div id="map"></div>
<script>
  var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	  mapOption = {
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	  };

  // 지도를 생성합니다
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  // 장소의 정보들을 담을 positions 배열
  var positions = [
    {
      title: '카카오',
      address: '제주특별자치도 제주시 첨단로 242'
    },
    {
      title: '생태연못',
      address: '경기 남양주시 조안면 능내리 50'
    },
    {
      title: '근린공원',
      address: '경기 남양주시 별내면 청학로68번길 40'
    }
  ];

  positions.forEach(function (position) { //추가한 코드
    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(position.address, function(result, status) {

      // 정상적으로 검색이 완료됐으면
      if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
          map: map,
          position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        //변경한 코드
        var infowindow = new kakao.maps.InfoWindow({
          content: '<div style="width:150px;text-align:center;padding:6px 0;">' + position.title + '</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
      }
    });
  });
</script>
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
			 <%	}%>
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
					 <%} %>
				</tr>
				<% 		
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
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>