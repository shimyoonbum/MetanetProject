<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>

<layoutTag:layout>  

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert Form</title>
</head>
<body>
	
	<h2 class = "title">업무일지 작성 </h2>
 
	<div class="container">
	    <form action="/insertProc" method="post">
	      <div class="form-group">
	        <label for="title">업무일지제목</label>
	        <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요.">
	      </div>
	      <div class="form-group">
	        <label for="action">수행업무</label>
	        <input type="text" class="form-control" id="action" name="action" placeholder="업무를 입력하세요.">
	      </div>
	      <div class="form-group">
	        <label for="planned">예정업무</label>
	        <input type="text" class="form-control" id="planned" name="planned" placeholder="예정업무를 입력하세요.">
	      </div>
	      <div class="form-group">
	        <label for=description">비고</label>
	        <textarea class="form-control" id="description" name="description" rows="3"></textarea>
	      </div>
	      <button type="submit" class="btn btn-primary">작성</button>
	    </form>
	</div>	
</body>
</html>

</layoutTag:layout>
