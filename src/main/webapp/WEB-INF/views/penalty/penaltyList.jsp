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
    input[type='text'] {
        width: 10%;
    }
    a:link {
        text-decoration: none;
    }
</style>
</head>
<body>
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
			        	<input id="searchBtn" type="button" onclick="searchList(currPage)" value="검색" style="width: 60px; margin-top: 10px;"/>
				</td>
			</tr>

    </table>
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