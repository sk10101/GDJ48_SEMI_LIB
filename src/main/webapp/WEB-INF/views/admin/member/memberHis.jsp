<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>이전대출예약(관리자)</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
		<div class="section">
			<div class="secionTitle">
				<h3>회원 대출내역</h3>
			</div>
			<div class="brwSelect-area">
		    	<a href="/memberBrw.go?mb_id=${param.mb_id}">대출내역</a>
	            <a class="brwSelect" href="/memberHis.go?mb_id=${param.mb_id}">이전대출내역</a>
	            <a href="/memberReserve.go?mb_id=${param.mb_id}">예약내역</a>
	            &nbsp;&nbsp;회원 ID : ${param.mb_id}
            </div>
		    <table class="brw_table">
			    <thead>
			        <tr>
			            <th>대출번호</th>          
			            <th>도서제목</th>           
			            <th>대출일</th>           
			            <th>반납일</th>       
			            <th>연체여부</th>      
			        </tr>
			    </thead>
			    <tbody id="hisList">
			        
			    </tbody>
			</table>
 			<div class="container">
 				<nav aria-label="Page navigation" style="text-align:center">
 					<ul class="pagination" id="pagination">
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
			       		<option value="도서제목">도서제목</option>
			       		<option value="연체여부">연체여부</option>
			       	</select>
				 <input class="searchBlock" id="word" type="search" placeholder="검색" name="word" value=""/>
		        <input class="searchDo" id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
			</div>
		</div>		
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
		content += '<td class="brwTitleTd"><a href="bookDetail.do?b_id='+item.b_id+' ">' +item.b_title+'</a></td>';
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