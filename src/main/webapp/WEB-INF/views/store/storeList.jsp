<%@page import="com.semi.mvc.store.model.vo.Store"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Store> stores = (List<Store>)request.getAttribute("stores");
	// 검색관련 
	String searchKeyword = request.getParameter("searchKeyword");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/store.css" />
<section id="storeList-container">
	<h2>매장조회</h2>
	
	<div id="search-container">
       
        <div id="search-name">
            <form action="<%=request.getContextPath()%>/store/storeFinder">
                <input type="text" name="searchKeyword" size="25" placeholder="검색할 매장명을 입력하세요."/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
       
    </div> 
	
	<table id="tbl-store">
		<thead>
			<tr>
				<th>매장번호</th>
				<th>매장명</th>
				<th>주소</th>
				<th>연락처</th>
				
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

<%@ include file="/WEB-INF/views/common/footer.jsp" %>