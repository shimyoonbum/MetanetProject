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
				<input type="button" id="start" value="시작하기" onclick="location.href='/main'">
			</div>	
		</div>
	</div>
</body>
</html>
