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
	<a href="ki_main.go">
        <i class="fa-solid fa-angles-left back"></i>
    </a>
    <a href="ki_logout.do">
        <i class="fa-solid fa-arrow-right-from-bracket logout"></i>
    </a>
    <div class="seatLayout">
        <div class="info">
            <div id="door">출입문</div>
            <div id="seatBlueColor"></div>
            <div id="seatBlueMsg">이용<br>가능</div>
            <div id="seatPinkColor"></div>
            <div id="seatPinkMsg">이용<br>불가</div>
        </div>
        <div class="seatState">
            <div class="section" id="section1">
                <div class="table" id="table1">
                    <div class="Column" id="Column1">
                        <div class="seat" id="1" onclick="location.href='seatUse.html'">1<br><br>이용가능</div>
                        <div class="seat" id="2">2<br><br>이용가능</div>
                        <div class="seat" id="3">3<br><br>이용가능</div>
                        <div class="seat" id="4">4<br><br>이용가능</div>
                        <div class="seat" id="5">5<br><br>이용가능</div>
                    </div>
                    <div class="Column" id="Column2">
                        <div class="seat" id="6">6<br><br>이용가능</div>
                        <div class="seat" id="7">7<br><br>이용가능</div>
                        <div class="seat" id="8">8<br><br>이용가능</div>
                        <div class="seat" id="9">9<br><br>이용가능</div>
                        <div class="seat" id="10">10<br><br>이용가능</div>
                    </div>
                </div>
            </div>
            <div class="section" id="section2">
                <div class="table" id="table2">
                    <div class="Column" id="Column3">
                        <div class="seat" id="11">11<br><br>이용가능</div>
                        <div class="seat" id="12">12<br><br>이용가능</div>
                        <div class="seat" id="13">13<br><br>이용가능</div>
                        <div class="seat" id="14">14<br><br>이용가능</div>
                        <div class="seat" id="using">15<br><br>이용가능</div>
                    </div>
                    <div class="Column" id="Column4">
                        <div class="seat" id="16">16<br><br>이용가능</div>
                        <div class="seat" id="17">17<br><br>이용가능</div>
                        <div class="seat" id="18">18<br><br>이용가능</div>
                        <div class="seat" id="19">19<br><br>이용가능</div>
                        <div class="seat" id="using">20<br><br>13:00~17:00</div>
                    </div>
                </div>
            </div>
            <div class="section" id="section3">
                <div class="table" id="table3">
                    <div class="Column" id="Column5">
                        <div class="seat" id="21">21<br><br>이용가능</div>
                        <div class="seat" id="22">22<br><br>이용가능</div>
                        <div class="seat" id="23">23<br><br>이용가능</div>
                        <div class="seat" id="24">24<br><br>이용가능</div>
                        <div class="seat" id="25">25<br><br>이용가능</div>
                    </div>
                    <div class="Column" id="Column6">
                        <div class="seat" id="26">26<br><br>이용가능</div>
                        <div class="seat" id="27">27<br><br>이용가능</div>
                        <div class="seat" id="28">28<br><br>이용가능</div>
                        <div class="seat" id="29">29<br><br>이용가능</div>
                        <div class="seat" id="30">30<br><br>이용가능</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
	$('.seat').on('click',function(){
	    var seatNo = $(this).attr('id');
	    console.log(seatNo);
	    location.href='seatUse.html?seatNo='+seatNo;
	});
</script>
</html>