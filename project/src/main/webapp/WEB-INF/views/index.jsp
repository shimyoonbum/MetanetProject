<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>미니 프로젝트</title>
    
    <!-- CSS 요소 리셋 -->
	<link href="css/reset.css" rel="stylesheet" type="text/css">
	
	<!-- 커스텀 CSS -->
	<link href="css/main.css" rel="stylesheet" type="text/css">
    
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body style="background:lightgray">
	<div id="layout">	
		<div id ="index">		
			<img src="/image/metanet.jpg" style="width: 100%; height: auto;">	
			<h1 style="text-align:center; color:cornflowerblue">일일 업무 일지 작성</h1>	
			<div style="padding-top:70px;">
				<c:if test="${email eq null}">
			       <a href="https://kauth.kakao.com/oauth/authorize?client_id=65d0922e1689187bfa35034a01cc52b1&redirect_uri=https://192.5.105.159:8000/oauth&response_type=code">
			           <img src="/image/kakao_login_btn_medium_wide.png" style="width: 90%; height: auto; text-align:center">
			       </a>
			    </c:if>
			    <c:if test="${email ne null}">
			       <input type="button" id="start" value="시작하기" onclick="location.href='/main'">
			    </c:if>
			</div>	
		</div>
	</div>
</body>
</html>
