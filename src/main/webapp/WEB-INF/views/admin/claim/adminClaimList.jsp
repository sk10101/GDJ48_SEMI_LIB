<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 / 건의사항</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<style>
	#header {
            width: 100%;
            height: 150px;
            border: 2px solid #999;
            background-color: #b0f592;
        }

    #myPage_menu {
        width: 125px;
        height: 750px;
        background-color: #b0f592;
        text-align: center;
        float: left;
        border: 2px solid #999;
        margin-top: 15px;
        margin-right: 10px;
    }
    a[href='#'] {
        margin-bottom: 15px;
    }

    #claim_table {
        width: 800px;
        text-align: center;
    }

    #claim_table, th, td {
        border: 2px solid #999;
        border-collapse: collapse;
        padding: 5px;
    }

    table th {
        padding: 15px;
        text-align:center;
    }

    #claim_write {
        margin-top: 15px;
        margin-bottom: 10px;
    }

    #claim_no {
        width: 15px;
    }

    #subject {
        text-align: left;
        padding-left: 5px;
    }
    
    input[type='search'] {
        margin-top: 20px;
        width: 150px;
        height: 35px;
        border-radius: 5px;
        }
</style>
</head>
<body>
	<div id="header">
            <a href="#">도서관 로고 들어갈 위치</a>
    </div>
    <div id="myPage_menu">
        <h3>관리자 페이지</h3>
        <hr/>
        <a href="#">회원관리</a><br/>
        <br/>
        <a href="#">도서관리</a><br/>
        <br/>
        <a href="claimList">건의사항</a><br/>
        <br/>
        <a href="#">블랙리스트</a><br/>
        <br/>
        <a href="#">이용정지내역</a>
    </div>
    <table id="claim_table">
    	<thead>
	         <tr>
	             <th>No</th>
	             <th>제목</th>
	             <th>작성자</th>
	             <th>처리상태</th>
	             <th>작성일</th>
	             <th>삭제</th>
	         </tr>
    	</thead>
    	<tbody id="claimList">
    	
    	</tbody>
	    	<tr>
				<td colspan="6" id="paging">
					<div class="container">
						<nav aria-label="Page navigation" style="text-align:center">
								<ul class="pagination" id="pagination" >
								</ul>					
						</nav>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan ="6" id="paging">
				        <select id="pagePerNum">
							<option value="5">5</option>
							<option value="10">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
						</select>
				       	<select id="option" name="option">
				       		<option value="제목">제목</option>
				       		<option value="작성자">작성자</option>
				       		<option value="처리상태">처리상태</option>
				       	</select>
			        	<input id="word" type="search" placeholder="검색" name="word" value=""/>
			        	<input id="searchBtn" type="button" onclick="searchList(currPage)" value="검색" style="width: 60px; margin-top: 10px;"/>
				</td>
			</tr>
        </table>
</body>
<script>
	
	
	var currPage = 1;
	listCall(currPage);
	
	// select 의 option 변경
	$('#pagePerNum').on('change',function(){
		var word = $('#word').val();
		console.log(currPage);
		console.log(word);
		// 페이지 당 보여줄 게시글 수 변경시에 기존 페이징 요소를 없애고 다시 만들어 준다. (다시 처음부터 그리기)
		$("#pagination").twbsPagination('destroy');
		if(word==null || word==""){
			listCall(currPage);
		} else {
			searchList(currPage)
		}
		
	})
	
	
	
	function listCall(page) {
		
		var pagePerNum = $('#pagePerNum').val();
		console.log("param page : " + page);
		
		$.ajax({
			type:'GET',
			url:'claimList.ajax',
			data:{
				cnt : pagePerNum,
				page : page,
			},
			dataType:'JSON',
			success:function(data){
				console.log(data);
				drawList(data.claimList);
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
	
	
	function drawList(claimList) {
		var content = '';
		var date = new Date();
		claimList.forEach(function(item){
			//console.log(item.status);
			content += '	<tr cID="' + item.claim_id + '" cSt="' + item.status + '">';
			content += '		<td id="claimID">'+item.claim_id+'</td>';
			content += '		<td><a href="claimDetail?claim_id='+item.claim_id+'">'+item.claim_title+'</a></td>';
			content += '		<td class="mbID">'+item.mb_id+'</td>';
			content += '		<td class="claimStatus">'+item.status+'</td>';
			content += '		<td>'+item.claim_date+'</td>';
			content += '		<td class="delete" style="height:39px">';
			if(item.status=="미처리") {
				content += '			<button class="delBtn" onclick="clickEvt(this)">삭제</button>';
			}
			content += '		</td>';
			content += '	</tr>';
		});
		// 혹시 모를 상황을 대비해 깨끗하게 비워두고 쌓는다. (append 는 있는 것에 계속해서 이어 붙이는 기능이기 때문)
		$("#claimList").empty();
		$("#claimList").append(content);
	}
	
	/*
	$('#searchBtn').on('click',function(){
		console.log(currPage);
		// 페이지 당 보여줄 게시글 수 변경시에 기존 페이징 요소를 없애고 다시 만들어 준다. (다시 처음부터 그리기)
		$("#pagination").twbsPagination('destroy');
		searchList(currPage);
	})
	*/
	
	
	// 검색 결과 출력
	function searchList(page) {
		var word = $('#word').val();
		var option = $('#option').val();
		var pagePerNum = $('#pagePerNum').val();
		
		$.ajax({
			type: 'GET',
			url: 'claimList.ajax',
			data:{
				cnt : pagePerNum,
				page : page,
				word : word,
				option : option
			},
			dataType:'JSON',
			success: function(data){
				// 테이블 초기화
				$("#claimList").empty();
				drawList(data.claimList);
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
		})
	}
	
	// 삭제 버튼 기능구현 (동적으로 생성한 버튼은 javascript 로 구현)
	function clickEvt(btn) {
		var claim_id = $(btn).parent().parent().attr("cID");
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