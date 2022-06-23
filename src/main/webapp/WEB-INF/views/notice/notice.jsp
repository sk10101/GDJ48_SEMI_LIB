<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
<style>
	h3 {text-align: left; font-weight: bold; font-size: 40px;}
    table {width: 80%}
    table, th, td {border: 1px solid black; border-collapse: collapse;}
    th, td{padding: 5px 10px; text-align: center;}
    button{margin-bottom: 5px; margin-top: 5px; float: right;}
    #search {width: 20%;}
    #search_button {float: none;}
</style>
</head>
    <body>
       <h3>공지사항</h3>
       <input type="button" value="삭제" onclick="noticeDelete()" />
       <button onclick="location.href='noticeWrite.go'">글쓰기</button>
       <form action="noticeList.do" method="POST">
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
                <c:forEach items="${noticeList}" var="dto">
				<tr>
					<td><input type="checkbox" id="chk" value="${dto.notice_id }"/></td>
					<td>${dto.notice_id }</td>
					<td><a href="noticeDetail.do?notice_id=${dto.notice_id }">${dto.notice_title }</a></td>
					<td>${dto.notice_date }</td>
				</tr>
				</c:forEach>
            </tbody>
            
            
            <tr>
			<td colspan="4" id="paging">
				<!-- plugin 사용법 -->
				<div class="container">
					<nav arial-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination" ></ul>
					</nav>
				</div>
			</td>
		</tr>
		
		
        </table>
        </form>

        <!-- 아래 페이징 처리 해야됨-->
        <select id="pagePerNum">
        	<option value="5">보여줄 페이지 갯수 : 5</option>
			<option value="10">보여줄 페이지 갯수 : 10</option>
			<option value="15">보여줄 페이지 갯수 : 15</option>
			<option value="20">보여줄 페이지 갯수 : 20</option>
        </select>

        <input type="text" id="search" value=""/>
        <button onclick="" id="search_button"><img src="./resources/돋보기.PNG"></button>
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

        $('#search_button').click(function() {
            console.log($('#search').val());
            
        });
        	
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
    					location.href='/noticeList.do';
    				},
    				error: function(e) {
    					console.log(e);
    				}
    				
    			});
    			
    		});
    			
    	}	
        	
        var currPage = 1;
        
        listCall(currPage);
        
        $("#pagePerNum").on('change',function(){
        	// console.log("currPage : "+currPage);
        	
        	//페이지당 보여줄 수 변경시 계산된 페이지 적용이 안된다.(플러그인 문제)
        	//페이지당 보여줄 수 변경시 기존 페이징 요소를 없애고 다시 만들어 준다.
        	$("#pagination").twbsPagination('destroy');
        	listCall(currPage);
        });
        
        function listCall(page) {
        	
        	var pagePerNum = $("#pagePerNum").val();
        	 // console.log("param page : " +page);
        	
        	
        	$.ajax({
        		type:'POST',
        		url:'noticeList.ajax',
        		data: {
        			cnt : pagePerNum,
        			page : page
        		},
        		dataType: 'JSON',
        		success:function(data){
        			console.log(data);
        			
        			if (!$('#search').val()) {
        				noticeSearch(data);
        				} 
        				
        			noticeDrawList(data.noticePageList);
        			currPage = data.currPage;
        			$("#pagination").twbsPagination({
        				startPage:data.currPage,
        				totalPages:data.pages,
        				visiblePages:10,
        				onPageClick:function(e,page){
        					// console.log(page);
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
        
        function noticeDrawList (noticePageList) {
        	
        	var content = "";
        	
        	noticePageList.forEach(function(e) {
        		// console.log(e);
        		
        		content += '<tr>'
        		content += '<td><input type="checkbox" id="chk" value=" '+e.notice_id+ ' "/></td>'
        		content += '<td>'+e.notice_id+'</td>'
        		content += '<td><a href="noticeDetail.do?notice_id='+e.notice_id+' "> '+e.notice_title+' </a></td>'
        		content += '<td>'+e.notice_date+'</td>'
        		content += '</tr>'
        		
        	});
        	
        	$("#notice").empty();
        	$("#notice").append(content);
        }
        
      function noticeSearch(data) {
    	  
    	  
    	  
    	    $('#search_button').click(function() {
                // console.log($('#search').val());
                
            
    	  var noticeSearch = $('#search').val();
    	  var noticeArray = [];
    	  
    	  
    	  
    	  
    	  $.ajax({
    		  type:'POST',
    		  url:'noticeSearch.ajax',
    		  data : {
    			  noticeSearch : noticeSearch,
				 noticeKeyWord : noticeArray
    			  },
    		  dataType: 'JSON',
    		  success:function(data) {
    			  console.log(data);
    			  
    		  },
    		  error:function(e) {
    			  console.log(e);
    		  }
    		  
    	 	 });
    	  
    	  });
    	  
      }
      
  	
        
    </script>
</html>