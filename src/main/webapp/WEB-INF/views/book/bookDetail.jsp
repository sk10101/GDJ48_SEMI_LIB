<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>bookDetail</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="icon" href="resources/img/favicon.png">
<style>
</style>
</head>
<body>
   <div id="header">
      <jsp:include page="../commons/header.jsp"/>
   </div>
   <hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
        
        <nav>
            <ul>
                <li loginId="${sessionScope.loginId}">${sessionScope.loginId}님 반갑습니다.</li>
                <li><a href="member/logout.do">로그아웃</a></li>
                <li><a href="/brwHistory">마이페이지</a></li>
            </ul>
        </nav>
        <div class="image">
            
        </div>

       <table>
            <thead id="head">
               <tr>
                  <td>
                  <c:forEach items="${list}" var="path">
                  <p><img src="/image/${path.newFileName}" height="200"/>
               </c:forEach>
               </td>
               </tr>      
               <tr>
                   <td>책제목</td>
                   <td>${detail.b_title}</td>
               </tr>
               <tr>
                   <td>저자</td>
                   <td>${detail.writer}</td>
               </tr>
               <tr>
                   <td>출판사</td>
                   <td>${detail.publisher}</td>
               </tr>
               <tr>
                   <td>발행년도</td>
                   <td>${detail.issue}</td>
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

                   <td>
                   <c:forEach items="${detail}" var="dto">
                      <c:choose>
                            <c:when test="${dto.b_status eq '대출중' && dto.reserve_able eq true}">
                               <button class="bookreason"  onclick="bookreason(this)" loginId="${sessionScope.loginId}" bookId="${dto.b_id}" >예약신청</button>
                            </c:when>
                            <c:when test="${dto.b_status eq '대출불가' && dto.reserve_able eq false}">
                               <input type="hidden">
                            </c:when>
                            <c:when test="${dto.b_status eq '대출신청' && dto.reserve_able eq false}">
                        <input type="hidden">
                            </c:when>
                  </c:choose>
               </c:forEach>
                   
                   <td>
                      <c:choose>
                            <c:when test="${detail.b_status eq '대출중'}">
                               <button class="bookreason"  onclick="bookreason(this)" loginId="${sessionScope.loginId}" bookId="${dto.b_id}" >예약신청</button>
                            </c:when>
                            <c:when test="${detail.b_status eq '대출불가'}">
                               <input type="hidden">
                            </c:when>
                            <c:when test="${detail.b_status eq '대출신청'}">
                        <input type="hidden">
                            </c:when>
                  </c:choose>
                   </td>
                </tr>
            </thead>
        </table>
        <input type="button" value="돌아가기" onclick="back()"/>


    </body>
</html>
</body>
<script>
var msg = "${msg}"
   if (msg != "") {
      alert(msg);
   }


 
   function bookbrw(brwId) {
      var bookID = $(brwId).attr("bookID");
       console.log(bookID);
       var loginId = $(brwId).attr("loginId");
       console.log(loginId);
      
      $.ajax({
         type:'get',
         url:'bookDetailBrw.ajax',
         data:{
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
           // alert(data.msg);
         },
         error:function(e) {
            
         }
      });

   }

   $(".brwBtn").on("click",function(){
         $(this).hide();
         alert("대출신청이 완료되었습니다");
   });
      
/* function bookreason(this){
	     alert(msg);
   }; */
   
   $(".bookreason").on("click",function(){
       $(this).hide();
       alert("예약신청이 완료되었습니다");
 });
       
       if(loginId == null || loginId == ''){
         console.log("비회원");
         alert("도서예약은 로그인 후 이용가능한 서비스입니다.");
         location.href="/login/login";
      }else {
         
         $.ajax({
                  type:'get',
                  url:'bookreason.ajax',
                  data:{
                     b_id : bookID,
                     loginId : loginId

                  },
                  dataType:'JSON',
                  success:function(data) {
                     alert(data);
                  },
                  error:function(e) {
                     
                  }
               });
         
      }
               
   }

$(".brwBtn").on("click",function(){

     //$(this).hide();

  
   
});
      
   $(".bookreason").on("click",function(){
      alert("예약신청이 완료되었습니다.");
   });
   
 function back() {
    
    var referrer = document.referrer;
    console.log(referrer);
    location.href = referrer;
  
  //histiory.go(-1);
 }

</script>
</html>