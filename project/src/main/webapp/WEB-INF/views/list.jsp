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
	<h2 class = "title"> 업무일지 작성 목록 </h2>
		<div class="enters">
			<c:forEach items="${listDTO}" var="listDTO">			
				<li>작성날짜 : ${listDTO.date}</li>
			  	<li>작성자 : ${listDTO.writer}</li>
			  	<li>작성위치 : ${listDTO.location}</li>  		
			  	<li>제목 : ${listDTO.title}</li>
			  	<li>수행업무 : ${listDTO.action}</li>
			  	<c:if test="${listDTO.fileyn eq 'Y'}">
			  		<li>첨부파일 : <img id="img" src ="image/${listDTO.fileName}"/></li>
			  	</c:if>
			  	<c:if test="${listDTO.fileyn eq 'N'}">
			  		<li>첨부파일 : <img id="img" src ="image/no.gif"/></li>
			  	</c:if>
			  	
			  	<br><br>			
			</c:forEach>
		</div>
		
		<div id="mySidenav" class="sidenav">
		
		<div class="pro" style="margin-left : 30px;">
			<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
			
			<div>			
				<img id="imgprofile" src ="${pageContext.request.contextPath}${UserDTO.thumbnail}"/>			
			</div>
			
			<p style="font-weight:900;font-size:30px;">${UserDTO.name}</p>
			<p style="font-weight:500;font-size:15px;">${UserDTO.email}</p>
		</div>  
		
	   	<div class="cancel">			
			<a href="/main" class = "menu">  				
				<i class="fas fa-pencil-alt"></i> 업무일지관리
			</a>
		    
		    <a href="/list" class = "menu">
		    	<i class="fas fa-tasks"></i> 작성일지보기
		    </a>
		    
		    <a href="/logout" class = "menu">
		    	<i class="fas fa-sign-out-alt"></i> 로그아웃
		    </a>
		</div>  	
	</div>  
	
	<script type="text/javascript">
		$(document).ready(function(){
			//현재 스크롤 탑 0 초기화
			var lastScrollTop = 0;
			var selectNum = 5;
			$(window).scroll(function() {				
				//스크롤 됬을 때 스크롤 값
				var currentScroll = $(window).scrollTop();				
				var obj = {"num" : selectNum};				
				if(currentScroll - lastScrollTop > 0){
					//현재 스크롤의 위치가 화면에 보이는 위치보다 클 때
				    if($(window).scrollTop() >= ($(document).height() - $(window).height()-5)){
					    $.ajax({
							url: "/newlist",
							data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
							method: "POST", // HTTP 요청 메소드(GET, POST 등) 
							contentType: "application/json",
							async: false,
							success: function(result) {								
								var str = "";								
								if(result != ""){
									$(result).each(function(){
										if(this.fileName == null)
											this.fileName = "no.gif";	
										
										str += "<div id=" + "'enters'" + ">"
										+ "<li>작성날짜 : " + this.date + "</li>"
										+ "<li>작성자 : " + this.writer + "</li>"
										+ "<li>작성위치 : " + this.location + "</li>"
										+ "<li>제목 : " + this.title + "</li>"
										+ "<li>수행업무 : " + this.action + "</li>"
										+ "<li>첨부파일 : <img id='img' src=image/" + this.fileName + "/></li>"
										+ "</div><br><br>";
									});
									$("div.enters:last").append(str);
								}
								else{
									return false;	//이벤트 종료
								}								
								selectNum += 5;
						    },
						    error: function(errorThrown) {
						        alert(errorThrown.statusText);				        
						    },
						});			
				    }					
				}		
			});
		});
	</script>
</body>
</html>

</layoutTag:layout>