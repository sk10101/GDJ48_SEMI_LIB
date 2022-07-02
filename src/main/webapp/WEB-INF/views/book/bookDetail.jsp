<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>도서 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="icon" href="resources/img/favicon.png">
<link rel="stylesheet" href="resources/css/bookSearch.css"/>
<style>
</style>
</head>
<body>
	<div id="header">
	   <jsp:include page="../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="detailSection">
		<div class="bookDetail-area">
			<table class="bookDetailTable">
				<thead id="head">
					<tr>
						<td rowspan="5" class="col1">
							<c:forEach items="${list}" var="path">
								<img src="/image/${path.newFileName}" height="200"/>
							</c:forEach>
						</td>
					</tr>      
					<tr>
					    <th class="col2">책제목</th>
					    <td class="col3">${detail.b_title}</td>
					</tr>
					<tr>
					    <th>저자</th>
					    <td class="col3">${detail.writer}</td>
					</tr>
					<tr>
					    <th>출판사</th>
					    <td class="col3">${detail.publisher}</td>
					</tr>
					<tr>
					    <th>발행년도</th>
					    <td class="col3">${detail.issue}</td>
					</tr>
			    </thead>
			</table>
			<table class="bookStatusBtn">
			    <thead id="botom">
			        <tr>
			            <th>책 ID</th>
			            <th>도서상태</th>
			            <th>대출신청</th>
			            <th>예약신청</th>
			        </tr>
			        <tr>
			        	<td id="brw_b_id">${detail.b_id}</td>
						<td id="b_status">${detail.b_status}</td>
						<td>
			       			<c:choose>
								<c:when test="${detail.b_status eq '대출가능'}">
									<button class="brwBtn" onclick="bookbrw(this)" loginId="${sessionScope.loginId}" bookID="${detail.b_id}">대출신청</button>
								</c:when>
								<c:when test="${detail.b_status eq '대출불가'}">
									<input type="hidden">
								</c:when> 
								<c:when test="${detail.b_status eq '대출중'}">
									<input type="hidden">
								</c:when>
							</c:choose>
			   			</td>
						<td>
							<c:choose>
								<c:when test="${detail.b_status eq '대출중' && detail.reserve_able eq true}">
									<button class="bookreason"  onclick="bookreason(this)" loginId="${sessionScope.loginId}" bookId="${detail.b_id}" >예약신청</button>
								</c:when>
								<c:when test="${detail.b_status eq '대출불가' && detail.reserve_able eq false}">
									<input type="hidden">
								</c:when>
								<c:when test="${detail.b_status eq '대출신청' && detail.reserve_able eq false}">
									<input type="hidden">
								</c:when>
							</c:choose>
			           </td>
			        </tr>
			    </thead>
			</table>
			<input class="backBtn" type="button" value="돌아가기" onclick="back()"/>
		</div>
	</div>
</body>
</html>
<script>

console.log(aaa);
var msg = "${msg}"
   if (msg != "") {
      alert(msg);
   }

function bookbrw(brwId) { 
      var bookID = $(brwId).attr("bookID");
      console.log(bookID);
      var loginId = $(brwId).attr("loginId");
      console.log(loginId);
      
      if(loginId == null || loginId == ''){
         console.log("비회원");
         alert("도서대출은 로그인 후 이용가능한 서비스입니다.");
         location.href="/login/login";
      } else {
         $.ajax({
               type:'get',
               url:'bookDetailBrw.ajax',
               data:{
                  b_id : bookID,
                  loginId : loginId
               },
               dataType:'JSON',
               success:function(data) {
                  alert(data.msg);
                  location.reload(true);
               },
               error:function(e) {
                  console.log(e);
     
                  //location.reload(true);
               }
            });
      }
      
      
}      
   
   
function bookreason(brwId) {
       var bookID = $(brwId).attr("bookID");
       console.log(bookID);
       var loginId = $(brwId).attr("loginId");
       console.log(loginId);
       var msg = "";
       
       if(loginId == null || loginId == ''){
           console.log("비회원");
           alert("도서대출은 로그인 후 이용가능한 서비스입니다.");
           location.href="/login/login";
        } else {
        	
        	$.ajax({
                type:'get',
                url:'bookreason.ajax',
                data:{
                   b_id : bookID,
                   loginId : loginId,
       			msg : msg
                },
                dataType:'JSON',
                success:function(data) {
                  alert(data.msg);
                  location.reload(true);
                },
                error:function(e) {
                   
                }
             });
        	
        }

   }


function back() {
    
    var referrer = document.referrer;
    console.log(referrer);
    location.href = referrer;
  
  //histiory.go(-1);
 }

</script>
</html>