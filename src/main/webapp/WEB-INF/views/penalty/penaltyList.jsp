<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>이용정지내역</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/penaltyClaim.css">
<link rel="stylesheet" href="resources/css/frame.css">
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
		<div class="myPageTab" id="myPage_menu">
	        <h3>관리자 페이지</h3>
	        <hr style="height: 1px !important; background:#333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a class="tabSelect" href="penaltyList.go">이용정지내역</a>
	    </div>
	    <div class="section">
	    	<div class="penaltyTable-area">
			    <table class="penalty_table" id="penalty_table">
			       <thead>
			            <tr>
			                <th class="col1">No</th>
			                <th class="col2">회원ID</th>
			                <th class="col3">제한내역</th>
			                <th class="col4">이용정지날짜</th>
			                <th class="col5">이용정지종료날짜</th>
			                <th class="col6">취소</th>
			            </tr>
			       </thead>
	       	 	<tbody id="penaltyList">
	       
				</tbody>
		 		</table>
				<div class="container">
	                  <nav aria-label="Page navigation" style="text-align:center">
	                        <ul class="pagination" id="pagination"></ul>               
	                  </nav>
		        </div>
				<div class="noticeSearchOption">
					<select class="selectBtn" id="pagePerNum">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15" selected="selected">15</option>
						<option value="20">20</option>
					</select>
			     	<select class="selectBtn" id="option" name="option">
			     		 <option value="회원ID">회원ID</option>
	   				     <option value="제한내역">제한내역</option> 
			     	</select>
			     	<input class="noticeSearchBlock" id="word" type="search" placeholder="검색" name="word" value=""/>
			     	<input class="noticeSearchDo" id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
		 		</div>
   		 	</div>
   		 </div>
   	</div>
</body>
<script>
	var msg = "${msg}"
	if (msg != "") {
		alert(msg);
	}
	// 관리자 임을 알 수 있는 회원등급과 현재 페이지 정보를 변수에 담는다.
	var mb_id = "${sessionScope.loginId}";
	var mb_class = "${sessionScope.mb_class}";
	var currPage=1;
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
    });
       
	$('#searchBtn').on('click',function(){	
		$("#pagination").twbsPagination('destroy');
		searchList(currPage);
	});

  
    function listCall(page){	
        
        var pagePerNum = $('#pagePerNum').val();
        console.log("param page : "+page);
        $.ajax({
            type:'GET',
            url:'penaltyList.ajax',
            data:{
            	cnt : pagePerNum,
				page : page,
				mb_id : mb_id,
				mb_class : mb_class
            },
            dataType:'json',
            success:function(data){
                console.log(data);
                drawList(data.penaltyList);
                currPage = data.currPage;
                
                //불러오기가 성공되면 플러그인을 이용해 페이징 처리
                $("#pagination").twbsPagination({
                    startPage:data.currPage, //시작 페이지
                    totalPages:data.pages, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
                    visiblePages:10, //한 번에 보여줄 페이지 수 [1][2][3][4][5]
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
    
    function drawList(penaltyList){
        var content = '';
        penaltyList.forEach(function(dto){
            // console.log(dto);
            if(dto.penalty_end != null) {
	            content += '<tr>';
	            content += '<td>'+dto.penalty_id+'</td>';
	            content += '<td><a href="penaltyDetail.do?penalty_id='+dto.penalty_id+'">'+dto.mb_id+'</a></td>';
	            if(dto.category_id == "5"){
	            	content += '<td>대출연체</td>';
	            }else {
	            	content += '<td>예약만료</td>';
	            }
	            content += '<td>'+dto.penalty_start+'</td>';
	            if(dto.category_id == "5"){
	            	content += '<td>'+dto.penalty_end+'</td>';
	            }else{
	            	content += '<td>'+dto.penalty_end+'</td>';
	            }
	            if(dto.cancel == true){
	            	content += '<td>Y</td>';
	            }else{
	            	content += '<td>N</td>';
	            }
	            content += '</tr>';
	            	
            }else{
            	content += '<tr>';
                content += '<td>'+dto.penalty_id+'</td>';
                content += '<td><a href="penaltyDetail.do?penalty_id='+dto.penalty_id+'">'+dto.mb_id+'</a></td>';
                if(dto.category_id == "5"){
                	content += '<td>대출연체</td>';
                }else {
                	content += '<td>예약만료</td>';
                }
                content += '<td>'+dto.penalty_start+'</td>';
                if(dto.category_id == "5"){
                	content += '<td></td>';
                }else{
                	content += '<td></td>';
                }
                if(dto.cancel == true){
                	content += '<td>Y</td>';
                }else{
                	content += '<td>N</td>';
                }
                content += '</tr>';
            }
        });
        $('#penaltyList').empty();
        $('#penaltyList').append(content); //tbody에 뿌려줌
        
    }
    
    
    function searchList(page){
    	var word = $('#word').val();
    	
    	var option = $('#option').val();
   		
    	if(word.indexOf('대출') == 0){
    		word = "5";
    	}else if(word.indexOf('예약') == 0){
    		word = "6";
    	}
    	
    	var pagePerNum = $('#pagePerNum').val();
    	console.log(word);
    	
    	$.ajax({
    		type: 'GET',
    		url: 'penaltyList.ajax',
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
    			$("#penaltyList").empty();
    			drawList(data.penaltyList);
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

    function test (btn) {
    	console.log($(this).text());
    }
    

</script>
</html>