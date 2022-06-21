<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	#header {
            width: 100%;
            height: 150px;
            border: 2px solid #999;
            background-color: #b0f592;
        }

        #main_content {
            width: 1000px;
            height: 800px;
        }

        #myPage_menu {
            width: 125px;
            height: 500px;
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

        th {
            padding: 15px;
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

        #delete {
            width: 55px;
        }

        #date, #status {
            width: 100px;
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
	<div id="header">
            <a href="#">도서관 로고 들어갈 위치</a>
        </div>
        <div id="myPage_menu">
            <h3>마이페이지</h3>
            <hr/>
            <a href="#">도서내역</a><br/>
            <br/>
            <a href="#">건의사항</a><br/>
            <br/>
            <a href="#">회원정보</a>
        </div>
        <div id="main_content">
            <button id="claim_write" onclick="location.href='claimWrite.go'">건의사항 작성</button><br/>
            <table id="claim_table">
            	<thead>
	                <tr>
	                    <th>No</th>
	                    <th>제목</th>
	                    <th>처리상태</th>
	                    <th>작성일</th>
	                    <th>삭제</th>
	                </tr>
            	</thead>
            	<tbody>
            		<c:forEach items="${claimList}" var="dto">
            			<tr>
            				<td id="claimID">${dto.claim_id}</td>
            				<td><a href="claimDetail?claim_id=${dto.claim_id}">${dto.claim_title}</a></td>
            				<td id="claimStatus">${dto.status}</td>
            				<td>${dto.claim_date}</td>
            				<!-- <a href="claimDel.do?claim_id=${dto.claim_id}">삭제</a> -->
            				<td><button id="delBtn">삭제</button></td>
            			</tr>
            		</c:forEach>
           		</tbody>
            </table>
            <input type="search" placeholder="검색"/>
        </div>
</body>
<script>
	$("#delBtn").on("click",function(e){
		location.href='/claimDel.do?claim_id=' + $("#claimID").text();
	});
	
	if($("#claimStatus").text() != "미처리") {
		$("#delBtn").hide();
	}
</script>
</html>