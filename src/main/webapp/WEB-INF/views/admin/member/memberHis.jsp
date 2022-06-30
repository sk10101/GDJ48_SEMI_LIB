<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
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
		            <td>대출번호</td>          
		            <td>도서제목</td>           
		            <td>대출일</td>           
		            <td>반납일</td>       
		            <td>연체여부</td>      
		        </tr>
		    </thead>
		    <tbody id="hisList">
		        
		    </tbody>
		    
		    <tr>
		 		<td colspan="5" id="paging">
		 			<!-- plugin 사용법 -->
		 			<div class="container">
		 				<nav aria-label="Page navigation" style="text-align:center">
		 					<ul class="pagination" id="pagination">
		 					</ul>
		 				</nav>
		 			</div>
		 		</td>
		 	</tr>
		 	<tr>
		 		<td colspan="5">
			 		<select id="pagePerNum">
					 	<option value="5">5</option>
					 	<option value="10" selected="selected">10</option>
					 	<option value="15">15</option>
					 	<option value="20">20</option>
					 </select>
					 <select id="option" name="option">
				       		<option value="도서제목">도서제목</option>
				       		<option value="연체여부">연체여부</option>
				       	</select>
					 <input id="word" type="search" placeholder="검색" name="word" value=""/>
			        <input id="searchBtn" type="button" onclick="searchList(currPage)" value="검색" style="width: 60px; margin-top: 10px;"/>
				  </td>
		 	</tr>
		</table>
	</section>
</body>
<script>

var mb_id=$('#mb_id').html();
console.log(mb_id);

var currPage=1;
listCall(currPage);

	$('#pagePerNum').on('change', function(){
		console.log("currPage : " + currPage);
		//페이지당 보여줄 수를 변경시 계산된 페이지 적용이 안된다. (플러그인의 문제)
		//페이지당 보여줄 수를 변경시 기존 페이징 요소를 없애고 다시 만들어 준다.
		$("#pagination").twbsPagination('destroy');
		// 검색어가 들어갔을 때와 아닐때를 구분
		if(word==null || word==""){
			listCall(currPage);
		} else {
			searchList(currPage)
		}
	});



function listCall(page) {
	
	var pagePerNum = $('#pagePerNum').val();
	console.log("param page : "+page);
	$.ajax({
		type:'get',
		url:'memberHis.ajax',
		data: {mb_id:mb_id, 
			cnt : pagePerNum,
			page : page},
		dataType:'json',
		success:function(data){
			console.log("테이블")
			drawList(data.hisList);
			currPage = data.currPage;
			
			//불러오기가 성공되면 플러그인을 이용해 페이징 처리
			$("#pagination").twbsPagination({
				startPage:data.currPage, //시작 페이지
				totalPages:data.pages, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
				visiblePages:5, //한 번에 보여줄 페이지 수 [1][2][3][4][5]
				onPageClick:function(e,page){
					//console.log(e); //클릭한 페이지와 관련된 이벤트 객체
					console.log(page); //사용자가 클릭한 페이지
					currPage = page;
					
					if(word==null){
						listCall(page);
					} else {
						searchList(page);
					}
				}
			});
			
		},
		error:function(error){
			console.log(error);
		}
	});
}

function drawList(hisList) {
	var content='';
	console.log("hisList");
	hisList.forEach(function(item){
		console.log(item);
		content += '<tr>';
		content += '<td>' +item.brw_id+ '</td>';
		content += '<td><a href="bookDetail.do?b_id='+item.b_id+' ">' +item.b_title+'</a></td>';
		content += '<td>' +item.brw_date+ '</td>';
		content += '<td>'+item.return_finish+'</td>';
		content += '<td class="delay">';
		if(item.return_finish > item.return_date) { //연체
			content += 'Y';
		}else{
			content += 'N';
		}
		content += '</td>';
		content += '</tr>';
	});
	
	$("#hisList").empty();
	$('#hisList').append(content);
}


function searchList(page) {
	var word = $('#word').val();
	var option = $('#option').val();
	var pagePerNum = $('#pagePerNum').val();
	console.log(word);
	
	$.ajax({
		type: 'GET',
		url: 'memberHis.ajax',
		data:{
			cnt : pagePerNum,
			page : page,
			mb_id : mb_id,
			option : option,
			word : word
		},
		dataType:'JSON',
		success: function(data){
			// 테이블 초기화
			$("#hisList").empty();
			drawList(data.hisList);
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
			});
		},
		error:function(e){
			console.log(e);
		}
	});
}

$(document).ready(function(){
	console.log($("#hisList").children().children("#delay").text());
});
       
</script>
</html>