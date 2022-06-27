<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 페이지 / 답변 수정</title>
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
	
	        #reply_writeForm {
	            width: 800px;
	            text-align: center;
	        }
	
	        #reply_writeForm, th, td {
	            border: 2px solid #999;
	            border-collapse: collapse;
	            padding: 5px;
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
	        
	        #claim_content {
	        	vertical-align: top;
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
    <div id="main_content">
    	<form action="replyUpdate.do" method="post" enctype="multipart/form-data">
         <table id="reply_writeForm">
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
                <td><textarea name="reply_content" style="height: 273px; width: 614px;">${reply.reply_content}</textarea></td>
            </tr>
            <c:if test="${replyList.size()>0}">
	            <tr>
	                <th>이미지</th>
	                <td>
	                	<input type="file" name="photos" multiple="multiple"/>	
		                <c:forEach items="${replyList}" var="pathR">
							<img src="/image/${pathR.newFileName}" width="640"/>
						</c:forEach>
					</td>
	            </tr>
            </c:if>
            <tr>
	          	<th colspan="2">
		            <input type="submit" value="수정" style="width: 60px; margin-top: 10px;"/>
					<input type="button" value="취소" onclick="location.href='adminClaimDetail?claim_id=${claim.claim_id}'"/>
				</th>
			</tr>			
         </table>
        </form>
    </div>
</body>
<script></script>
</html>