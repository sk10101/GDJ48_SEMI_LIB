<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
       <input type="button" value="삭제" onclick="noticedelete()" />
       <button onclick="location.href='noticeWrite.go'">글쓰기</button>
       <form action="noticelist.do" method="POST">
       <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="all" /></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>날짜</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${noticelist }" var="dto">
				<tr>
					<td><input type="checkbox" id="chk" value="${dto.notice_id }"/></td>
					<td>${dto.notice_id }</td>
					<td><a href="noticedetail.do?notice_id=${dto.notice_id }">${dto.notice_title }</a></td>
					<td>${dto.notice_date }</td>
				</tr>
				</c:forEach>
            </tbody>
        </table>
        </form>

        <!-- 아래 페이징 처리 해야됨-->

        <input type="text" id="search" value=""/>
        <button onclick="" id="search_button"><img src="./resources/돋보기.PNG"></button>
    </body>
    <script>
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
        	
    	function noticedelete() {
    		
    		var noticeArray = [];
    		
    		$('input[type="checkbox"]:checked').each(function() {
    			noticeArray.push($(this).val());
    			
    			console.log(noticeArray);
    			
    			$.ajax({
    				type: 'POST',
    				url: '/noticedelete.ajax',
    				data : {noticedeleteList:noticeArray},
    				dataType: 'JSON',
    				success: function(data){
    					console.log(data);
    					location.href='/noticelist.do';
    				},
    				error: function(e) {
    					console.log(e);
    				}
    				
    			});
    			
    		});
    			
    	}	
        	
        
        
    </script>
</html>