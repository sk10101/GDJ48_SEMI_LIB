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
	
	        #claim_writeForm {
	            width: 800px;
	            text-align: center;
	        }
	
	        #claim_writeForm, th, td {
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
        	<form action="claimWrite.do" method="post" enctype="multipart/form-data">
	            <table id="claim_writeForm">
	                <tr>
	                    <th>제목</th>
	                    <td><input type="text" name="claim_title" value="제목을 입력하세요."/></td>
	                </tr>
	                <tr>
	                    <th style="height: 300px;">내용</th>
	                    <td><input type="text" name="claim_content" value="내용을 입력하세요. 모양만 잡아놓은것" style="height: 300px;"/></td>
	                </tr>
	                <tr>
	                    <th>이미지</th>
	                    <td><input type="file" name="photos" multiple="multiple"/></td>
	                </tr>
	                <tr>
			            <th colspan="2">
				            <input type="submit" value="저장" style="width: 60px; margin-top: 10px;"/>
							<input type="button" value="취소" onclick="location.href='/claimList'" style="width: 60px; margin-top: 10px;"/>
						</th>
					</tr>			
	            </table>
            </form>
        </div>
    </body>
<script></script>
</html>