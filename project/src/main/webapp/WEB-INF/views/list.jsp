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
	<div class="container-fluid gedf-wrapper">
        <div class="row">
                        
        </div>
    </div>
			
	<script type="text/javascript">
		$(document).ready(function(){			
			$.ajax({
				url: "/sidebar",
				method : "GET",
				async: false,
				contentType: "application/json",
				success: function(result) {
					$("#imgprofile").attr("src", result.img);
					$("#name").text(result.name);
					$("#email").text(result.email);
			    },
			    error: function(request, status, error) {
			        alert("message : " + request.responseText+"\n" + "error : " + error);
			    }
			});
			
			$.ajax({
				url: "/list5",
				method : "GET",
				async: false,
				contentType: "application/json",
				success: function(val) {
					$.each(val, function(i, result){	
						console.log(result)
						var str = ""
						
						if(result.fileName == undefined){
							result.fileName = "no.gif"
						}						
						
						str += "<div class=\"col-md-6 gedf-main\" style='padding:20px;'><div class=\"card gedf-card\"><div class='card-header' style='background:beige;'>"
							+ "<div class='d-flex justify-content-between align-items-center'>"
	                        + "<div class='d-flex justify-content-between align-items-center'>"
	                        + "<div class=\"ml-2\"><div class=\"h5 m-0\"><i class=\"fas fa-user-edit\"></i>  " 
	                        + result.writer + "</div><div class=\"h7 text-muted\"><i class=\"fas fa-location-arrow\"></i>  " + result.location +"</div></div></div></div></div>"
	                        + "<div class=\"card-body\"><div class=\"text-muted h7 mb-2\"><i class=\"fa fa-clock-o\"></i>  "+ result.date +"</div>"
	                        + "<a class=\"card-link\" href=\"#\"><h5 class=\"card-title\">"+ result.title +"</h5></a>"
	                        + "<p class=\"card-text\">" + result.action + "</p></div>"
	                        + "<div class=\"card-footer\" style=\"background:#4253; text-align:center;\"><img id=\"img\" src='image/" + result.fileName + "'/><br>"
	                        + "<a href=\"#\" class=\"card-link\"><i class=\"fa fa-gittip\"></i> Like</a></div>"   
	                        + "</div></div>"
                
						$(".row").append(str);
					});	
			    },
			    error: function(request, status, error) {
			        alert("message : " + request.responseText+"\n" + "error : " + error);
			    }
			});
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
							success: function(val) {								
								var str = "";								
								if(val != ""){
									$.each(val, function(i, result){
										if(result.fileName == undefined)
											result.fileName = "no.gif";	
										
										str += "<div class=\"col-md-6 gedf-main\" style='padding:20px;'><div class=\"card gedf-card\"><div class='card-header' style='background:beige;'>"
											+ "<div class='d-flex justify-content-between align-items-center'>"
					                        + "<div class='d-flex justify-content-between align-items-center'>"
					                        + "<div class=\"ml-2\"><div class=\"h5 m-0\"><i class=\"fas fa-user-edit\"></i>  " 
					                        + result.writer + "</div><div class=\"h7 text-muted\"><i class=\"fas fa-location-arrow\"></i>  " + result.location +"</div></div></div></div></div>"
					                        + "<div class=\"card-body\"><div class=\"text-muted h7 mb-2\"><i class=\"fa fa-clock-o\"></i>  "+ result.date +"</div>"
					                        + "<a class=\"card-link\" href=\"#\"><h5 class=\"card-title\">"+ result.title +"</h5></a>"
					                        + "<p class=\"card-text\">" + result.action + "</p></div>"
					                        + "<div class=\"card-footer\" style=\"background:#4253; text-align:center;\"><img id=\"img\" src='image/" + result.fileName + "'/><br>"
					                        + "<a href=\"#\" class=\"card-link\"><i class=\"fa fa-gittip\"></i> Like</a></div>"   
					                        + "</div></div>"
									});
									$(".row:last").append(str);
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