<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>키오스크좌석</title>
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
                        <div class=${seatStatus0} id="1">1<br><br>${seatStatus0}</div>
                        <div class=${seatStatus1} id="2">2<br><br>${seatStatus1}</div>
                        <div class=${seatStatus2} id="3">3<br><br>${seatStatus2}</div>
                        <div class=${seatStatus3} id="4">4<br><br>${seatStatus3}</div>
                        <div class=${seatStatus4} id="5">5<br><br>${seatStatus4}</div>
                    </div>
                    <div class="Column" id="Column2">
                        <div class=${seatStatus5} id="6">6<br><br>${seatStatus5}</div>
                        <div class=${seatStatus6} id="7">7<br><br>${seatStatus6}</div>
                        <div class=${seatStatus7} id="8">8<br><br>${seatStatus7}</div>
                        <div class=${seatStatus8} id="9">9<br><br>${seatStatus8}</div>
                        <div class=${seatStatus9} id="10">10<br><br>${seatStatus9}</div>
                    </div>
                </div>
            </div>
            <div class="section" id="section2">
                <div class="table" id="table2">
                    <div class="Column" id="Column3">
                        <div class=${seatStatus10} id="11">11<br><br>${seatStatus10}</div>
                        <div class=${seatStatus11} id="12">12<br><br>${seatStatus11}</div>
                        <div class=${seatStatus12} id="13">13<br><br>${seatStatus12}</div>
                        <div class=${seatStatus13} id="14">14<br><br>${seatStatus13}</div>
                        <div class=${seatStatus14} id="15">15<br><br>${seatStatus14}</div>
                    </div>
                    <div class="Column" id="Column4">
                        <div class=${seatStatus15} id="16">16<br><br>${seatStatus15}</div>
                        <div class=${seatStatus16} id="17">17<br><br>${seatStatus16}</div>
                        <div class=${seatStatus17} id="18">18<br><br>${seatStatus17}</div>
                        <div class=${seatStatus18} id="19">19<br><br>${seatStatus18}</div>
                        <div class=${seatStatus19} id="20">20<br><br>${seatStatus19}</div>
                    </div>
                </div>
            </div>
            <div class="section" id="section3">
                <div class="table" id="table3">
                    <div class="Column" id="Column5">
                        <div class=${seatStatus20} id="21">21<br><br>${seatStatus20}</div>
                        <div class=${seatStatus21} id="22">22<br><br>${seatStatus21}</div>
                        <div class=${seatStatus22} id="23">23<br><br>${seatStatus22}</div>
                        <div class=${seatStatus23} id="24">24<br><br>${seatStatus23}</div>
                        <div class=${seatStatus24} id="25">25<br><br>${seatStatus24}</div>
                    </div>
                    <div class="Column" id="Column6">
                        <div class=${seatStatus25} id="26">26<br><br>${seatStatus25}</div>
                        <div class=${seatStatus26} id="27">27<br><br>${seatStatus26}</div>
                        <div class=${seatStatus27} id="28">28<br><br>${seatStatus27}</div>
                        <div class=${seatStatus28} id="29">29<br><br>${seatStatus28}</div>
                        <div class=${seatStatus29} id="30">30<br><br>${seatStatus29}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
	$('.이용가능').on('click',function(){
	    var seatNo = $(this).attr('id');
	    console.log(seatNo);
	    
	    location.href='/ki_selectTime.go?seatNo='+seatNo;
	});
</script>
</html>