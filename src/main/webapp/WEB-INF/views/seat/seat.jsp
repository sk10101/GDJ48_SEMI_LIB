<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/seat.css">
<style></style>
</head>
<body>
	<div class="seatSection">
        <h1>열람실 현황</h1><br>
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
                            <div id="seatNo1">1<br><br>이용가능</div>
                            <div id="seatNo2">2<br><br>이용가능</div>
                            <div id="seatNo3">3<br><br>이용가능</div>
                            <div id="seatNo4">4<br><br>이용가능</div>
                            <div id="seatNo5">5<br><br>이용가능</div>
                        </div>
                        <div class="Column" id="Column2">
                            <div id="seatNo6">6<br><br>이용가능</div>
                            <div id="seatNo7">7<br><br>이용가능</div>
                            <div id="seatNo8">8<br><br>이용가능</div>
                            <div id="seatNo9">9<br><br>이용가능</div>
                            <div id="seatNo10">10<br><br>이용가능</div>
                        </div>
                    </div>
                </div>
                <div class="section" id="section2">
                    <div class="table" id="table2">
                        <div class="Column" id="Column3">
                            <div id="seatNo1">11<br><br>이용가능</div>
                            <div id="seatNo2">12<br><br>이용가능</div>
                            <div id="seatNo3">13<br><br>이용가능</div>
                            <div id="seatNo4">14<br><br>이용가능</div>
                            <div id="using">15<br><br>이용가능</div>
                        </div>
                        <div class="Column" id="Column4">
                            <div id="seatNo6">16<br><br>이용가능</div>
                            <div id="seatNo7">17<br><br>이용가능</div>
                            <div id="seatNo8">18<br><br>이용가능</div>
                            <div id="seatNo9">19<br><br>이용가능</div>
                            <div id="using">20<br><br>13:00~17:00</div>
                        </div>
                    </div>
                </div>
                <div class="section" id="section3">
                    <div class="table" id="table3">
                        <div class="Column" id="Column5">
                            <div id="seatNo1">21<br><br>이용가능</div>
                            <div id="seatNo2">22<br><br>이용가능</div>
                            <div id="seatNo3">23<br><br>이용가능</div>
                            <div id="seatNo4">24<br><br>이용가능</div>
                            <div id="seatNo5">25<br><br>이용가능</div>
                        </div>
                        <div class="Column" id="Column6">
                            <div id="seatNo6">26<br><br>이용가능</div>
                            <div id="seatNo7">27<br><br>이용가능</div>
                            <div id="seatNo8">28<br><br>이용가능</div>
                            <div id="seatNo9">29<br><br>이용가능</div>
                            <div id="seatNo10">30<br><br>이용가능</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script></script>
</html>