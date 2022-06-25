<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지 / 건의사항 / 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
        #header {
            width: 100%;
            height: 150px;
            border: 2px solid #999;
            background-color: #b0f592;
        }

        #main_content {
            margin-top: 15px;
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

        #claim_detail, #claim_reply {
            width: 800px;
            text-align: center;
        }

        #claim_detail, th, td, #claim_reply {
            border: 2px solid #999;
            border-collapse: collapse;
            padding: 5px;
        }

        #claim_reply {
            margin-left: 139px;
        }

        th {
            padding: 15px;
            width: 125px;
        }

        td {
            text-align: left;
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

        input[type='text'] {
            margin: 5px;
            width: 610px;
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
        <table id="claim_detail">
            <tr>
                <th>제목</th>
                <td>${claim.claim_title}</td>
            </tr>
            <tr>
                <th>작성일</th>
                <td>${claim.claim_date}</td>
            </tr>
            <tr>
                <th>처리상태</th>
                <td>${claim.status}</td>
            </tr>
            <tr>
                <th style="height: 300px;">내용</th>
                <td style="vertical-align: top;">${claim.claim_content}</td>
            </tr>
            <c:if test="${claimList.size()>0}">
            <tr>
                <th>이미지</th>
                <td>
	                <c:forEach items="${claimList}" var="path">
							<img src="/image/${path.newFileName}" width="640"/>
					</c:forEach>
				</td>
            </tr>
            </c:if>
            <tr>
				<th colspan="2">
					<c:choose>
						<c:when test="${claim.status eq '미처리'}">
							<input type="button" value="수정" onclick="location.href='claimUpdate.go?claim_id=${claim.claim_id}'"/>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					<input type="button" value="목록" onclick="location.href='/claimList'"/>
				</th>
			</tr>
        </table>
        <br/>
        <hr/>
        <br/>
        <table id="claim_reply">
	            <tr>
	                <th>관리자</th>
	                <td>
	                	<input type="hidden" name="claim_id" value="${claim.claim_id}"/>
	                	<input type="hidden" name="reply_id" value="${reply.reply_id}"/>
	                	${reply.mb_id}
	                </td>
	            </tr>
	            <tr>
	                <th>작성일</th>
	                <td>${reply.reply_date}</td>
	            </tr>
	            <tr>
	                <th style="height: 300px;">답변 내용</th>
	                <td style="vertical-align:top">${reply.reply_content}</td>
	            </tr>
	            <c:if test="${replyList.size()>0}">
		            <tr>
		                <th>이미지</th>
		                <td>
			                <c:forEach items="${replyList}" var="pathR">
								<img src="/image/${pathR.newFileName}" width="640"/>
							</c:forEach>
						</td>
		            </tr>
	            </c:if>
	        </table>
    </div>
</body>
<script></script>
</html>