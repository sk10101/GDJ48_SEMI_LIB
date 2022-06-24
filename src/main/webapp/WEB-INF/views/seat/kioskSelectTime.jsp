<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/5415520417.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/kioskStyle.css">
<style></style>
</head>
<body>
	<a href="ki_logout.do">
        <i class="fa-solid fa-angles-left back"></i>
    </a>
    <a href="ki_logout.do">
        <i class="fa-solid fa-arrow-right-from-bracket logout"></i>
    </a>
    <div class="useSection">
        <div class="selectSeatNo">
            좌석번호<br>1
        </div>
        <div class="nowTime" id="nowTime">
            **시 **분 ~
        </div>
        <div class="selectTime">
            <div class="row" id="row1">
                <button id="30min">30분</button>
                <button id="60min">1시간</button>
                <button id="90min">1시간 30분</button>
                <button id="120min">2시간</button>
            </div>
            <div class="row" id="row2">
                <button id="150min">2시간 30분</button>
                <button id="180min">3시간</button>
                <button id="210min">3시간 30분</button>
                <button id="240min">4시간</button>
            </div>
        </div>
        <button id="btn-seatUse" onclick="location.href='main.html'">좌석사용</button>
    </div>
</body>
<script>

	var Target = document.getElementById("nowTime");
	function clock() {
	    var time = new Date();
	
	    var hours = time.getHours();
	    var minutes = time.getMinutes();
	    
	    Target.innerText = `${hours}시 ${minutes}분 ~`;
	        
	}
	clock();
	setInterval(clock, 60000); // 1분마다 실행
	
	$('.row button').on('click',function(){
	    var useTime = $(this).attr('id');
	    console.log(useTime);
	});
	
</script>
</html>