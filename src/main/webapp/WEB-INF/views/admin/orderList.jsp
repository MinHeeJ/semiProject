<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />

	<div class="wrapper">
        <div class="text">
            <h1>주문내역 전체조회</h1>
        </div>

        <table>
            <thead>
              <tr>
                <th>회원아이디</th>
                <th>이름</th>
                <th>상품</th>
                <th>수량</th>
                <th>주문일자</th>
                <th>처리상태</th>
              </tr>
            </thead>
            
            <tbody>
              <tr>
                <td>MIROO</td>
                <td>한미루</td>
                <td>샐러드(~)</td>
                <td>1</td>
                <td>2023-07-02</td>
                <td>
                  <select>
                    <option value="준비중">준비중</option>
                    <option value="완료">완료</option>
                  </select>
                </td>
              </tr>

              <tr>
                <td>MINHEE</td>
                <td>정민희</td>
                <td>샌드위치(~)</td>
                <td>2</td>
                <td>2023-07-02</td>
                <td>
                  <select>
                    <option value="준비중">준비중</option>
                    <option value="완료">완료</option>
                  </select>
                </td>
              </tr>

              <tr>
                <td>HEEJIN</td>
                <td>신희진</td>
                <td>샐러드(~)</td>
                <td>3</td>
                <td>2023-07-02</td>
                <td>
                  <select>
                    <option value="준비중">준비중</option>
                    <option value="완료">완료</option>
                  </select>
                </td>
              </tr>
            
            </tbody>
          </table>
        </div>
        
<%@ include file="/WEB-INF/views/common/footer.jsp" %>