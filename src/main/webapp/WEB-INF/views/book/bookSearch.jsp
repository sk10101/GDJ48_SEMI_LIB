<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/book.css">

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 

<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>

<style></style>
</head>
<body>
    <!-- header start -->
    <header>
        <div class="header-wrap">
            <div class="logo">
                <a href="/"><img src="../resources/img/logo.png" class="logo"></a>
            </div>
            <nav>
                <ul class="navi">
                    <li>***님 환영합니다.</li>
                    <li><a href="#">로그아웃</a></li>
                    <li><a href="#">마이페이지</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <!-- header end -->
    <section>
        <form class="search" action="bookSearch.go" method="get">
            <select name="bookSearchOption">
                <option value="all" selected>전체</option>
                <option value="b_title">제목</option>
                <option value="writer">저자</option>
                <option value="publisher">출판사</option>
            </select>
            <input type="text" name="bookSearchWord" placeholder="도서 검색">
            <input type="submit" class="btn_search" value="검색">
        </form>
        
        <div class="content"> 
        	<div class="content-pagination">
				 게시물 갯수
				 <select id="pagePerNum"> <!-- pagePerNum 을 ajax로 controller로 보내서 이에 따라 게시물 수 바꿔줄 것임 -->
				 	<option value="5">5</option>
				 	<option value="10">10</option>
				 	<option value="15">15</option>
				 	<option value="20">20</option>
				 </select> 
			</div>       
	        <table>
	            <thead>
	            	<tr>
		                <td>책표지</td>
		                <td>제목</td>
		                <td>저자</td>
		                <td>출판사</td>
		                <td>도서상태</td>
		                <td>예약가능여부</td>           		
	            	</tr>
	            </thead>
	            <tbody id="searchList">
					
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
        </div>
<<<<<<< HEAD
<<<<<<< HEAD
=======
        <tasble>
        <table>
=======

        

        <table>

>>>>>>> de7789817d72ed16e56bc3d046f0a0516b7140d7
            <thead>
                <th>책표지</th>
                <th>제목</th>
                <th>저자</th>
                <th>출판사</th>
                <th>도서상태</th>
                <th>예약가능여부</th>
            </thead>
            <tbody>
				<c:forEach items="${dto}" var="dto">
					<tr>
						<td>${dto.b_id}</td>
						<td><a href="bookDetail.do?b_id=${dto.b_id}">${dto.b_title}</a></td>
						<td>${dto.writer}</td>
						<td>${dto.publisher}</td>
						<td>${dto.b_status}</td>
						<td>${dto.publisher}</td>
					</tr>
				</c:forEach>
            </tbody>
        </table>
>>>>>>> origin/master
    </section>
</body>
<script>
var currPage = 1;

listCall(currPage);

$('#pagePerNum').on('change',function(){ // pagePerNum 에 change가 일어나게 되면
	console.log("currPage : " +currPage);	
	
	// 페이지당 보여줄 수 변경 시 계산된 페이지 적용이 안된다. (플러그인의 문제)
	// 페이지당 보여줄 수 변경 시 기존 페이징 요소를 없애고 다시 만들어 준다.
	$("#pagination").twbsPagination('destroy');
	listCall(currPage); // listCall 함수 호출
	
});


function listCall(page) {
	
	var pagePerNum = $('#pagePerNum').val();
	console.log("param page :" +page);
	$.ajax({
		type:'get',
		url:'searchList.ajax',
		data:{
			cnt : pagePerNum,
			page : page
		},
		dataType:'json',
		success:function(data){
			console.log('테이블 그리기');
			console.log(data.searchList.searchList);
			drawList(data.searchList.searchList);
			currPage = data.currPage;
			
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

function drawList(searchList){
	var content = '';
	console.log(searchList);
	searchList.forEach(function(item) {
		console.log(item);
		content += '<tr>';
		content += '<td>'+item.b_id+'</td>';
		content += '<td>'+item.b_title+'</td>';
		content += '<td>'+item.writer+'</td>';
		content += '</tr>';
	});
	$('#searchList').empty();
	$('#searchList').append(content);
}
/*
Array.from(parent.children).forEach(child => {
    console.log(child)
});
Array.from(selected_rows).forEach(item => console.log(item));
*/

</script>
</html>
