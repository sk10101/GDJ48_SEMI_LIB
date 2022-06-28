<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <tbody>
				<c:forEach items="${penaltyList}" var="dto">
					<tr>
						<td>${dto.penalty_id}</td>
						<td><a href="penaltyDetail.do?penalty_id=${dto.penalty_id}">${dto.mb_id }</a></td>
						<c:choose>
                 			<c:when test="${dto.category_id eq '5'}">
                     			<td>대출연체</td>
                 			</c:when>
                 			<c:otherwise>
                      			<td>예약만료</td>
                 			</c:otherwise>
            			</c:choose>
						<td>${dto.penalty_start}</td>
						<c:choose>
                 			<c:when test="${dto.category_id eq '5'}">
                     			<td>${dto.penalty_end }</td>
                 			</c:when>
                 			<c:otherwise>
                      			<td>${dto.penalty_end}</td>
                 			</c:otherwise>
            			</c:choose>						
						<c:choose>
                 			<c:when test="${dto.cancel eq 'true'}">
                     			<td>Y</td>
                 			</c:when>
                 			<c:otherwise>
                      			<td>N</td>
                 			</c:otherwise>
            			</c:choose>
					</tr>
				</c:forEach>
			</tbody>
    </table>
    <br/>
    <div>
        <select id="option">
            <option value="member">회원ID</option>
            <option value="bantext">제한내역</option>
        </select>
        <input type="text" placeholder="검색"/>
        <button type="submit">검색</button>
    </div>
</body>
<script>

/*
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
            url:'list.ajax',
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
    
    function drawList(list){
        var content = '';
        list.forEach(function(item){
            console.log(item);
            content += '<tr>';
            content += '<td>'+item.idx+'</td>';
            content += '<td>'+item.subject+'</td>';
            content += '<td>'+item.user_name+'</td>';
            content += '<td>'+item.bHit+'</td>';
            content += '</tr>';
        });
        $('#list').empty();
        $('#list').append(content); //tbody에 뿌려줌
        
    }
    */
</script>
</html>