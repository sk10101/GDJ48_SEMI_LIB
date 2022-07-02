<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/notice.css">
<link rel="icon" href="resources/img/favicon.png">
<style>
	
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
    <div class="body">
	    <div class="title">
	    	<h3>공지사항</h3>
	    </div>
	    <div class="btn-area">
	    <c:choose>
			<c:when test="${sessionScope.loginId eq null || sessionScope.mb_class eq '일반회원'}">
			</c:when>
			<c:when test="${sessionScope.loginId ne null and sessionScope.mb_class eq '관리자'}">
			    <input class="adminBtn" type="button" value="삭제" onclick="noticeDelete()" />
			    <button class="adminBtn" id="notice_write" onclick="location.href='noticeWrite.go'">공지사항 작성</button><br/>
			</c:when>
			<c:otherwise>
			</c:otherwise>
	    </c:choose>
	    </div>
	    <div class="noticeTable-area">
		    <table id="notice_table">
		    	<thead>
			         <tr>
			         	<c:choose>
			         		<c:when test="${sessionScope.loginId ne null and sessionScope.mb_class eq '관리자'}">
				                 <th><input type="checkbox" id="all" /></th>
			         		</c:when>
			         		<c:otherwise>
							</c:otherwise>
			         	</c:choose>
		                 <th>번호</th>
		                 <th>제목</th>
		                 <th>날짜</th>
		             </tr>
		    	 </thead>
		    	<tbody id="noticeList">
		    	
		    	</tbody>
		     </table>
			 <div class="container">
				 <nav aria-label="Page navigation" style="text-align:center">
						 <ul class="pagination" id="pagination" >
						 </ul>					
				 </nav>
			 </div>	
			 <!-- 아래 페이징 처리 해야됨-->
	      	 <div class="noticeSearchOption">
			     <select class="selectBtn" id="pagePerNum">
			         <option value="5">5</option>
					 <option value="10">10</option>
					 <option value="15" selected="selected">15</option>
					 <option value="20">20</option>
			     </select>
				 <select class="selectBtn" id="option" name="option">
		      	 	 <option value="제목">제목</option>
		      	 </select>
		         <input class="noticeSearchBlock" type="search" id="word" value="" name="word" placeholder="제목을 입력하세요"/>
		         <input class="noticeSearchDo" type="button" onclick="searchList(currPage)" id="searchBtn" value="검색"/>
	         </div>
       </div>
    </div>
</body>
<script>
	var word = $('#word').val();
	var option = $('#option').val();

	//체크박스 전체 선택시 모두선택 / 헤제
	$('#all').click(function() {
	    var $chk = $('input[type="checkbox"]');
	    //console.log($chk);
	
	    if($(this).is(":checked")) {
		$chk.prop("checked",true); 
	    } else {
		$chk.prop("checked",false);
	    }
	});
	
	$('input[type="checkbox"]').click(function() {
	  // console.log($(this).val());
	});
	
	
	// 체크박스에 체크한 글들만 삭제하는 기능
	function noticeDelete() {
		
		var noticeArray = [];
		
		$('input[type="checkbox"]:checked').each(function() {
			noticeArray.push($(this).val());
			
			console.log(noticeArray);
			
		});
		
		$.ajax({
			type: 'POST',
			url: '/noticeDelete.ajax',
			data : {
				noticedeleteList:noticeArray
				
				},
			dataType: 'JSON',
			success: function(data){
				console.log(data);
				location.href='/noticeList';
			},
			error: function(e) {
				console.log(e);
			}
			
		});
			
	}	
	
	var currPage = 1;
	listCall(currPage);
	
	// select 의 option 변경
	$('#pagePerNum').on('change',function(){
		var word = $('#word').val();
		console.log(currPage);
		console.log(word);
		// 페이지 당 보여줄 게시글 수 변경시에 기존 페이징 요소를 없애고 다시 만들어 준다. (다시 처음부터 그리기)
		$("#pagination").twbsPagination('destroy');
		// 검색어가 들어갔을 때와 아닐때를 구분
		if(word==null || word==""){
			listCall(currPage);
		} else {
			searchList(currPage)
		}
		
	});
	
	// 검색 버튼 클릭했을 때 한 번 초기화
	$('#searchBtn').on('click',function(){	
		$("#pagination").twbsPagination('destroy');
		searchList(currPage);
	});
	
	function listCall(page) {
		var pagePerNum = $('#pagePerNum').val();
		console.log("param page : " + page);
		
		$.ajax({
			type:'GET',
			url:'noticeList.ajax',
			data:{
				cnt : pagePerNum,
				page : page,
			},
			dataType:'JSON',
			success:function(data){
				console.log(data);
				drawList(data.noticeList);
				currPage = data.currPage;
				// 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
				$("#pagination").twbsPagination({
					startPage: data.currPage, // 시작 페이지
					totalPages: data.pages, // 총 페이지 수(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
					visiblePages: 5, // 한 번에 보여줄 페이지 수 ( ex)[1],[2],[3],[4],[5] ...)
					// 페이지 클릭했을 때
					onPageClick: function(e, page) {
						console.log("클릭한 페이지 : "+page); // 사용자가 클릭한 페이지
						console.log("입력한 검색어 : "+word);
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
	
	
	function drawList(noticeList) {
		var mb_id = "${sessionScope.loginId}";
		var mb_class = "${sessionScope.mb_class}";
		console.log(mb_class);
		var content = '';
		var date = new Date();
		noticeList.forEach(function(item){
			//console.log(item.status);
			content += '	<tr nID="' + item.notice_id + '">';
			if(mb_class == "관리자" && mb_id != null) {
				content += '		<td class="noticeCol"><input type="checkbox" id="chk" value="'+item.notice_id+'"/></td>';
			} else {
				
			}
			content += '		<td class="noticeCol" id="noticeID">'+item.notice_id+'</td>';
			content += '		<td><a href="noticeDetail.do?notice_id='+item.notice_id+'">'+item.notice_title+'</a></td>';
			content += '		<td class="noticeCol">'+item.notice_date+'</td>';
			content += '	</tr>';
		});
		// 혹시 모를 상황을 대비해 깨끗하게 비워두고 쌓는다. (append 는 있는 것에 계속해서 이어 붙이는 기능이기 때문)
		$("#noticeList").empty();
		$("#noticeList").append(content);
	}
	
	
	// 페이지 변경할 때 검색어를 저장하기위한 시도
	/*
	$('.page-item active > a.page-link').on('click',function(){
		console.log("페이지가 변경됐습니다.")
		if(sessionStorage.getItem("word")!=null) {
			$(this).text() = currPage;
			searchList(currPage);
		}
	});
	*/
	
	
	// 새로고침하면 세션에 저장된 검색어와 검색옵션 값을 비운다.
	/*
	function sessionClear() {
		    window.onbeforereload = function (e) {
		    	sessionStorage.removeItem("word");
		    	sessionStorage.removeItem("option");
		    };
		}
	*/
	
	// 검색 결과 출력
	function searchList(page) {
		word = $('#word').val();
		option = $('#option').val();
		var pagePerNum = $('#pagePerNum').val();
		
		// 검색어 저장
		/*
		sessionStorage.setItem("word",word);
		sessionStorage.setItem("option",option);
		*/
		
		$.ajax({
			type: 'GET',
			url: 'noticeList.ajax',
			data:{
				cnt : pagePerNum,
				page : page,
				word : word,
				option : option
			},
			dataType:'JSON',
			success: function(data){
				// 테이블 초기화
				$("#noticeList").empty();
				drawList(data.noticeList);
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
	
	// 삭제 버튼 기능구현 (동적으로 생성한 버튼은 javascript 로 구현)
	function clickEvt(btn) {
		var notice_id = $(btn).parent().parent().attr("cID");
		console.log($(btn));
			location.href='/noticeDel.do?notice_id=' + notice_id;
	}
	
	/* 삭제 기능 다른 방법
	$(document).ready(function() {
		$("#notice_table").on('click', '.delBtn', function() {
			console.log($(this));
			console.log($(this).parent().parent().attr("no"));
			var notice_id = $(this).parent().parent().attr("no");
			location.href='/noticeDel.do?notice_id='+notice_id;
		});
	});
	*/
	
	// 메세지를 받았을 때 이를 처리한다.
	var msg = "${msg}"
	if (msg != "") {
		alert(msg);
	}
</script>
</html>