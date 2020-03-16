<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>

<layoutTag:layout>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>미니 프로젝트</title>
</head>
<body>
	<h2 class = "title"> 게시글 수정 </h2>
	 
	<div class="container">
	    <form action="/updateProc" method="post">
	      <div class="form-group">
	        <label for="action">수행업무</label>
	        <input type="text" class="form-control" id="action" name="action" value="${detail.action}">
	      </div>
	      <div class="form-group">
	        <label for="planned">예정업무</label>
	        <textarea class="form-control" id="planned" name="planned" rows="3">${detail.planned}</textarea>
	      </div>
	      <div class="form-group">
	        <label for="description">비고</label>
	        <input type="text" class="form-control" id="description" name="description" value="${detail.description}">
	      </div>
	      <!-- 글 번호를 히든값으로 서버에 넘겨줌 -->
	      <input type="hidden" name="no" value="${detail.no}"/>
	      
	      <div>
	          <button type="submit" class="btn btn-primary" id="updatebtn">수정</button>
	    	  <button class="btn btn-primary" onclick="location.href='/list'">뒤로가기</button> 
	      </div>
	    </form>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){			
			/* 수정 버튼 script */
			$("#updatebtn").click(function(){
				if (confirm("정말 수정하시겠습니까??") == true){
					location.href='/detail/${detail.no}'
				}else{   
					return false;
		 		}
			})
		});
	</script>
</body>
</html>

</layoutTag:layout>