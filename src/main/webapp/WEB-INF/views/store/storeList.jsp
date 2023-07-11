<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section id="storeList-container">
<h1>매장 추가</h1>
 <div id="search-store-name" class="search-type">
            <form action="<%=request.getContextPath()%>/store/storeFinder">
                <input type="hidden" name="searchType" value="name"/>
                <input 
                	type="text" name="searchKeyword" size="25" placeholder="검색할 매장명을 입력하세요."/>
               
                <button type="submit">검색</button>			
            </form>	
        </div>

<table id="tbl-store">

        <table>
            <tr>
                <th>매장명</th>
                <td>
                    <input type="text">
                    <input type="button" value="중복검사" onclick="checkStoreNameDuplicate();">
                    <input type="hidden" id="storeNameValid" value="0">
                    매장명 검사여부 확인용: 0-유효하지않음, 1-유효한 매장명
                </td>
            </tr>
            <tr>
                <th>주소</th>
                <td>
                    <input type="text">
                </td>
            </tr>
            <tr>
                <th>연락처</th>
                <td>
                    <input type="text">
                </td>
            </tr>
        </table>
        <input type="button" value="매장추가">

</table>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>