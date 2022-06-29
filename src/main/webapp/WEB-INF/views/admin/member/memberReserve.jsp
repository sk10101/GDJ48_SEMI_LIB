<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/admin.css">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 

<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>

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
		    <tbody id="reserveList">
		        
		    </tbody>
		    <tr>
			 		<td colspan="4" id="paging">
				 		<!-- plugin 사용법 -->
				 		<div class="container">
				 			<nav arial-label="page navigation" style="text-align:center">
				 				<ul class="pagination" id="pagination"></ul>
				 			</nav>
				 		</div>
			 		</td>
			 	</tr>
			 	<tr>
				 	<td colspan ="6" id="paging">
				        <select id="pagePerNum">
							<option value="5">5</option>
							<option value="10" selected="selected">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
						</select>
						<input id="word" type="search" placeholder="검색" name="word" value=""/>
			        	<input id="searchBtn" type="button" onclick="searchList(currPage)" value="검색" style="width: 60px; margin-top: 10px;"/>
					</td>
			 	</tr>
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

var currPage = 1;
listCall(currPage);

//게시물 갯수 선택 요소에 이벤트 걸어줌 - 갯수 변경 -> change 이벤트
$('#pagePerNum').on('change',function(){ //pagePerNum 에 change가 일어나게 되면
	var word = $('#word').val();
	console.log(word);
	console.log("currPage : " +currPage);		
	// 페이지당 보여줄 수 변경 시 계산된 페이지 적용이 안된다. (플러그인의 문제)
	// 페이지당 보여줄 수 변경 시 기존 페이징 요소를 없애고 다시 만들어 준다.
	$("#pagination").twbsPagination('destroy');
	if(word==null || word==""){
		listCall(currPage);
	} else {
		searchList(currPage)
	}
})

function listCall(page) {
	
	var pagePerNum = $('#pagePerNum').val();
	console.log("param page : "+page);
	
	$.ajax({
		type:'get',
		url:'memberReserve.ajax',
		data: {
			mb_id:mb_id,
			cnt : pagePerNum, //5,10,15,20
			page : page // 현재페이지(이동한 페이지)
			},
		dataType:'json',
		success:function(data){
			console.log("테이블")
			drawList(data.reserveList);
			currPage = data.currPage;
			
			// 불러오기가 성공되면 플러그인을 이용해 페이징 처리
			$("#pagination").twbsPagination({
				startPage:data.currPage,
				totalPages:data.pages,
				visiblePages: 5,
				onPageClick:function(e,page){
					console.log("클릭한 페이지 : "+page); // 사용자가 클릭한 페이지
					console.log("입력한 검색어 : "+word);
					currPage = page;
					
					if(word==null){
						listCall(page);
					} else {
						searchList(page);
					}
				}
			})
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
	$('#reserveList').empty();
	$('#reserveList').append(content);
}

function searchList(page){
	var word = $('#word').val();
	var pagePerNum = $('#pagePerNum').val();
	console.log(word);
	
	$.ajax({
		type: 'GET',
		url: 'memberReserve.ajax',
		data:{
			cnt : pagePerNum,
			page : page,
			word : word,
			mb_id : mb_id
		},
		dataType:'JSON',
		success: function(data){
			// 테이블 초기화
			$("#reserveList").empty();
			drawList(data.searchList);
			console.log(data);
			currPage = 1;
			// 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
			$("#pagination").twbsPagination({
				startPage: 1, // 시작 페이지
				totalPages: data.pages, // 총 페이지 수(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
				visiblePages: 5, // 한 번에 보여줄 페이지 수 ( ex)[1],[2],[3],[4],[5] ...)
				onPageClick: function(e, page) {
					console.log(page); // 사용자가 클릭한 페이지
					currPage = page;
					listCall(page);
				}
			})
		},
		error:function(e){
			console.log(e);
		}
	});
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