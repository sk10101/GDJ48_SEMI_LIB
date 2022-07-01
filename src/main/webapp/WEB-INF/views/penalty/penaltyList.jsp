<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>이용정지내역</title>
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
		<jsp:include page="../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<h3>이용정지내역 기본</h3>
    <table class="bbs">
        <thead>
            <tr>
            	<td>No</td>
                <td>회원ID</td>          
                <td>제한내역</td>           
                <td>이용정지날짜</td>           
                <td>이용정지종료날짜</td>       
                <td>취소</td>      
            </tr>
        </thead>
        <tbody id="penaltyList">
       
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
							<option value="10" selected="selected">10</option>
							<option value="15">15</option>
							<option value="20">20</option>
						</select>
				       	<select id="option" name="option">
				       		 <option value="member">회원ID</option>
           					 <option value="bantext">제한내역</option>
				       	</select>
			        	<input id="word" type="search" placeholder="검색" name="word" value=""/>
			        	<input id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
				</td>
			</tr>

    </table>
</body>
<script>



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
            url:'penaltyList.ajax',
            data:{
                cnt : pagePerNum,
                page : page
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
            console.log(dto);
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
                	content += '<td>'+dto.penalty_end+'</td>';
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
    

</script>
</html>