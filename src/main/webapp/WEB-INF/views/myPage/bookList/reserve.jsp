<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/bookList.css">
<style>
	table {
		width: 100%;
	}
	table,th,td {
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px;	
		}
</style>
</head>
<body>

	<div class="container">
            <!-- TOP -->
            <div class="top">
                    <nav>

                        <ul> 

                        <ul>
                            <li>${sessionScope.loginId}님 반갑습니다.</li>
                            <li>로그아웃</li>
                            <li>마이페이지</li>
                        </ul>
                    </nav>
            </div>
            <!--MIDDLE-->
            <div class="middle">
                
                <div class="middle-left">
                    
                        <table>
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
                        
                            <table id="main-container">
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
															loginId="${sessionScope.loginId}">대출신청
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
														idValue="${brwdto.reserve_id}">취소
												</button>
											</td>
                                    	<tr>
                                    	
                                   	 </c:forEach>
                                    </tbody>
                            </table>
                        
                    </div>  
                    
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
				consloe.log(data)
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