<%@page import="com.semi.mvc.order.model.vo.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/list.css" />
<style>
.btncalendar{display:inline-block;width:31px;height:20px;background:url("<%= request.getContextPath() %>/images/order/calendar.png") center center no-repeat; background-size: 31px 20px; text-indent:-999em}
</style>

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- datepicker 한국어로 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>

<section id="salesLookUpSection">
	<form name="salesLookUpFrm">
	    
	<!-- search -->
	<table class="searchBox">
	    <caption id="caption">조회</caption>
	    <colgroup>
	        <col width="123px">
	        <col width="*">
	    </colgroup>
	    <tbody>
	        <tr>
	            <th>조회기간</th>
	            <td>
	                <ul class="searchDate">
	                    <li>
	                        <span class="chkbox2">
	                            <input type="radio" name="dateType" id="dateType1" onclick="setSearchDate('0d')"/>
	                            <label for="dateType1">당일</label>
	                        </span>
	                    </li>
	                    <li>
	                        <span class="chkbox2">
	                            <input type="radio" name="dateType" id="dateType2" onclick="setSearchDate('3d')"/>
	                            <label for="dateType2">3일</label>
	                        </span>
	                    </li>
	                    <li>
	                        <span class="chkbox2">
	                            <input type="radio" name="dateType" id="dateType3" onclick="setSearchDate('1w')"/>
	                            <label for="dateType3">1주</label>
	                        </span>
	                    </li>
	                    <li>
	                        <span class="chkbox2">
	                            <input type="radio" name="dateType" id="dateType4" onclick="setSearchDate('2w')"/>
	                            <label for="dateType4">2주</label>
	                        </span>
	                    </li>
	                    <li>
	                        <span class="chkbox2">
	                            <input type="radio" name="dateType" id="dateType5" onclick="setSearchDate('1m')"/>
	                            <label for="dateType5">1개월</label>
	                        </span>
	                    </li>
	                    <li>
	                        <span class="chkbox2">
	                            <input type="radio" name="dateType" id="dateType6" onclick="setSearchDate('3m')"/>
	                            <label for="dateType6">3개월</label>
	                        </span>
	                    </li>
	                    <li>
	                        <span class="chkbox2">
	                            <input type="radio" name="dateType" id="dateType7" onclick="setSearchDate('6m')"/>
	                            <label for="dateType7">6개월</label>
	                        </span>
	                    </li>
	                </ul>
	                
	                <div class="clearfix">
	                    <!-- 시작일 -->
	                    <span class="dset">
	                        <input type="text" class="datepicker inpType" name="searchStartDate" id="searchStartDate" >
	                        <a href="#none" class="btncalendar dateclick">달력</a>
	                    </span>
	                    <span class="demi">~</span>
	                    <!-- 종료일 -->
	                    <span class="dset">
	                        <input type="text" class="datepicker inpType" name="searchEndDate" id="searchEndDate" >
	                        <a href="#none" class="btncalendar dateclick">달력</a>
	                    </span>
	                 <button id="search">검색</button>    
	                </div>
	            </td>
	        </tr>
	
	    <tbody>
	</table>
	</form>
	
	
    <div class="wrapper">
	<h1>매출조회</h1>
        <table id="tbl-salesLookUp">
            <thead>
            	<tr>
   	              	<th>주문번호</th>
   	                <th>회원아이디</th>
   	                <th>상품</th>
   	                <th>수량</th>
   	                <th>주문일자</th>
   	                <th>금액</th>
              	</tr>
            </thead>
            <tbody>
            	<tr>
            		<td colspan="6">조회된 결과가 존재하지 않습니다.</td>
            	</tr>
            </tbody>
            <tfoot></tfoot>
         </table>
    </div>
</section>
<script>                

    $(document).ready(function() {

        //datepicker 한국어로 사용하기 위한 언어설정
        $.datepicker.setDefaults($.datepicker.regional['ko']);     
    
        // Datepicker            
        $(".datepicker").datepicker({
            showButtonPanel: true, // 버튼패널 표시
            dateFormat: "yy-mm-dd", // 날짜형식 -년-월-일
            onClose : function ( selectedDate ) { // 날짜 선택기가 닫힐때 실행되는 콜백함수
            
                var eleId = $(this).attr("id"); // 현재 datepicker의 id를 가져와 eleId 변수에 저장
                var optionName = ""; // optionName 변수 초기화

                if(eleId.indexOf("StartDate") > 0) {
                    eleId = eleId.replace("StartDate", "EndDate");
                    optionName = "minDate";
                } else {
                    eleId = eleId.replace("EndDate", "StartDate");
                    optionName = "maxDate";
                }

                //$("#"+eleId).datepicker( "option", optionName, selectedDate );        
                //$(".searchDate").find(".chkbox2").removeClass("on"); 
                
            }
        }); 

        //시작일.
        /*$('#searchStartDate').datepicker("option","onClose", function( selectedDate ) {    
            // 시작일 datepicker가 닫힐때
            // 종료일의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            $("#searchEndDate").datepicker( "option", "minDate", selectedDate );
            $(".searchDate").find(".chkbox2").removeClass("on");
        });
        */

        //종료일.
        /*$('#searchEndDate').datepicker("option","onClose", function( selectedDate ) {    
            // 종료일 datepicker가 닫힐때
            // 시작일의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
            $("#searchStartDate").datepicker( "option", "maxDate", selectedDate );
            $(".searchDate").find(".chkbox2").removeClass("on");
        });
        */

        $(".dateclick").dateclick();    // DateClick
        $(".searchDate").schDate();        // searchDate
        
    });

    // Search Date
    jQuery.fn.schDate = function(){
        var $obj = $(this);
        var $chk = $obj.find("input[type=radio]");
        $chk.click(function(){                
            $('input:not(:checked)').parent(".chkbox2").removeClass("on");
            $('input:checked').parent(".chkbox2").addClass("on");                    
        });
    };

    // DateClick
    jQuery.fn.dateclick = function(){
        var $obj = $(this);
        $obj.click(function(){
            $(this).parent().find("input").focus();
        });
    }    

    // 날짜검색
    function setSearchDate(start){

        var num = start.substring(0,1);
        var str = start.substring(1,2);

        var today = new Date();

        //var year = today.getFullYear();
        //var month = today.getMonth() + 1;
        //var day = today.getDate();
        
        var endDate = $.datepicker.formatDate('yy-mm-dd', today);
        $('#searchEndDate').val(endDate);
        
        if(str == 'd'){
            today.setDate(today.getDate() - num);
        }else if (str == 'w'){
            today.setDate(today.getDate() - (num*7));
        }else if (str == 'm'){
            today.setMonth(today.getMonth() - num);
            today.setDate(today.getDate() + 1);
        }

        var startDate = $.datepicker.formatDate('yy-mm-dd', today);
        $('#searchStartDate').val(startDate);
                
        // 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
        // detepicker 옵션 minDate 최소선택일자
        $("#searchEndDate").datepicker( "option", "minDate", startDate );
        // detepicker 옵션 maxDate 최대선택일자
        // 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
        $("#searchStartDate").datepicker( "option", "maxDate", endDate );

    }
    
    
    document.salesLookUpFrm.onsubmit = (e) => {
    	e.preventDefault();
    	
    	console.log(e.target);
    	const frmData = new FormData(e.target);
    	
    	$.ajax({
    		url : "<%= request.getContextPath() %>/admin/salesLookUp",
    		data : frmData,
    		processData : false,
    		contentType : false,
    		method : "POST",
    		dataType : "json",
    		success (responseData) {
    			const {result, orders} = responseData;
    			console.log(orders);
    			
    			const tbody = document.querySelector(".wrapper table tbody");
    			const tfoot = document.querySelector(".wrapper table tfoot");
    			tbody.innerHTML = "";
    			tfoot.innerHTML = "";
    			
    			let sum = 0;
    			orders.forEach((temp) => {
    				sum += temp.price;
    				console.log(sum);
    				
                    tbody.innerHTML += `
                        <tr>
                            <td>\${temp.orderNo}</td>
                            <td>\${temp.memberId}</td>
                            <td>\${temp.product}</td>
                            <td>\${temp.count}</td>
                            <td>\${temp.orderDate}</td>
                            <td>\${temp.price}원</td>
                        </tr> 
                   	 `;
                   	 tfoot.innerHTML = `
                   	 	<tr>
                   	 		<td colspan="6">총매출 : \${sum}원</td>
                   	 	</tr>
                   	 `;
                });
    		}
    	});
    }
    
</script>
</body>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>