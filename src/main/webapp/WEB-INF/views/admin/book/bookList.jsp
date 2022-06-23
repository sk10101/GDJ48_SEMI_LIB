<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/admin.css">

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 

<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<style></style>
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
    
		  	게시물 갯수
		<select id="pagePerNum"> <!-- pagePerNum 을 ajax로 controller로 보내서 이에 따라 게시물 수 바꿔줄 것임 -->
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
		</select>
    
        <div class="content">
            <button class="btn_bookAdd" onclick="location.href='bookAdd.go' ">도서추가</button>
            <table>
                <thead>
                	<tr>
                		<td>ID</td>
                		<td>제목</td>
                		<td>저자</td>
                		<td>출판사</td>
                		<td>도서상태</td>
                		<td>등록일</td>
                	</tr>
                </thead>
                <tbody id="bookList">
                    
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
            </table>
            <div class="search">
                <input type="text" placeholder="도서검색"/>
                <button class="btn_bookSearch" onclick="#"></button>
            </div>
        </div>
    </section>
</body>
<script>
var currPage = 1;

listCall(currPage);

//게시물 갯수 선택 요소에 이벤트 걸어줌 - 갯수 변경 -> change 이벤트
$('#pagePerNum').on('change',function(){ // pagePerNum 에 change가 일어나게 되면
	console.log("currPage : " +currPage);	
	
	// 페이지당 보여줄 수 변경 시 계산된 페이지 적용이 안된다. (플러그인의 문제)
	// 페이지당 보여줄 수 변경 시 기존 페이징 요소를 없애고 다시 만들어 준다.
	$("#pagination").twbsPagination('destroy');
	listCall(currPage); // listCall 함수 호출
	
});

function listCall(page){
	
	var pagePerNum = $('#pagePerNum').val();
	console.log("param page : "+page);
	$.ajax({
		type:'GET',
		url:'bookList.ajax',
		data:{
			cnt : pagePerNum, //5,10,15,20
			page : page // 현재페이지(이동한 페이지)
		},
		dataType:'json',
		success:function(data){
			console.log(data);
			drawList(data.bookList);
			currPage = data.currPage;
			
			// 불러오기가 성공되면 플러그인을 이용해 페이징 처리
			$("#pagination").twbsPagination({
				startPage:data.currPage,
				totalPages:data.pages,
				visiblePages: 5,
				onPageClick:function(e,page){
					console.log(page);
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

function drawList(bookList){
	var content = '';
	bookList.forEach(function(item){
		console.log(item);
		content += '<tr>';
		content += '<td>'+item.b_id+'</td>';
		content += ' <td><a href="bookDetail.do?b_id= '+item.b_id+' "> '+item.b_title+'</a></td>';
		content += '<td>'+item.writer+'</td>';
		content += '<td>'+item.publisher+'</td>';
		content += '<td>'+item.b_status+'</td>';
		content += '<td>'+String(item.b_date)+'</td>';
	});
	$('#bookList').empty();
	$('#bookList').append(content); //tbody에 뿌려줌
}

</script>
</html>