<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<style>
body {
    width: 1024px;
    margin: 0 auto;
    text-align: center;
}
.title-wrapper {
    font-size: 60px;
    font-weight: bolder;
}
.introduce-wrapper span {
    font-size: 30px;
}
.introduce-wrapper {
    margin-top: 150px
}
#span1 {
    font-size: 40px;
    font-weight: bolder;
}
#span2 {
    font-size: 40px;
    font-weight: bolder;
}
#img1 {
    width: 250px;
    margin-right: 45px;
    display: inline-block;
}
#img2 {
    width: 50px;
}
#img3 {
    width: 250px;
    margin-left: 45px;
    display: inline-block;
}
.promise-wrapper {
    display: flex; 
    justify-content: center; 
    align-items: center;
}
.promise-wrapper span1 {
    font-weight: bolder;
}
#span3 {
    display: inline-block;
    margin-top: 45px;
}
#span4 {
    cursor: pointer;
}
\
@font-face {font-family: 'Giants-Inline'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-1@1.1/Giants-Inline.woff2') format('woff2'); font-weight: normal; font-style: normal;}
@font-face {font-family: 'GongGothicMedium'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff') format('woff'); font-weight: normal; font-style: normal;}
@font-face {font-family: 'IBMPlexSansKR-Regular'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff'); font-weight: normal; font-style: normal;}
@font-face {font-family: 'GmarketSansMedium';src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');font-weight: normal;font-style: normal;}
@font-face {font-family: 'PyeongChangPeace-Bold'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-02@1.0/PyeongChangPeace-Bold.woff2') format('woff2');font-weight: 700;font-style: normal;}
#howToUse-container { width: 1000px; margin: 10% 0; text-align:center}
#howToUse-container div {width: 45%; display: inline-block; margin: 2%;}
.howToUse {border: 2px solid black; }
.howToUse img{width: 100%;} 
.howToUse p {font-family:'IBMPlexSansKR-Regular', Courier, monospace; font-size : 20px; margin: 3% 0;}


</style>
<body>
    <div class="title-wrapper" style="margin-top: 100px;">
        <span id="span4" style="color: green;">소개</span>
        <span>|</span>
        <span id="span4">이용방법</span>
    </div>
    <form action="" name="introduce-container">
        <div class="introduce-wrapper">
            <span id="span1">저희 <span id="span2" style="color: green;">킥킥샐러드</span>는</span><br>
            <span>커스텀 칼로리의 약자로 <span style="font-weight: bolder; color: cornflowerblue;">ㅋㅋ</span>을 따서 왔습니다</span><br>
            <img src="<%= request.getContextPath() %>/images/main/logo.png" style="width: 300px; margin-top: 45px;"><br>
            <span id="span3">야채의 종류부터 토핑까지 내 선호에 맞게 고르는 것은 물론, <br> 1인분의 양에 구애받지 않고 원하는 만큼만 주문할 수 있는 <br> 맞춤형 샐러드 주문 시스템입니다.</span>
        </div>
        <div style="margin-top: 110px">
            <span id="span1">킥킥샐러드만의 <span id="span2" style="color: chartreuse;">약속</span></span>
        </div>
        <div style="margin-top: 100px;">
            <div class="promise-wrapper">
                <div>
                    <img src="/semi/images/하트.png" id="img1">
                </div>
                <div>
                    <div>
                        <img src="<%= request.getContextPath() %>/images/main/finger1.png" id="img2">
                        <span id="span1" style="font-size: 30px;">엄격하게 관리되는 우리의 재료</span>
                    </div>
                    <div style="width: 500px; margin-top: 20px;">
                        <span>매일 매장에 배송되는 신선한 야채들은 각 매장에서 정성스럽게 손질됩니다. 엄격한 규율에 따라 세척 과정을 거친 야채들은 당일 판매되는 양만큼 준비되며 언제나 신선한 최상의 야채를 안전하게 제공하는 것이 써브웨이의 목표입니다.</span>
                    </div>
                </div>
            </div>
            <div class="promise-wrapper">
                <div>
                    <div>
                        <img src="<%= request.getContextPath() %>/images/main/finger2.png" id="img2">
                        <span id="span1" style="font-size: 30px;">신선함을 위한 우리의 노력</span>
                    </div>
                    <div style="width: 500px; margin-top: 20px;">
                        <span>킥킥샐러드의 빵은 인위적 당분이 함유되어 있지 않으며 비타민과 칼슘을 강화하고 나트륨을 줄이는 등 건강한 먹거리를 제공하기 위해 노력하고 있습니다.</span>
                    </div>
                </div>
                <div>
                    <img src="/semi/images/하트.png" id="img3">
                </div>
            </div>
            <div class="promise-wrapper">
                <div>
                    <img src="/semi/images/하트.png" id="img1">
                </div>
                <div>
                    <div>
                        <img src="<%= request.getContextPath() %>/images/main/finger3.png" id="img2">
                        <span id="span1" style="font-size: 30px;">환경을 위한 우리의 노력</span>
                    </div>
                    <div style="width: 500px; margin-top: 20px;">
                        <span>킥킥샐러의 샐러드 보울은 95% 재생 용기로 만들어졌으며, 매장 내 일회용품 사용을 줄여 나가고 있습니다. 써브웨이는 작은 부분이라도 놓치지 않고 환경을 늘 생각하는 브랜드가 되기 위해 지속적으로 노력하고 있습니다.</span>
                    </div>
                </div>
            </div>
        </div>
        </form>
    	<form action="" id="howToUse-container" style="display: none;">
        <fieldset>  
        <div class="howToUse">
            <img src="<%= request.getContextPath() %>/images/main/step1.jpg" class="steps">
            <p>1. 샐러드로 먹을지, 샌드위치로 먹을지 골라주세요</p>
        </div>
        <div class="howToUse">
            <img src="<%= request.getContextPath() %>/images/main/step2.jpg" class="steps">
            <p>2. 원하는 야채를 원하는 만큼 골라주세요</p>
        </div>
        <div class="howToUse">
            <img src="<%= request.getContextPath() %>/images/main/step3.jpg" class="steps">
            <p>3. 다양한 토핑들을 마음껏 골라주세요</p>
        </div>
        <div class="howToUse">
            <img src="<%= request.getContextPath() %>/images/main/step4.jpg" class="steps">
            <p>4. 소스까지 골라주면 나만의 커스텀 메뉴가 완성됩니다!</p>
        </div>
        </fieldset>
        <br>
    </form>
</body>
<script>
const span = document.querySelectorAll("#span4");
for(let i=0; i<span.length; i++) {

    span[i].onclick = () => {

        const frm1 = document.querySelector("[name=introduce-container]");
        const frm2 = document.querySelector("#howToUse-container");
        if(i == 0) {
            frm1.style.display = "block";
            frm2.style.display = "none";
            span[0].style.color = "green";
            span[1].style.color = "black";
        } else {
            frm1.style.display = "none";
            frm2.style.display = "block";
            span[0].style.color = "black";
            span[1].style.color = "green";
        }

    }
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>