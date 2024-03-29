<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>검색리스트</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="icon" href="resources/img/favicon.png">
<style>

</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>

    <div id="myPage_menu">
        <h3>마이페이지</h3>
        <hr/>
        <a href="bookList.go">도서내역</a><br/>
        <br/>
        <a href="claimList">건의사항</a><br/>
        <br/>
        <a href="myUpdateDetail.go">회원정보</a>
    </div>
    <button id="claim_write" onclick="location.href='claimWrite.go'">건의사항 작성</button><br/>
    <table id="claim_table">
    	<thead>
	         <tr>
	             <th>No</th>
	             <th>제목</th>
	             <th>처리상태</th>
	             <th>작성일</th>
	             <th>삭제</th>
	         </tr>
    	</thead>
    	<tbody id="searchList">
    	</tbody>
	    	<tr>
				<td colspan="5" id="paging">
					<div class="container">
						<nav aria-label="Page navigation" style="text-align:center">
								<ul class="pagination" id="pagination" >
								</ul>					
						</nav>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan ="5" id="paging">
				        <select id="pagePerNum" name="cnt">
							<option value="5">5</option>
							<option value="10">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
						</select>
				       	<select name="option">
				       		<option>제목</option>
				       		<option>처리상태</option>
				       	</select>
			        	<input type="search" placeholder="검색" name="keyword"/>
			        	<input type="submit" id="btnSearch" value="검색"/>
				</td>
			</tr>
        </table>
</body>
<script>
	/*
	$(document).on('click','#btnSearch', function(e){
		e.preventDefault();
		var url = "${claimList}";
	});
	*/
	
	// select 의 option 변경
	$('#pagePerNum').on('change',function(){
		console.log(currPage);
		// 페이지 당 보여줄 게시글 수 변경시에 기존 페이징 요소를 없애고 다시 만들어 준다. (다시 처음부터 그리기)
		$("#pagination").twbsPagination('destroy');
		listCall(currPage);
	})
	
	function listCall(page,keyword,option) {
		
		var pagePerNum = $('#pagePerNum').val();
		console.log("param page : " + page);
		
		$.ajax({
			type:'GET',
			url:'searchList.ajax',
			data:{
				cnt : pagePerNum,
				page : page
			},
			dataType:'JSON',
			success:function(data){
				console.log(data);
				drawList(data.searchList);
				currPage = data.currPage;
				// 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
				$("#pagination").twbsPagination({
					startPage: data.currPage, // 시작 페이지
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
	
	
	function drawList(searchList) {
		var content = '';
		var date = new Date();
		searchList.forEach(function(item){
			// console.log(item);
			content += '<tr no="' + item.claim_id + '">';
			content += '<td id="claimID">'+item.claim_id+'</td>';
			content += '<td><a href="claimDetail?claim_id='+item.claim_id+'">'+item.claim_title+'</a></td>';
			content += '<td class="claimStatus" no="'+item.status+'">'+item.status+'</td>';
			content += '<td>'+item.claim_date+'</td>';
			content += '<td class="delete">';
			content += '<button class="delBtn" onclick="clickEvt(this)">삭제</button>';
			content += '</td>'
			content += '</tr>';
			
		});
		
		// 혹시 모를 상황을 대비해 깨끗하게 비워두고 쌓는다. (append 는 있는 것에 계속해서 이어 붙이는 기능이기 때문)
		$("#claimList").empty();
		$("#claimList").append(content);
		
		
		
	}
	
	var currPage = 1;
	listCall(currPage);
	
	// 삭제 버튼 기능구현 (동적으로 생성한 버튼은 javascript 로 구현)
	function clickEvt(btn) {
		var claim_id = $(btn).parent().parent().attr("no");
		console.log($(btn));
		location.href='/claimDel.do?claim_id=' + claim_id;
	}
		
		/* 삭제 기능 다른 방법
	$(document).ready(function() {
		$("#claim_table").on('click', '.delBtn', function() {
			console.log($(this));
			console.log($(this).parent().parent().attr("no"));
			var claim_id = $(this).parent().parent().attr("no");
			location.href='/claimDel.do?claim_id='+claim_id;
		});
	});
		*/
</script>
</html>