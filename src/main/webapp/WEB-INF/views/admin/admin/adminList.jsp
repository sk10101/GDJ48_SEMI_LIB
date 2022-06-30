<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>관리자리스트</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
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
	        <a class="tabSelect" href="#">회원관리</a><br/>
	        <br/>
	        <a href="#">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="#">블랙리스트</a><br/>
	        <br/>
	        <a href="#">이용정지내역</a>
	    </div>
	    <div class="section">
    	<a href="/memberList.go">일반회원</a>
        <a href="/adminList.go">관리자</a>
    <table class="bbs">
        <thead>
            <tr>
                <td>관리자ID</td>          
                <td>관리자 이름</td>           
                <td>전화번호</td>                
            </tr>
        </thead>
        <tbody id="adminList">
			
		</tbody>
		
		<tr>
		 		<td colspan="5" id="paging">
		 			<!-- plugin 사용법 -->
		 			<div class="container">
		 				<nav aria-label="Page navigation">
		 					<ul class="pagination" id="pagination">
		 					</ul>
		 				</nav>
		 			</div>
		 		</td>
		 	</tr>
		 	<tr>
		 		<td colspan="3">
			 		<select id="pagePerNum">
					 	<option value="5">5</option>
					 	<option value="10" selected="selected">10</option>
					 	<option value="15">15</option>
					 	<option value="20">20</option>
					 </select>
					 <select id="option" name="option">
			       		<option value="관리자ID">관리자 ID</option>
			       		<option value="관리자이름">관리자 이름</option>
			       		<option value="전화번호">전화번호</option>
			       	</select>
				     <input id="word" type="search" placeholder="관리자 검색" name="word" value=""/>
				     <input id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
				 </td>
		 	</tr>
    </table>
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
			listCall(currPage);
		});
		
	function listCall(page){	
		
		var pagePerNum = $('#pagePerNum').val();
		console.log("param page : "+page);
		$.ajax({
			type:'GET',
			url:'adminPaging.ajax',
			data:{
				cnt : pagePerNum,
				page : page
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				drawList(data.adminList);
				currPage = data.currPage;
				
				//불러오기가 성공되면 플러그인을 이용해 페이징 처리
				$("#pagination").twbsPagination({
					startPage:data.currPage, //시작 페이지
					totalPages:data.pages, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
					visiblePages:5, //한 번에 보여줄 페이지 수 [1][2][3][4][5]
					onPageClick:function(e,page){
						//console.log(e); //클릭한 페이지와 관련된 이벤트 객체
						console.log(page); //사용자가 클릭한 페이지
						//currPage = page;
						listCall(page);
					}
				});
				
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}



	function drawList(adminList){
		var content = '';
		adminList.forEach(function(dto){
			console.log(dto);
				content += '<tr>';
				content += '<td><a href="memberDetail.do?mb_id='+dto.mb_id+'">'+dto.mb_id+'</a></td>';
				content += '<td>'+dto.name+'</td>';
				content += '<td>'+dto.phone+'</td>';
				content += '</tr>';
		});
		$('#adminList').empty();
		$('#adminList').append(content); //tbody에 뿌려줌
	}
	
	
	function searchList(page) {
		var word = $('#word').val();
		var option = $('#option').val();
		var pagePerNum = $('#pagePerNum').val();
		
		$.ajax({
			type: 'GET',
			url: 'adminPaging.ajax',
			data:{
				cnt : pagePerNum,
				page : page,
				word : word,
				option : option
			},
			dataType:'JSON',
			success: function(data){
				// 테이블 초기화
				$("#adminList").empty();
				drawList(data.adminList);
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