<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>예약내역(관리자)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<<<<<<< HEAD
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
=======
>>>>>>> origin/master
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/adminMemberBrw.css"/>
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
	        <h3>관리자 페이지</h3>
	        <hr style="height: 1px !important; background:#333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a class="tabSelect" href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
<<<<<<< HEAD
	<section>
		<h3>대출내역</h3>
		<ul class="book_menu">
			<li><a href="/memberBrw.go?mb_id=${param.mb_id}">대출내역</a></li>
			<li><a href="/memberHis.go?mb_id=${param.mb_id}">이전 대출내역</a></li>
			<li><a href=" /memberReserve.go?mb_id=${param.mb_id}">예약내역</a></li>
			<li>회원 ID : ${param.mb_id}</li>
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
						<select id="option">
							<option value="b_title">도서제목</option>
							<option value="reason">예약종료사유</option>
						</select>
						<input id="word" type="search" placeholder="검색" name="word" value=""/>
			        	<input id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
					</td>
			 	</tr>
		</table>
	</section>
=======
		<div class="section">
			<div class="secionTitle">
				<h3>회원 예약내역</h3>
			</div>
			<div class="brwSelect-area">
		    	<a href="/memberBrw.go?mb_id=${param.mb_id}">대출내역</a>
	            <a href="/memberHis.go?mb_id=${param.mb_id}">이전대출내역</a>
	            <a class="brwSelect" href="/memberReserve.go?mb_id=${param.mb_id}">예약내역</a>
	            &nbsp;&nbsp;회원 ID : ${param.mb_id}
            </div>
            <div class="hidden-area">
				회원 ID : <div id="mb_id">${param.mb_id}</div>
			</div>
		    <table class="brw_table">
			    <thead>
			        <tr>
			            <th class="col1">예약번호</th>          
			            <th class="col2">도서제목</th>           
			            <th class="col3">신청기간</th>           
			            <th class="col4">예약종료사유</th>       
			            <th class="col5">취소</th>      
			        </tr>
			    </thead>
			    <tbody id="reserveList">
			        
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
					<option value="10" selected="selected">10</option>
					<option value="15">15</option>
					<option value="20">20</option>
				</select>
				<select class="selectBtn" id="option">
					<option value="b_title">도서제목</option>
					<option value="reason">예약종료사유</option>
				</select>
				<input class="searchBlock" id="word" type="search" placeholder="검색" name="word" value=""/>
	        	<input class="searchDo" id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
			</div>			
		</div>
>>>>>>> origin/master
	</div>
</body>
<script>

var msg ="${msg}";

if (msg != "") {
	alert(msg);
}

let query = window.location.search; //url query 부분 가져오기 
var param = new URLSearchParams(query); // url query의 파라미터 부분 가져오기
var mb_id=param.get("mb_id");
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
		content += '<td class="brwTitleTd"><a href="bookDetail.do?b_id='+item.b_id+' ">' +item.b_title+'</a></td>';
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
<<<<<<< HEAD
				content += ' <button onclick="cancel(this)" id="' +item.reserve_id+ '" b_id=" ' +item.b_id+ ' ">취소</button> ';
=======
				content += ' <button class="delBtn" onclick="cancel(this)" id="' +item.reserve_id+ '">취소</button> ';
>>>>>>> origin/master
			}
		content += '</td>';
		content += '</tr>';
	});
	$('#reserveList').empty();
	$('#reserveList').append(content);
}

function searchList(page){
	var word = $('#word').val();
	var option = $('#option').val();
	var pagePerNum = $('#pagePerNum').val();
	console.log(word);
	
	$.ajax({
		type: 'GET',
		url: 'memberReserve.ajax',
		data:{
			cnt : pagePerNum,
			page : page,
			word : word,
			option:option,
			mb_id : mb_id
		},
		dataType:'JSON',
		success: function(data){
			// 테이블 초기화
			$("#reserveList").empty();
			drawList(data.reserveList);
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
	var b_id = $(btn).attr("b_id");
	console.log(b_id);
	$.ajax({
		type:'get',
		url:'reserveCancel.ajax',
		data:{
			reserve_id:id,
			b_id:b_id
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