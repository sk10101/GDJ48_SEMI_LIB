<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	<h3>관리자페이지(회원관리)</h3>
    <tr>
        <th colspan="2">
            <th><a href="/">일반회원</a></th>
            <th><a href="#">관리자</a></th>
    </tr>
        <input type="text" placeholder="관리자검색"/>
        <button type="submit">검색</button>
    <table class="bbs">
        <thead>
            <tr>
                <td>관리자ID</td>          
                <td>관리자 이름</td>           
                <td>전화번호</td>                
            </tr>
        </thead>
        <tbody>
			<c:forEach items="${adminList }" var="dto">
				<tr>
					<td><a href="memberDetail.do?mb_id=${dto.mb_id }">${dto.mb_id }</a></td>
					<td>${dto.name }</td>
					<td>${dto.phone }</td>
				</tr>
			</c:forEach>
		</tbody>
    </table>
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