	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>bookDetail</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
table {
		width: 100%;
	}
	table,th,td {
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px;	
	}
	

.logo {
    font-size: 30px;
    font-weight: bold;
    width: 200px;
    height: 120px;
    text-align: center;
    /* line-height: 120px; */
    margin-bottom: 70px;
}
</style>
</head>
<body>

   		<div class="logo">
            <a href="#"><img src="../resources/img/logo.png" class="logo"/><br/></a>
        </div>
        <nav>
            <ul>
                <li>${sessionScope.loginId}님 반갑습니다.</li>
                <li><a href="member/logout.do">로그아웃</a></li>
                <li><a href="/brwHistory">마이페이지</a></li>
            </ul>
        </nav>
        <div class="image">
            
        </div>

       <table>
            <thead id="head">
                <tr>
                    <td>책제목</td>
                    <td>${dto.b_title}</td>
                </tr>
                <tr>
                    <td>저자</td>
                    <td>${dto.writer}</td>
                </tr>
                <tr>
                    <td>출판사</td>
                    <td>${dto.publisher}</td>
                </tr>
                <tr>
                    <td>발행년도</td>
                    <td>${dto.issue}</td>
                </tr>
            </thead>
        </table>

        <table>
            <thead id="botom">
                <tr>
                    <td>책ID</td>
                    <td>도서상태</td>
                    <td>대출신청</td>
                    <td>예약신청</td>
                   
                <tr>
				<c:forEach items="${detail}" var="dto">
                   <td id="brw_b_id">${dto.b_id}</td>
                   <td id="b_status">${dto.b_status}</td>
                   
                   <td id="brw">
                   <c:choose>
						<c:when test="${brwdto.b_status eq '대출불가'}">
						<input type="hidden">
						</c:when>
						<c:when test="${brwdto.b_status eq '대출가능'}">                        				
						<button class="brwBtn" onclick="bookBrwDetail(this)" bookID="${brwdto.b_id}" >대출신청</button>								
						</c:when>
						<c:when test="${brwdto.b_status eq '대출불가'}">
						<input type="hidden">
						</c:when>
					</c:choose>
					</td>
				</c:forEach>
					
					<%-- <td id="reason">
					<c:choose>
						<c:when test="${brwdto.b_status eq '대출중'}">                        				
							<button class="reasonBtn" onclick="bookreason(this)">예약신청</button>
						</c:when>
					</c:choose>
					</td> --%>
					
                </tr>
            </thead>
        </table>
        <a href="/bookSearch.do"><input type="button" value="돌아가기" onclick=/></a>


    </body>
</html>
</body>
<script>


/* $("#brwBtn").on("click",function(e){
	location.href='/bookbrw.do?b_id=' + $("#brw_b_id").text();
}); */

/* if($("#claimStatus").text() != "대출중") {
	$("#brw").hide();
} */

	


function bookBrwDetail(brwId) {
	var bookID = $(brwId).attr("bookID");
 	console.log(bookID);
	
	$.ajax({
		type:'get',
		url:'bookBrwDetail.ajax',
		data:{
			b_id : bookID
		},
		dataType:'JSON',
		success:function(data) {
			
		},
		error:function(e) {
			console.log(e);
		}
	});
	
}



function bookreason() {
	$.ajax({
		type:'get',
		url:'bookreason.ajax',
		data:{
			b_id:$("#brw_b_id").text()
		},
		dataType:'JSON',
		success:function(data) {
			
		},
		error:function(e) {
			console.log(e);
		}
	});
	
} 



function bookreserve() {
	$.ajax({
		type:'get',
		url:'bookreserve.ajax',
		data:{
			b_id:$("#brw_b_id").text()
		},
		dataType:'JSON',
		success:function(data) {
			
		},
		error:function(e) {
			console.log(e);
		}
	});
	
} 

/* $("#brw").on("click",function(){
	$("#brw").hide();
	alert("대출신청이 완료되었습니다");
});


$("#bookreserve").on("click",function(){
	$("#bookreserve").hide();
	alert("예약이 완료되었습니다");
}); */

  /* $(function(){
	$("bookreserve").click(function(){
		if($("#bookreserve").css("display") != "none"){
			$("#bookreserve").hide();
		}
	});
});   */




	/* $("#reasonBtn").on("click",function(){
	   $("#reasonBtn").hide();
	   alert("예약이 완료되었습니다");
	}); */

</script>
</html>