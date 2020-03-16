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
    <h2 class = "title"> 게시글 상세 </h2>
    
    <div class = "btn">    	
    	<button class="btn btn-danger" id="removebtn"><i class="fas fa-trash-alt"></i>삭제</button>   
	    <button class="btn btn-primary" onclick="location.href='/update/${detail.no}'"><i class="fas fa-edit"></i>수정</button>		
    </div>     
 
	<div class="containerdetail">
	    <form action="/insertProc" method="post">
	      <div class="form-group">
	        <label>수행업무</label>
	        <p>${detail.action}</p>
	      </div>
	      <div class="form-group">
	        <label>예정업무</label>
	        <p>${detail.planned}</p>
	      </div>
	      <div class="form-group">
	        <label>비고</label>
	        <p>${detail.description}</p>
	      </div>	      
	    </form>
	</div>		
	
	<div class = "btnback">
		<button class="btn btn-primary" onclick="location.href='/list'">뒤로가기</button> 
	</div>	
	
	<script type="text/javascript">
		$(document).ready(function(){			
			/* 삭제 버튼 script */
			$("#removebtn").click(function(){
				if (confirm("정말 삭제하시겠습니까??") == true){
					location.href='/delete/${detail.no}'
				}else{   
					return false;
		 		}
			})
		});
	</script>
</body>
</html>

</layoutTag:layout>
