<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="../resources/css/bookList.css"> -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>



<style>
	table {
		width: 100%;
	}
	table,th,td {
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px;
		}
	#a1234 {
		height: 30px;
	}
</style>
</head>
<body>
	
	<div class="container">
            <!-- TOP -->
            <div class="top">
                <span>
                    <nav>
                        <ul>
							<li>${sessionScope.loginId}(${sessionScope.mb_class})님, 반갑습니다.<a href="/member/logout.do">로그아웃</a></li>
                            <li>로그아웃</li>
                            <li>마이페이지</li>
                        </ul>
                    </nav> 
                </span>
            </div>
            <!--MIDDLE-->
            <div class="middle">
                
                <div class="middle-left">
                    <span>
                        <table>
                            <thead>
                                <tr>
                                    <th>마이페이지</th>
                                </tr>
                                <tr>
                                    <th><a href="/brwHistory">도서내역</a></th>
                                </tr>
                                <tr>
                                    <th><a href="/claimList">건의사항</a></th>
                                </tr>
                                <tr>
                                    <th>회원정보</th>
                                </tr>
                            </thead>
                        </table>
                    </span>
                </div>
                <div class="middle-right">
                    <div class="middle-right-1">
                        <span>
                            <table>
                                <thead>
                                    <tr>
                                       <th><a href="/brwHistory">대출내역</a></th>
                                        <th><a href="/brwList">이전대출내역</a></th>
                                        <th><a href="/reserve">예약내역</a></th>
                                    </tr>
                                </thead>
                            </table>
                        </span>
                        
                    </div>
                 </div>    
            </div>
        </div>



<table class="">

    	<thead>
	         <tr>
	            <th>대출번호</th>
				<th>도서제목</th>
				<th>대출일</th>
				<th>반납일</th>
				<th>연체여부</th>
	         </tr>
    	</thead>
    	<tbody id="list">
    	
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
				        <select id="pagePerNum">
							<option value="5">5</option>
							<option value="10" selected="selected">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
						</select>
				       	<select id="option" name="option">
				       		<option value="제목">제목</option>
				       		<option value="처리상태">처리상태</option>
				       	</select>
			        	<input id="word" type="search" placeholder="검색" name="word" value=""/>
			        	<input id="searchBtn" type="button" onclick="searchList(currPage)" value="검색" style="width: 60px; margin-top: 10px;"/>
				</td>
			</tr>
        </table>
</body>

      	
        
</body>
<script>

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
		listCall(currPage);
	/* if(word==null || word==""){
	} else {
		searchList(currPage)
	} */
	 
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
			drawList(data.bookListPaing);
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
					
						listCall(page);
					/* if(word==null){
					} else {
						searchList(page);
					} */
				}
			});
			
		},
		error:function(e){
			console.log(e);
		}
	});
}


function drawList(bookListPaing) {
	var content = '';
	var date = new Date();
	bookListPaing.forEach(function(item){
		//console.log(item.status);
		content += '	<tr>';
		content += '		<td>'+item.brw_id+'</td>';
		content += '		<td><a href="bookDetail.do?b_id='+item.b_id+'">'+item.b_title+'</a></td>';
		content += '		<td>'+item.brw_date+'</td>';
		content += '		<td>'+item.return_date+'</td>';
		content += '		<td>'+item.brw_status+'</td>';
		content += '	</tr>';
	});
	// 혹시 모를 상황을 대비해 깨끗하게 비워두고 쌓는다. (append 는 있는 것에 계속해서 이어 붙이는 기능이기 때문)
	$("#list").empty();
	$("#list").append(content);
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