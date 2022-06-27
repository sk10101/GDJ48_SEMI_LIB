<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 게시판</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>

<style>

	header{
    width: 100%;
    height: 100px;
    background: #fff;
    color: #333
}

.header-wrap{ /*화면 중앙에 오게끔*/
    width: 1200px;
    display: block;
    margin: 0 auto;
}

.logo{
    float: left;
    width: 200px;
    height: 100px;
    text-align: center;
    line-height: 100px;
    display: inline;
    position: relative;
}

nav{
    width: 800px;
    height: 100px;
    float: right;
    display: block;
    top: 0;
    right: 0;
    position: relative;
}

.navi { 
    width: 600px; height: 30px; 
    margin: 20px 0 0 350px;

}

.navi > li{
    float: left; width: 200px; 
    font-size: 20px;
    text-align: center;
}

	h3 {text-align: left; font-weight: bold; font-size: 40px;}
    table {width: 80%}
    table, th, td {border: 1px solid black; border-collapse: collapse;}
    th, td{padding: 5px 10px; text-align: center;}
    button{margin-bottom: 5px; margin-top: 5px; float: right;}
    #search {width: 20%;}
    #search_button {float: none;}
    
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
    	<header>
    		<div class="header-wrap">
            <div class="logo">
                <a href="/"><img src="../resources/img/logo.png" class="logo"></a>
            </div>
            <nav>
                <ul class="navi">
                    <li>***님 환영합니다.</li>
                    <li><a href="/">로그아웃</a></li>
                    <li><a href="#">관리자페이지</a></li>
                </ul>
            </nav>
        </div>
    	</header>
    	<div id="myPage_menu">
	        <h3>마이페이지</h3>
	        <hr/>
	        <a href="#">도서내역</a><br/>
	        <br/>
	        <a href="claimList">건의사항</a><br/>
	        <br/>
	        <a href="#">회원정보</a>
    	</div>
       <h3>공지사항</h3>
       <input type="button" value="삭제" onclick="noticeDelete()" />
       <button onclick="location.href='noticeWrite.go'">글쓰기</button>
       <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="all" /></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>날짜</th>
                </tr>
            </thead>
            <tbody id="notice">
            <!--
                <c:forEach items="${noticeList}" var="dto">
				<tr>
					<td><input type="checkbox" id="chk" value="${dto.notice_id }"/></td>
					<td>${dto.notice_id }</td>
					<td><a href="noticeDetail.do?notice_id=${dto.notice_id }">${dto.notice_title }</a></td>
					<td>${dto.notice_date }</td>
				</tr>
				</c:forEach>
			-->
            </tbody>
            
            
            <tr>
			<td colspan="4" id="paging">
				<!-- plugin 사용법 -->
				<div class="container">
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination" >
						</ul>
					</nav>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="4">
			<!-- 아래 페이징 처리 해야됨-->
		       <select id="pagePerNum">
			       	<option value="5">5</option>
					<option value="10" selected="selected">10</option>
					<option value="15">15</option>
					<option value="20">20</option>
		       </select>
				<select id="option" name="option">
		      		<option value="제목">제목</option>
		      	</select>
		       <input type="search" id="word" value="" name="word" placeholder="제목을 입력하세요"/>
		       <input type="button" onclick="searchList(currPage)" id="searchBtn" value="검색" style="width: 60px; margin-top: 10px;"/>
			</td>
		</tr>
        </table>
    </body>
    <script>
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
    			
    			$.ajax({
    				type: 'POST',
    				url: '/noticeDelete.ajax',
    				data : {noticedeleteList:noticeArray},
    				dataType: 'JSON',
    				success: function(data){
    					console.log(data);
    					location.href='/notice.go';
    				},
    				error: function(e) {
    					console.log(e);
    				}
    				
    			});
    			
    		});
    			
    	}	
        
        
        // 공지사항 리스트 띄워주고, 페이징까지 처리
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
    				noticeDrawList(data.noticePageList);
    				currPage = data.currPage;
    				// 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
    				$("#pagination").twbsPagination({
    					startPage: data.currPage, // 시작 페이지
    					totalPages: data.pages, // 총 페이지 수(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
    					visiblePages: 5, // 한 번에 보여줄 페이지 수 ( ex)[1],[2],[3],[4],[5] ...)
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
    
    
    function noticeDrawList(noticePageList) {
		var content = '';
		var date = new Date();
		noticePageList.forEach(function(item){
			//console.log(item.status);
			content += '	<tr>';
			content += '		<td><input type="checkbox" id="chk" value="'+item.notice_id+ '"/></td>';
			content += '		<td>'+item.notice_id+'</td>';
			content += '		<td><a href="noticeDetail.do?notice_id='+item.notice_id+' "> '+item.notice_title+' </a></td>';
    		content += '		<td>'+item.notice_date+'</td>';
			content += '	</tr>';
		});
		// 혹시 모를 상황을 대비해 깨끗하게 비워두고 쌓는다. (append 는 있는 것에 계속해서 이어 붙이는 기능이기 때문)
		$("#notice").empty();
		$("#notice").append(content);
	}
  	
        
     // 검색 결과 출력
   	function searchList(page) {
   		var word = $('#word').val();
   		var option = $('#option').val();
   		var pagePerNum = $('#pagePerNum').val();
   		
   		
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
   				$("#noitce").empty();
   				noticeDrawList(data.noticeDrawList);
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