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
                    <li>***님 환영합니다.</li>
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
		            <td>예약번호</td>          
		            <td>도서제목</td>           
		            <td>신청기간</td>           
		            <td>예약종료사유</td>       
		            <td>취소</td>      
		        </tr>
		    </thead>
		    <tbody id="list">
		        
		    </tbody>
		</table>
	</section>
</body>
<script>
var mb_id=$('#mb_id').html();
console.log(mb_id);

listCall();

function listCall() {
	$.ajax({
		type:'get',
		url:'memberReserve.ajax',
		data: {mb_id:mb_id},
		dataType:'json',
		success:function(data){
			console.log("테이블")
			drawList(data.list);
		},
		error:function(error){
			console.log(error);
		}
	});
}

function drawList(reserveList) {
	var content='';
	console.log("reserveList");
	reserveList.forEach(function(item){
		console.log(item);
		content += '<tr>';
		content += '<td>' +item.reserve_id+ '</td>';
		content += '<td><a href="bookDetail.do?b_id='+item.b_id+' ">' +item.b_title+'</a></td>';
		content += '<td>' + item.reserve_date;
			var date = item.reserve_date;
			var d = new Date(date);
			d.setDate(d.getDate() + 22);
			var date = d.toISOString().substring(0,10);
			console.log(date);			
		content += '<br/>' +date; 
		content += '</td>';
		content += '<td>';
			if(item.reason==null) {
				content += ' ';
			}else{
				content += item.reason;
			}
		content += '</td>';
		content += '<td>';
			if (item.reason!=null){
				content += ' ';
			}else{
				content += ' <button onclick="cancel(this)" id="' +item.reserve_id+ '">취소</button> ';
			}
		content += '</td>';
		content += '</tr>';
	});
	$('#list').append(content);
}
  
function cancel(btn) {
	var id = $(btn).attr("id");
	console.log(id);
	
	$.ajax({
		type:'get',
		url:'reserveCancel.ajax',
		data:{
			reserve_id:id
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			location.reload(true);
		},
		error:function(e){
			console.log(e);
		}
	});
}

</script>
</html>