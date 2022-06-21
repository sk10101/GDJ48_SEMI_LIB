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
                </tr>
                <tr>
                   <td>${dto.b_id}</td>
                   <td>${dto.b_status}</td>
                   <td><input type="button" value="대출신청" onclick="location.href='brw.do'"/></td>
                   <td><input type="button" value="예약신청"></td>
                </tr>
            </thead>
        </table>
        <input type="button" value="돌아가기" onclick=/>


    </body>
</html>


</body>
<script>



/* function bor() {
		var b_id = $('b_id')
	$.ajax({
		type:'get',
		url:'bor.ajax',
		data:{
			
		},
		dataType:'JSON',
		success:function(data) {
			console.log($('#b_id').val(data.dto.b_id););
			
		},
		error:function(e) {
			console.log(e);
		}
	});
	
} */

/* function bookDetail() {
	console.log("ajax 전송");
	
	$.ajax({
		type:"get",			//method 와 같다.
		url:"bookDetail.ajax",		//action과 같다.
		data:{},				//parameter
		dataType:"json",		//어떤 형태로 데이터를 주고 받나?
		success:function(data){
			console.log(data);
			$('#b_title').html(data.dto.b_title);
			$('#writer').html(data.dto.writer);
			$('#publisher').html(data.dto.publisher);
			$('#issue').html(data.dto.issue);
			
		},	
		error:function(e){
			console.log(e);
		}		
	});
	
}
 */



</script>
</html>