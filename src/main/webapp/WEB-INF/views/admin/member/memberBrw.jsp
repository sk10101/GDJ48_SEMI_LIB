<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/admin.css">
<style>
</style>
</head>
<body>
    <header>
        <div class="header-wrap">
            <div class="logo">
                <a href="/"><img src="../resources/img/logo.png" class="logo"></a>
            </div>
            <nav>
                <ul class="navi">
                    <li><a href="#">로그아웃</a></li>
                    <li><a href="#">관리자페이지</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <aside id="menu">
        <h1>관리자페이지</h1>
        <hr/>
        <ul class="admin_menu">
            <li><a href="#">회원관리</a></li>
            <li><a href="#">도서관리</a></li>
            <li><a href="#">건의사항</a></li>
            <li><a href="#">블랙리스트</a></li>
            <li><a href="#">이용정지내역</a></li>
        </ul>
    </aside>
	<section>
		<h3>대출내역</h3>
		<ul class="book_menu">
			<li><a href="/memberBrw.go?mb_id=${param.mb_id}">대출내역</a></li>
			<li><a href="/memberHis.go?mb_id=${param.mb_id}">이전 대출내역</a></li>
			<li><a href=" /memberReserve.go?mb_id=${param.mb_id}">예약내역</a></li>
			<li>회원 ID : <div id="mb_id">${param.mb_id}</div></li>
		</ul>
	    <table class="brw_table">
	        <thead>
	            <tr>
	                <td>대출번호</td>          
	                <td>도서제목</td>           
	                <td>대출일</td>           
	                <td>반납예정일</td>       
	                <td>대출상태</td>      
	                <td>연장여부</td>
	            </tr>
	        </thead>
	        <tbody id="list">

			</tbody>
	    </table>
	</section>
</body>
<script>

var msg ="${msg}";

if (msg != "") {
	alert(msg);
}


var mb_id=$('#mb_id').html();
console.log(mb_id);

listCall();

function listCall() {
	$.ajax({
		type:'get',
		url:'memberBrw.ajax',
		data: {
			mb_id:mb_id
		},
		dataType:'json',
		success:function(data){
			console.log("테이블")
			drawList(data.list);
			console.log(data.list);
		},
		error:function(error){
			console.log(error);
		}
	});
}

function drawList(brwList) {
	var content='';
	console.log("brwList");
	brwList.forEach(function(item){
		console.log(item);
		content += '<tr>';
		content += '<td>' +item.brw_id+ '</td>';
		content += '<td><a href="bookDetail.do?b_id='+item.b_id+' ">' +item.b_title+'</a></td>';
		content += '<td>' +item.brw_date+ '</td>';
		content += '<td>'+item.return_date+'</td>';
		content += '<td>'+item.brw_status+'</td>';
		content += '<td>';
			if(item.renew==true) {
				content += 'Y';
			}else{
				content += 'N';
			}
		content += '</td>';
		content += '</tr>';
	});
	$('#list').append(content);
}
</script>
</html>