<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>이전대출내역(회원)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/bookList.css">
<link rel="icon" href="resources/img/favicon.png">
<style>
	
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="container">
            <!-- TOP -->
            <div class="top">
                <span>
                    <nav>
                        <ul>
                            <li>${sessionScope.loginId}님 반갑습니다.</li>
                            <li>로그아웃</li>
                            <li>마이페이지</li>
                        </ul>
                    </nav>
                </span>
            </div>
            <!--MIDDLE-->
            <div class="middle">
                
                <div class="middle-left">

                        <table>
                            <thead>
                                 <tr>
                                    <th>마이페이지</th>
                                </tr>
                                <tr>
                                    <th><a href="/brwHistory">도서내역</a></th>
                                </tr>
                                <tr>
                                    <th><a href="/claimList">건의사항</a></th>
                                </tr>
                                <tr>
                                    <th>회원정보</th>
                                </tr>
                            </thead>
                        </table>

                </div>
                <div class="middle-right">
                    <div class="middle-right-1">

                            <table>
                                <thead>
                                    <tr>
                                        <th><a href="/brwHistory">대출내역</a></th>
                                        <th><a href="/brwList">이전대출내역</a></th>
                                        <th><a href="/reserve">예약내역</a></th>
                                    </tr>
                                </thead>
                            </table>

                    </div>
                    <div class="middle-right-2">

                            <table>
                                <thead id="head">
                                    <tr>
                                        <th>대출번호</th>
                                        <th>도서제목</th>
                                        <th>대출일</th>
                                        <th>반납예정일</th>
                                        <th>대출상태</th>
                                        <th>도서연장</th>                                
                                        <th>연장여부</th>
                                    </tr>
                                    
                                    <c:forEach items="${history}" var="brwdto">
                                    
                                    	<tr>

                                    		<td id="extension_id">${brwdto.brw_id}</td>
                                    		<td>
                                    			<a href="bookDetail.do?b_id=${brwdto.b_id}">${brwdto.b_title}</a>
                                    		</td>
                                    		<td>${brwdto.brw_date}</td>
                                    		<td>${brwdto.return_date}</td>
                                    		<td>${brwdto.brw_status}</td>
                                    		<td id="extension_Whether">
                                    		
                                  			<c:choose>
                                  				<c:when test="${brwdto.renew eq 'Y'}">
	                                    			<button class="extensionBtn" 
	                                    				onclick="updateExtension(this)"
	                                    				whetherValue ="${brwdto.brw_id}">
	                                    				<a href="brwHistory">연장</a>
	                                    			</button>
	                                    		</c:when>
                                    		</c:choose>
                                    		
                                    		</td>
                                    		<td id="extensionChk">
	                                    		
	                                    		<c:choose>
													<c:when test="${brwdto.renew eq 'false'}">
														N
	                                    			</c:when>
	                                    			<c:when test="${brwdto.renew eq 'true'}">
														Y
	                                    			</c:when>
	                                    		</c:choose>
                                    		</td>
                                    		

                                    	<tr>
                                    	
                                    	</c:forEach>
                                                               

                                    
                                </thead>
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


function updateExtension(whethe_id) {
	var whetherValue = $(whethe_id).attr("whetherValue")
 	console.log(whetherValue);
	
	$.ajax({
		type:'get',
		url:'reserveBtn.ajax',
		data:{
			brw_id:whetherValue
		},
		dataType:'JSON',
		success:function(data) {
			console.log(data);
			location.reload(true);
		},
		error:function(e) {
			console.log(e);
		}
	});
	
}



$(".extensionBtn").on("click",function(){
	   $(this).hide();
	   alert("예약신청이 완료되었습니다");
});





</script>
</html>



