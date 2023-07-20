<%@page import="com.semi.mvc.cart.model.vo.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
// List<Cart> carts = (List)request.getAttribute("carts");
%>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/cartList.css" />

<body>
	<section id="CartListSection">
	<h1>장 바 구 니</h1>
	
	<form 
		id ="printCartList"
		action="<%= request.getContextPath() %>/order/cart"
		method="POST">
	<input type="hidden" name="memberId" value="<%= loginMember %>>"/>
	<div id = "cartbuttons">
		<button id="cartUpdate">수량 수정</button>
		<button id="cartDelete">삭제</button>	
	</div>
	<label for="allCheck" id= "allChecklabel"> 전체 선택 &nbsp</label>
	<input type="checkbox" id="allCheck">
	<table id ="cartListTable">
        <thead>
            <tr>
                <th>선택</th>
                <th>번호</th>
                <th id="productCol">상품</th>
                <th>수량</th>
                <th>가격</th>
            </tr>
        </thead>
        <tbody></tbody>
        <tfoot>
        	<tr>
				<td colspan="6">총금액 : 0원</td>
			</tr>
        </tfoot>
    </table>
	<button id="order">주문하기</button>
	</form>
	
	</section>

	<script>
	window.onload=()=>{
		
		findAllCart();

		
	}
	document.querySelector("#allCheck").onclick=(e)=>{	
		const checkBoxes = document.querySelectorAll("[name=checkedOrNot]");
		checkBoxes.forEach((checkBox)=>{
			checkBox.checked = e.target.checked;			
		});
		totalSum();
	}
	
	
	const findAllCart = () =>{
		$.ajax({
			url: "<%= request.getContextPath()%>/myCart/list",
			dataType : "json",
			success(responseData){
				console.log(responseData);
				const tbody = document.querySelector("#cartListTable tbody");
				
				tbody.innerHTML ="";
				
				if(responseData == null || responseData.length == 0){
					tbody.innerHTML += `
						<tr>
		                <td  colspan="5">조회된 결과가 존재하지 않습니다.</td>               
		           		</tr>
					`;
				}
	
				let index = 1;
				
				responseData.forEach((cart)=>{
					const{cartNo, product, count, price} = cart;
					
					tbody.innerHTML += `
						<tr>
		                <td><input type="checkbox" name= "checkedOrNot" value = "\${cartNo}"></td>
		                <td>\${index}</td>
		                <td>\${product}</td>
		                <td><input type="number" name= "quentity" min="1" max="10" value = "\${count}">
		                	<input type = "hidden" name= "cartNumber" value="\${cartNo}">
		                </td>
		                <td>\${price}</td>
		           		</tr>
					`;
					 index++;

				});	

				document.querySelectorAll("input[name=checkedOrNot]").forEach((checkbox) => {	
					checkbox.addEventListener('change', () => {
						totalSum();
					});
				});				
			}
		
		});
	};
	
	
	const totalSum =() =>{
		
		let sum = 0;
		const tfoot = document.querySelector("#cartListTable tfoot");
		document.querySelectorAll("input[name=checkedOrNot]").forEach((checkbox) => {
			
			if(checkbox.checked) {
				const tr = checkbox.closest("tr"); 
			    const price = parseFloat(tr.querySelector('td:last-child').innerHTML);
			    sum += price;
			}
			
			tfoot.innerHTML = `
				<tr>
					<td colspan="6">총금액 : \${sum}원</td>
				</tr>
			`;
			
		});	
		
	}
	

	document.querySelector("#cartDelete").onclick =(e) =>{

		const checkboxes = document.querySelectorAll("input[name=checkedOrNot]");
		  
		let flag = true;
		
	    checkboxes.forEach((checkbox) => {
			if (checkbox.checked) 		   
			    flag = false;
		});
	    if(flag){
	    	 alert('선택하신 상품이 없습니다.');
			 e.preventDefault();
			 return;
	    }
			
        if(!flag && confirm('정말 삭제하시겠습니까?')) {
            document.querySelector("#printCartList").onsubmit =(e) =>{

                e.preventDefault();

                const frmData = new FormData(e.target); 
                $.ajax({
                    url : "<%= request.getContextPath()%>/delete/cart",
                    data : frmData,
                    processData : false, 
                    contentType : false, 
                    method : "POST",
                    dataType : "json",
                    success(responseData){
                        const {result, message} = responseData;
                        alert(message);
                    },
                    complete(){
                        findAllCart();
                        const tfoot = document.querySelector("#cartListTable tfoot");
                		tfoot.innerHTML = `
                			<tr>
                				<td colspan="6">총금액 : 0원</td>
                			</tr>
                		`;
                		location.reload();
                    }
                });

            }

        }
    }
	
	
	
	document.querySelector("#cartUpdate").onclick =(e) =>{
	
		checkckeck(e);
		
		document.querySelector("#printCartList").onsubmit =(e) =>{
			
			e.preventDefault();
			
			const frmData = new FormData(e.target); 
			$.ajax({				
				url : "<%= request.getContextPath()%>/update/cart",
				data : frmData,
				processData : false, 
				contentType : false, 
				method : "POST",
				dataType : "json",
				success(responseData){
					const {result, message} = responseData;
					alert(message);
				
				},
				complete(){
					
					const tfoot = document.querySelector("#cartListTable tfoot");
					tfoot.innerHTML = `
						<tr>
							<td colspan="6">총금액 : 0원</td>
						</tr>
					`;
					
					findAllCart();
					location.reload();
				}
			
			});
			
		}
		
	}
	
	// 선택한 상품 없으면 주문 x
	document.querySelector("#printCartList").onsubmit = (e) => {
		
		const checkboxes = document.querySelectorAll("input[name=checkedOrNot]");
		  
		let flag = true;
	    checkboxes.forEach((checkbox) => {
			if (checkbox.checked) 		   
			    flag = false;
		});
	    if(flag){
	    	 alert('선택하신 상품이 없습니다.');
			 e.preventDefault();
	    }
		
	};
	
	const checkckeck = (e) => {
		
		const checkboxes = document.querySelectorAll("input[name=checkedOrNot]");
		  
		let flag = true;
	    checkboxes.forEach((checkbox) => {
			if (checkbox.checked) 		   
			    flag = false;
		});
	    if(flag){
	    	 alert('선택하신 상품이 없습니다.');
			 e.preventDefault();
			 return;
	    }
	};
	
	
	
	
	</script>

</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>