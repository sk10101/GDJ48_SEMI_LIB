<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Date"%>
<% Date now = new Date(); 
	int hour = now.getHours();
	int minutes = now.getMinutes();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>키오스크시간선택</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/5415520417.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/kioskStyle.css">
<style></style>
</head>
<body>
	<a href="ki_seat.go">
        <i class="fa-solid fa-angles-left back"></i>
    </a>
    <a href="ki_logout.do">
        <i class="fa-solid fa-arrow-right-from-bracket logout"></i>
    </a>
    <div class="useSection">
        <div class="selectSeatNo">
            좌석번호<br>${seatNo}
        </div>
        <div class="nowTime" id="nowTime">
            <%=hour%>시 <%=minutes%>분 ~
        </div>
        <div class="selectTime">
            <div class="row" id="row1">
                <button id="30">30분</button>
                <button id="60">1시간</button>
                <button id="90">1시간 30분</button>
                <button id="120">2시간</button>
            </div>
            <div class="row" id="row2">
                <button id="150">2시간 30분</button>
                <button id="180">3시간</button>
                <button id="210">3시간 30분</button>
                <button id="240">4시간</button>
            </div>
        </div>
        <button id="btn-seatUse" onclick="seatUse()">좌석사용</button>
    </div>
</body>
<script>
		
	var useTime;	
	var seatNo = ${seatNo};
		
	$('.row button').on('click',function(){
		useTime = $(this).attr('id');
		console.log(useTime);
	});
	
	function seatUse(){
		
		console.log("좌석 번호:"+seatNo);
		console.log("최종 선택 시간: "+useTime);
		
		$.ajax({
			type:'get',
			url:'seatUse.ajax',
			data:{
				seatNo:seatNo,
				useTime:useTime},
			success:function(data){
				console.log(data);
				location.href='ki_mainSeatOut.go';
			},
			error:function(e){
				console.log(e);
			}
		});
		
	}
	
	
</script>
</html>