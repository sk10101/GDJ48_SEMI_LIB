<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>예약내역(회원)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/myBook.css"/>
<link rel="icon" href="resources/img/favicon.png">
<style>
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="body">
	    <div class="myPageTab" id="myPage_menu">
	        <h3>마이페이지</h3>
	        <hr style="border:1px solid #333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a class="tabSelect" href="/brwHistory">도서내역</a><br/>
	        <br/>
	        <a href="claimList">건의사항</a><br/>
	        <br/>
	        <a href="myUpdateDetail.go">회원정보</a>
	    </div>
	    <div class="section">
	    	<div class="brwSelect-area">
		    	<a href="/brwHistory">대출내역</a>
	            <a href="/brwList">이전대출내역</a>
	            <a class="brwSelect" href="/reserve">예약내역</a>
            </div>    
	    	<div class="table-area">
				<table class="borrow_table" id="main-container">
					<thead id="head">
						<tr>
							<th>예약번호</th>
							<th>도서제목</th>
							<th>신청기간</th>
							<th>예약종료 사유</th>                            
							<th>대출신청</th>
							<th>취소</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${reserve}" var="brwdto">
							<tr>
								<td class="bookReserve_id" >${brwdto.reserve_id}</td>
				                <td>
									<a href="bookDetail.do?b_id=${brwdto.b_id}">${brwdto.b_title}</a>
								</td>
								<td>${brwdto.reserve_date}</td>
								<td>${brwdto.reason}</td>
								<td id="brw">
									<c:choose>
										<c:when test="${brwdto.b_status eq '대출중'}">
											<input type="hidden">
										</c:when>
										
										<c:when test="${brwdto.b_status eq '대출가능'}">			
											<button class="brwBtn" onclick="bookbrw(this)"
											brwValue="${brwdto.reserve_id}"
											bookID="${brwdto.b_id}"
											loginId="${sessionScope.loginId}"><a href="reserve">대출신청</a>
											</button>
										</c:when>
										
										<c:when test="${brwdto.b_status eq '대출불가'}">
											<input type="hidden">
										</c:when>
									</c:choose>
								</td>
								<td id="del">
									<button class="delBtn" onclick="bookDel(this)"
									bookID="${brwdto.b_id}"
									idValue="${brwdto.reserve_id}"><a href="reserve">취소</a>
									</button>
								</td>
							</tr>
						</c:forEach>
				    </tbody>
				</table>
            </div>
        </div>
	</div>        
</body>
<script>
var msg = "${msg}"
if (msg != "") {
	alert(msg);
}

 	
	function bookDel(btn) {
		var idValue = $(btn).attr("idValue")
	 	console.log(idValue);
		var bookID = $(btn).attr("bookID");
	 	console.log(bookID);
		
		$.ajax({
			type:'get',
			url:'bookDel.ajax',
			data:{
				reserve_id:idValue,
				b_id : bookID
			},
			dataType:'JSON',
			success:function(data) {
				consloe.log(data);
			},
			error:function(e) {
				console.log(e);
			}
		});
		
	}
	
	function bookbrw(brwId) {
		var brwValue = $(brwId).attr("brwValue");
	 	console.log(brwValue);
		var bookID = $(brwId).attr("bookID");
	 	console.log(bookID);
	 	var loginId = $(brwId).attr("loginId");
	 	console.log(loginId);
		
		$.ajax({
			type:'get',
			url:'reserveBookbrw.ajax',
			data:{
				reserve_id : brwValue,
				b_id : bookID,
				loginId : loginId
			},
			dataType:'JSON',
			success:function(data) {
				
			},
			error:function(e) {
				console.log(e);
			}
		});
		
	}
	
	
	$(".brwBtn").on("click",function(){
		   $(this).hide();
		   alert("대출신청이 완료되었습니다");
	});
		
	$(".delBtn").on("click",function(){
		alert("예약이 취소 되었습니다.");
	});

</script>
</html>