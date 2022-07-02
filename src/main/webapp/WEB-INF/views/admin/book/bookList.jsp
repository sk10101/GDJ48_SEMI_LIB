<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>도서리스트</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/adminBook.css">
<link rel="icon" href="resources/img/favicon.png">
<style></style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="body">
    	<div class="myPageTab" id="myPage_menu">
	        <h3>관리자 페이지</h3>
	        <hr style="height: 1px !important; background:#333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a class="tabSelect" href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div> 
	    <div class="section"> 
	    	<div class="upBtn-area">
	            <button class="btn_bookAdd" onclick="location.href='bookAdd.go' ">도서추가</button>
	            <button class="btn_bookAdd" onclick="bookDel()">도서삭제</button>
	        </div>
	            <table class="book_table">
	                <thead>
	                	<tr>
	                		<th id="chk">체크</th>
	                		<th class="bookIdTh">ID</th>
	                		<th>제목</th>
	                		<th>저자</th>
	                		<th>출판사</th>
	                		<th>도서상태</th>
	                		<th class="bookDateTh">등록일</th>
	                	</tr>
	                </thead>
	                <tbody id="bookList">
	                    
	                </tbody>
	            </table>
				<div class="container">
					<nav aria-label="page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>
				</div>
				<div class="searchOption">
					<select class="selectBtn" id="pagePerNum">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15" selected="selected">15</option>
						<option value="20">20</option>
					</select>
					<select class="selectBtn" id="option" name="option">
						<option value="제목">제목</option>
						<option value="저자">저자</option>
						<option value="출판사">출판사</option>
						<option value="도서상태">도서상태</option>
					</select>
					<input class="searchBlock" id="word" type="search" placeholder="검색" name="word" value=""/>
					<input class="searchDo" id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
				</div>
		</div>
	</div>
</body>
<script>
var msg = "${msg}"
if (msg != "") {
	alert(msg);
}

var mb_id = "${sessionScope.loginId}";
var mb_class = "${sessionScope.mb_class}";
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

// 검색 버튼 클릭했을 때 한 번 초기화
	$('#searchBtn').on('click',function(){	
		$("#pagination").twbsPagination('destroy');
		searchList(currPage);
	});

function listCall(page){
	
	var pagePerNum = $('#pagePerNum').val();
	console.log("param page : "+page);
	
	$.ajax({
		type:'GET',
		url:'bookList.ajax',
		data:{
			cnt : pagePerNum, //5,10,15,20
			page : page, // 현재페이지(이동한 페이지)
			mb_id : mb_id,
			mb_class : mb_class
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
		content += '<td><input type="checkbox" value=" '+item.b_id +' "></td>';
		content += '<td>'+item.b_id+'</td>';
		content += '<td class="brwTitleTd"><a href="AdbookDetail.do?b_id= '+item.b_id+' "> '+item.b_title+'</a></td>';
		content += '<td>'+item.writer+'</td>';
		content += '<td>'+item.publisher+'</td>';
		content += '<td>'+item.b_status+'</td>';
		content += '<td>'+String(item.b_date)+'</td>';
	});
	$('#bookList').empty();
	$('#bookList').append(content); //tbody에 뿌려줌
}

function searchList(page){
	var word = $('#word').val();
	var option = $('#option').val();
	var pagePerNum = $('#pagePerNum').val();
	console.log(word);
	
	$.ajax({
		type: 'GET',
		url: 'bookList.ajax',
		data:{
			cnt : pagePerNum,
			page : page,
			word : word,
			option : option,
			mb_id : mb_id,
			mb_class : mb_class
		},
		dataType:'JSON',
		success: function(data){
			// 테이블 초기화
			$("#bookList").empty();
			drawList(data.bookList);
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
					searchList(page);
				}
			})
		},
		error:function(e){
			console.log(e);
		}
	});	
}

function bookDel() {
	var chkArr = [];
	var checkbox = $('input[type="checkbox"]:checked');
	//var no = $(this).val();
	//console.log(no);
	
	checkbox.each(function(b_id,item) {
		
		chkArr.push($(this).val());

	});
	
	console.log(chkArr);
	
	$.ajax({
		type:'post',
		url:'bookHide.ajax',
		data : {
			hideList:chkArr
		},
		dataType:'json',
		success: function(data){
			console.log(data);
			alert(data.msg);
			location.reload(true);
		},
		error:function(e){
			console.log(e);
		}
	});
	
	
}


</script>
</html>