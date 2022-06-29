<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
<style>
    .detail {
        right: 0;
    }
    table.bbs {
		width: 50%;
	}
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td {
		padding: 10px 10px;
	}
	textarea {
		width: 100%;
		height: 150px;
		resize: none;
	}
    a:link {
        text-decoration: none;
    }
</style>
</head>
<body>
	<h3>블랙리스트 기본</h3>
	    <table>
	        <thead>
	            <tr>
	                <td>회원ID</td>          
	                <td>지정한 관리자ID</td>           
	                <td>지정일</td>           
	                <td>해제한 관리자ID</td>       
	                <td>해제일</td>      
	            </tr>
	        </thead>
	        <tbody id=list>
				
			</tbody>
			
			
			<tr>
		 		<td colspan="5" id="paging">
		 			<!-- plugin 사용법 -->
		 			<div class="container">
		 				<nav aria-label="Page navigation" style="text-align:center">
		 					<ul class="pagination" id="pagination">
		 					</ul>
		 				</nav>
		 			</div>
		 		</td>
		 	</tr>
		 	<tr>
		 		<td>
			 		<select id="pagePerNum">
					 	<option value="5">5</option>
					 	<option value="10" selected="selected">10</option>
					 	<option value="15">15</option>
					 	<option value="20">20</option>
					 </select>
				 </td>
		 	</tr>
	    </table>
	<input type="button" value="추가" onclick="location.href='blackAdd.go'">
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
			url:'blackPaging.ajax',
			data:{
				cnt : pagePerNum,
				page : page
			},
			dataType:'json',
			success:function(data){
				console.log(data);
				drawList(data.list);
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

	
	
	function drawList(list){
		var content = '';
		list.forEach(function(dto){
			console.log(dto);
			if(dto.admin_end != null){
				content += '<tr>';
				content += '<td><a href="blackDetail.do?black_id='+dto.black_id+'">'+dto.mb_id+'</a></td>';
				content += '<td>'+dto.admin_start+'</td>';
				content += '<td>'+dto.black_start+'</td>';
				content += '<td>'+dto.admin_end+'</td>';
				content += '<td>'+dto.black_end+'</td>';
				content += '</tr>';				
			}else{
				content += '<tr>';
				content += '<td><a href="blackDetail.do?black_id='+dto.black_id+'">'+dto.mb_id+'</a></td>';
				content += '<td>'+dto.admin_start+'</td>';
				content += '<td>'+dto.black_start+'</td>';
				content += '<td></td>';
				content += '<td></td>';
				content += '</tr>';
			}
		});
		$('#list').empty();
		$('#list').append(content); //tbody에 뿌려줌
		
		
		
		
/* 		<c:forEach items="${blackList }" var="dto">
		<tr>
			<td><a href="blackDetail.do?black_id=${dto.black_id }">${dto.mb_id }</a></td>
			<td>${dto.admin_start }</td>
			<td>${dto.black_start }</td>
			<td>${dto.admin_end }</td>
			<td>${dto.black_end }</td>
		</tr>
	</c:forEach>
		 */
	}

</script>
</html>