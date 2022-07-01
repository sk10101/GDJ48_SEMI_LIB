<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출(키오스크)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/5415520417.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/kioskStyle.css">
<style></style>
</head>
<body>
	<a href="ki_main.go">
        <i class="fa-solid fa-angles-left back"></i>
    </a>
    <a href="ki_logout.do">
        <i class="fa-solid fa-arrow-right-from-bracket logout"></i>
    </a>
    <div class="table">
        <table>
            <thead>
                <tr>
                    <th id="chk">체크</th>
                    <th id="hiddenId">책 번호</th>
                    <th>제목</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach items="${list}" var="dto">
				<c:set var="i" value="${i+1 }"></c:set>
					<tr>
						<td><input type="checkbox" class="chkbox" name="chkbox" id="chkbox${i }">
						<label for="chkbox${i }"></label></td>
						<td id="hiddenId">${dto.b_id}</td>
						<td id="brwList">${dto.b_title}</td>
					</tr>			
				</c:forEach>
            </tbody>
        </table>
        <button class="btn-book" onclick="borrow()">대출하기</button>
    </div>
</body>
<script>

	function borrow(){
		
		var chkArr = new Array();
		var checkbox = $("input[name=chkbox]:checked");
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
	
			// checkbox.parent() : checkbox의 부모는 <td>이다.
			// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			
			// 체크된 row의 모든 값을 배열에 담는다.
			
			// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
			var no = td.eq(1).text();
			
			// 가져온 값을 배열에 담는다.
			chkArr.push(no);
		
		});
		
		console.log("chkArr : "+chkArr);
		
		$.ajax({
			type:'get',
			url:'borrow.ajax',
			data:{borrowList:chkArr},
			dataType:'json',
			success:function(data){
				location.href = 'ki_borrowSuccess.go';
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	
	
</script>
</html>