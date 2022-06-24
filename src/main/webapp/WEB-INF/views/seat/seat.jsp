<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/seat.css">
<link rel="icon" href="resources/img/favicon.png">
<style></style>
</head>
<body>
	<div id="header">
		<jsp:include page="../commons/header.jsp"/>
	</div>
	<hr>
	<div id="body">
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
	                            <div class=${seatNo0} id="1">1<br><br>${seatNo0}</div>
	                            <div class=${seatNo1} id="2">2<br><br>${seatNo1}</div>
	                            <div class=${seatNo2} id="3">3<br><br>${seatNo2}</div>
	                            <div class=${seatNo3} id="4">4<br><br>${seatNo3}</div>
	                            <div class=${seatNo4} id="5">5<br><br>${seatNo4}</div>
	                        </div>
	                        <div class="Column" id="Column2">
	                            <div class=${seatNo5} id="6">6<br><br>${seatNo5}</div>
	                            <div class=${seatNo6} id="7">7<br><br>${seatNo6}</div>
	                            <div class=${seatNo7} id="8">8<br><br>${seatNo7}</div>
	                            <div class=${seatNo8} id="9">9<br><br>${seatNo8}</div>
	                            <div class=${seatNo9} id="10">10<br><br>${seatNo9}</div>
	                        </div>
	                    </div>
	                </div>
	                <div class="section" id="section2">
	                    <div class="table" id="table2">
	                        <div class="Column" id="Column3">
	                            <div class=${seatNo10} id="11">11<br><br>${seatNo10}</div>
	                            <div class=${seatNo11} id="12">12<br><br>${seatNo11}</div>
	                            <div class=${seatNo12} id="13">13<br><br>${seatNo12}</div>
	                            <div class=${seatNo13} id="14">14<br><br>${seatNo13}</div>
	                            <div class=${seatNo14} id="15">15<br><br>${seatNo14}</div>
	                        </div>
	                        <div class="Column" id="Column4">
	                            <div class=${seatNo15} id="16">16<br><br>${seatNo15}</div>
	                            <div class=${seatNo16} id="17">17<br><br>${seatNo16}</div>
	                            <div class=${seatNo17} id="18">18<br><br>${seatNo17}</div>
	                            <div class=${seatNo18} id="19">19<br><br>${seatNo18}</div>
	                            <div class=${seatNo19} id="20">20<br><br>${seatNo19}</div>
	                        </div>
	                    </div>
	                </div>
	                <div class="section" id="section3">
	                    <div class="table" id="table3">
	                        <div class="Column" id="Column5">
	                            <div class=${seatNo20} id="21">21<br><br>${seatNo20}</div>
	                            <div class=${seatNo21} id="22">22<br><br>${seatNo21}</div>
	                            <div class=${seatNo22} id="23">23<br><br>${seatNo22}</div>
	                            <div class=${seatNo23} id="24">24<br><br>${seatNo23}</div>
	                            <div class=${seatNo24} id="25">25<br><br>${seatNo24}</div>
	                        </div>
	                        <div class="Column" id="Column6">
	                            <div class=${seatNo25} id="26">26<br><br>${seatNo25}</div>
	                            <div class=${seatNo26} id="27">27<br><br>${seatNo26}</div>
	                            <div class=${seatNo27} id="28">28<br><br>${seatNo27}</div>
	                            <div class=${seatNo28} id="29">29<br><br>${seatNo28}</div>
	                            <div class=${seatNo29} id="30">30<br><br>${seatNo29}</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
    </div>
</body>
<script></script>
</html>