<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>대출내역(회원)</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/myBook.css"/>
<link rel="icon" href="resources/img/favicon.png">
<style>
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="body">
	    <div class="myPageTab" id="myPage_menu">
	        <h3>마이페이지</h3>
	        <hr style="border:1px solid #333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a class="tabSelect" href="/brwHistory">도서내역</a><br/>
	        <br/>
	        <a href="claimList">건의사항</a><br/>
	        <br/>
	        <a href="myUpdateDetail.go">회원정보</a>
	    </div>
	    <div class="section">
	    	<div class="brwSelect-area">
		    	<a href="/brwHistory">대출내역</a>
	            <a class="brwSelect" href="/brwList">이전대출내역</a>
	            <a href="/reserve">예약내역</a>
            </div>    
            <div class="table-area">
				<table class="borrow_table">
			    	<thead>
				         <tr>
				            <th>대출번호</th>
							<th>도서제목</th>
							<th>대출일</th>
							<th>반납일</th>
							<th>상태</th>
				         </tr>
			    	</thead>
			    	<tbody id="brwBookList">
			    	
			    	</tbody>
		        </table>
				<div class="container">
					<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination" id="pagination" >
							</ul>					
					</nav>
				</div>
				<div class="searchOption">
			        <select class="selectBtn" id="pagePerNum">
						<option value="5">5</option>
						<option value="10" selected="selected">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>
			       	<select class="selectBtn" id="option" name="option">
			       		<option value="제목">제목</option>
			       		<option value="상태">상태</option>
			       	</select>
		        	<input class="searchBlock" id="word" type="search" placeholder="검색" name="word" value=""/>
		        	<input class="searchDo" id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
	        	</div>
	        </div>	
        </div>
	</div>
</body>       
</body>
<script>
var msg = "${msg}"
if (msg != "") {
	alert(msg);
}


var mb_id = "${sessionScope.loginId}";
var currPage = 1;
listCall(currPage);

// select 의 option 변경
$('#pagePerNum').on('change',function(){
	//var word = $('#word').val();
	console.log(currPage);
	//console.log(word);
	// 페이지 당 보여줄 게시글 수 변경시에 기존 페이징 요소를 없애고 다시 만들어 준다. (다시 처음부터 그리기)
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
		console.log("param page : " + page);
		
		$.ajax({
			type:'GET',
			url:'myPageBrwList.ajax',
			data:{
				cnt : pagePerNum,
				page : page,
				mb_id : mb_id
			},
			dataType:'JSON',
			success:function(data){
				console.log(data);
				drawList(data.brwBookList);
				currPage = data.currPage;
				// 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
				$("#pagination").twbsPagination({
					startPage: data.currPage, // 시작 페이지
					totalPages: data.pages, // 총 페이지 수(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
					visiblePages: 5, // 한 번에 보여줄 페이지 수 ( ex)[1],[2],[3],[4],[5] ...)
					// 페이지 클릭했을 때
					onPageClick: function(e, page) {
						console.log("클릭한 페이지 : "+page); // 사용자가 클릭한 페이지
						//console.log("입력한 검색어 : "+word);
						currPage = page;
						
						if(word==null){
							listCall(page);
						} else {
							searchList(page);
						}
					}
				});
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}


	function drawList(brwBookList) {
		var content = '';
		var date = new Date();
		brwBookList.forEach(function(item){
			//console.log(item.status);
			console.log(item.brw_id);
			content += '	<tr>';
			content += '		<td>'+item.brw_id+'</td>';
			content += '		<td><a href="bookDetail.do?b_id='+item.b_id+'">'+item.b_title+'</a></td>';
			content += '		<td>'+item.brw_date+'</td>';
			content += '		<td>'+item.return_date+'</td>';
			content += '		<td>'+item.brw_status+'</td>';
			content += '	</tr>';
		});
		// 혹시 모를 상황을 대비해 깨끗하게 비워두고 쌓는다. (append 는 있는 것에 계속해서 이어 붙이는 기능이기 때문)
		$("#brwBookList").empty();
		$("#brwBookList").append(content);
	}

	//검색 결과 출력
	function searchList(page) {
		var word = $('#word').val();
		var option = $('#option').val();
		var pagePerNum = $('#pagePerNum').val();
		
		
		$.ajax({
			type: 'GET',
			url: 'myPageBrwList.ajax',
			data:{
				cnt : pagePerNum,
				page : page,
				word : word,
				option : option,
				mb_id : mb_id
			},
			dataType:'JSON',
			success: function(data){
				// 테이블 초기화
				$("#brwBookList").empty();
				drawList(data.brwBookList);
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
				});
			},
			error:function(e){
				console.log(e);
			}
		})
	}


/* <tr>
<td>${brwdto.brw_id}</td>
<td>
	<a href="bookDetail.do?b_id=${brwdto.b_id}">${brwdto.b_title}</a>
</td>
<td>${brwdto.brw_date}</td>
<td>${brwdto.return_date}</td>
<td>${brwdto.return_finish}</td>
<td>${brwdto.brw_status}</td>
<tr>
 */

</script>
</html>