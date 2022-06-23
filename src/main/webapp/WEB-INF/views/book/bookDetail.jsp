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
</style>
</head>
<body>

  <div>로고</div>
        <nav>
            <ul>
                <li>
                    000 님 반갑습니다.
                </li>
                <li>
                    로그아웃
                </li>
                <li>
                    마이페이지
                </li>
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
                   <td id="brw_b_id">${dto.b_id}</td>
                   <td>${dto.b_status}</td>
                   <c:if test="${dto.b_status eq '대출가능'}">
					<td id="brw"><button id="brwBtn" onclick="bookbrw()">대출신청</button></td>
                   <td></td>
                   </c:if>
                   <c:if test="${dto.b_status eq '대출중'}"> 
                     <td></td>  
                   <td id="bookreserve"><button  onclick="bookreserve()">예약신청</button></td>
                 	 </c:if> 
                </tr>
            </thead>
        </table>
        <input type="button" value="돌아가기" onclick=/>


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

function bookbrw() {
	$.ajax({
		type:'get',
		url:'bookbrw.ajax',
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

$("#brw").on("click",function(){
	$("#brw").hide();
	alert("대출신청이 완료되었습니다");
});


$("#bookreserve").on("click",function(){
	$("#bookreserve").hide();
	alert("예약이 완료되었습니다");
});

  /* $(function(){
	$("bookreserve").click(function(){
		if($("#bookreserve").css("display") != "none"){
			$("#bookreserve").hide();
		}
	});
});   */





</script>
</html>