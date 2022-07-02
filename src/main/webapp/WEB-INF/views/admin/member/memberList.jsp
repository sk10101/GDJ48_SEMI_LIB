<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/adminMember.css">
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
	    	<div class="memberClassBtn-area">
				 <a class="memberClassBtnChk" href="/memberList.go">일반회원</a>
			     <a class="memberClassBtn" href="/adminList.go">관리자</a>
	     	</div>
	     	<div class="table-area">
			    <table class="bbs">
			        <thead>
			            <tr>
			                <th>회원ID</th>          
			                <th>회원이름</th>           
			                <th>회원상태</th>                
			            </tr>
			        </thead>
			        <tbody id="memberList">
						
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
						<option value="10">10</option>
						<option value="15" selected="selected">15</option>
						<option value="20">20</option>
					</select>
					<select class="selectBtn" id="option" name="option">
						<option value="회원ID">회원 ID</option>
						<option value="회원이름">회원이름</option>
						<option value="회원상태">회원상태</option>
					</select>
					<input class="searchBlock" id="word" type="search" placeholder="회원 검색" name="word" value=""/>
					<input class="searchDo" id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
				</div>
			</div>
		</div>
	</div>
</body>
<script>

	var msg ="${msg}";
	
	if (msg != "") {
		alert(msg);
	}


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
	
	function listCall(page){	
		
		var pagePerNum = $('#pagePerNum').val();
		console.log("param page : "+page);
		$.ajax({
			type:'GET',
			url:'memberPaging.ajax',
			data:{
				cnt : pagePerNum,
				page : page
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				drawList(data.memberList);
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
			error:function(e){
				console.log(e);
			}
		});
	}



	function drawList(memberList){
		var content = '';
		memberList.forEach(function(dto){
			console.log(dto);
				content += '<tr>';
				content += '<td><a href="memberDetail.do?mb_id='+dto.mb_id+'">'+dto.mb_id+'</a></td>';
				content += '<td>'+dto.name+'</td>';
			if(dto.mb_status != null){
				content += '<td>'+dto.mb_status+'</td>';
			}else{
				content += '<td></td>';
			}
				content += '</tr>';
				content += '</tr>';
			
		});
		$('#memberList').empty();
		$('#memberList').append(content); //tbody에 뿌려줌
	}

	function searchList(page) {
		var word = $('#word').val();
		var option = $('#option').val();
		var pagePerNum = $('#pagePerNum').val();
		
		$.ajax({
			type: 'GET',
			url: 'memberPaging.ajax',
			data:{
				cnt : pagePerNum,
				page : page,
				word : word,
				option : option
			},
			dataType:'JSON',
			success: function(data){
				// 테이블 초기화
				$("#memberList").empty();
				drawList(data.memberList);
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
</script>
</html>