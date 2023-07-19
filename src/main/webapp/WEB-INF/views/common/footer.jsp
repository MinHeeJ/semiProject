<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <!-- 고객센터 -->
    <div class="serviceCenter">
        <a href="<%= request.getContextPath()%>/board/faqList">고객센터</a>
        <img class="clickImg" src="<%= request.getContextPath() %>/images/main/CSicon.png"; />
    </div>

    <footer>
        <p>서울시 서초구 강남대로 100 프린스세스빌딩 20층<br>
        대표 : 킥킥샐러드 | 전화 : 02-123-4567 | 사업자등록번호 : 000-11-2233 <br>
KiKKiKSalad is a Registered Trademark of KiKKiKSalad IP LLC. © 2023 KiKKiKSalad IP LLC. All Rights Reserved.
    </footer>
    <script>
    const clickImage = document.querySelector(".clickImg");
    clickImage.addEventListener('click', () => {
		const link = clickImage.parentNode.querySelector('a');
	      if (link) {
	          window.location.href = link.href;
	        }
	});
    </script>

</body>
</html>