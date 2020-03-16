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
	<div>
 		<h2 class = "title">업무 일지 작성 내역</h2>
	</div>	
	
	<div class="date">
		<p id = "search">날짜</p>
		<input type="text" id="datepicker" placeholder="날짜 넣기">		
		<button id="searchdate" class="btn btn-primary">
			<i class="fas fa-search"></i>
		</button>
		<p id = "blank"></p>
		<button id="plus" class="btn btn-primary" data-toggle='modal' href='#insertModal'>
			<i class="fas fa-plus"></i> 추가
		</button>
	</div>	
 			
	<div class="container">
	    <table class="table table-hover" id="tablelist">
	    	 <colgroup>
	    	 	<col width="20%">
				<col width="80%">					
			</colgroup>
			  	<thead>
			        <tr>
				       	<th scpoe="col">번호</th>
				        <th scpoe="col">제목</th>					       
				    </tr>
			    </thead>
			    <tbody></tbody>       
	    </table>
	</div>
	
	<!-- 상세 정보 모달 -->	  
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
	    	<!-- 모달 내용-->
	    	<div class="modal-content">
	    		<!-- 모달 헤더-->
		    	<div class="modal-header">		        	         
			        <h3 class="modal-title">업무일지 내용</h3>
		        </div>
		        <!-- 모달 내용부분-->
				<form>				
					<div class="modal-body">
						<input type="hidden" class="hidden-input">		
						<div class="form-group">
					        <label for="action">수행업무</label>					        
					        <textarea class="form-control" id="action" name="action" rows="3" placeholder="수행업무를 입력하세요."></textarea>
				        </div>
				        <div class="form-group">
					        <label for="planned">예정업무</label>
					        <textarea class="form-control" id="planned" name="planned" rows="3" placeholder="예정업무를 입력하세요."></textarea>
				        </div>
				        <div class="form-group">
					        <label for=description">비고</label>					        
					        <textarea class="form-control" id="description" name="description" rows="3" placeholder="비고를 입력하세요."></textarea>
				        </div>
					</div>
				</form>
				<!-- 모달 버튼 부분-->
				<div class="modal-footer">					
					<button type="button" class="btn btn-default" data-dismiss="modal">뒤로가기</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal" id="deleteBtn">삭제</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="updateBtn">수정</button>					
		    	</div>
			</div>      
	    </div>
	</div> 
	
	<!-- 입력 모달 -->	  
	<div class="modal fade" id="insertModal" role="dialog">
		<div class="modal-dialog">
	    	<!-- 모달 내용-->
	    	<div class="modal-content">
	    		<!-- 모달 헤더-->
		    	<div class="modal-header">		        	         
			        <h3 class="modal-title">업무일지 작성</h3>
		        </div>
		        <!-- 모달 내용부분-->
				<form>				
					<div class="modal-body">
						<div class="form-group">
					        <label for="Ititle">일지제목(필수)</label>
					        <span id="notitle" style="color:red; font-size: 13px; display:none;">*제목을 입력해주세요.</span>
					        <input type="text" class="form-control" id="Ititle" name="Ititle" placeholder="제목을 입력하세요.">
				        </div>				        
						<div class="form-group">
					        <label for="Iaction">수행업무(필수)</label>
					        <span id="noaction" style="color:red; font-size: 13px; display:none;">*진행한 업무를 입력해주세요.</span>					        
					        <textarea class="form-control" id="Iaction" name="Iaction" rows="3" placeholder="수행업무를 입력하세요."></textarea>

				        </div>
				        <div class="form-group">
					        <label for="Iplanned">예정업무</label>
					        <textarea class="form-control" id="Iplanned" name="Iplanned" rows="3" placeholder="예정업무를 입력하세요."></textarea>
				        </div>
				        <div class="form-group">
					        <label for=Idescription">비고</label>
					        <textarea class="form-control" id="Idescription" name="Idescription" rows="3" placeholder="비고를 입력하세요."></textarea>
				        </div>
					</div>
				</form>
				<!-- 모달 버튼 부분-->
				<div class="modal-footer">					
					<button type="button" class="btn btn-primary" data-target="#insertModal" id="insertBtn">등록</button>
					<button type="button" class="btn btn-default" data-target="#insertModal" id="cancel">취소</button>						
		    	</div>
			</div>      
	    </div>
	</div> 
  
  
	
	<script type="text/javascript">
		$(document).ready(function(){	
			var x = new Date();
			//datepicker 설정
			$("#datepicker").datepicker({
				dateFormat: 'yy-mm-dd',
			    prevText: '이전 달',
			    nextText: '다음 달',
			    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    dayNames: ['일','월','화','수','목','금','토'],
			    dayNamesShort: ['일','월','화','수','목','금','토'],
			    dayNamesMin: ['일','월','화','수','목','금','토'],
			    showMonthAfterYear: true,
			    changeMonth: true,
			    changeYear: true,
			    yearSuffix: '년'
		    });
			//datepicker text 현재 날짜로 세팅한다
		    $("#datepicker").datepicker("setDate", x);

			//업무일지 조회 관련 jquery
			$("#searchdate").click(function(){
				var date = $("#datepicker").val();
				var obj = {"date": date};
				console.log(obj);
				$.ajax({
					url: "/search",
					data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
					method: "POST", // HTTP 요청 메소드(GET, POST 등) 
					contentType: "application/json",
					success: function(result) {
						console.log(result);
						if(result.length == 0){
							alert("해당 날짜에 존재하는 일지가 검색되지 않았습니다.");
						}						
						$('#tablelist tbody').empty();
						$.each(result, function(){							
							$('#tablelist tbody').append("<tr data-toggle='modal' href='#myModal'><td>" 
									+ this.no
									+ "</td><td>" 
									+ this.title 
									+ "</td></tr>");
						});							
				    },
				    error: function(errorThrown) {
				        alert(errorThrown.statusText);
				    }
				});										
			});

			/* 행 클릭시 상세내역 보기 화면으로 이동 */
			//동적으로 추가된 요소의 경우, 이벤트 리바인딩을 하기 위해서 $(document).on(function()) 을 사용한다.
	    	$(document).on("click",".table-hover tbody tr" ,function(){
				var tr = $(this);				
				var td = tr.children();
				var indexdata = td.eq(0).text();
				var no = parseInt(indexdata);
				var obj = {"no": no};
				console.log(no);
				$.ajax({
					url: "/detail",
					data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
					method: "POST", // HTTP 요청 메소드(GET, POST 등) 
					contentType: "application/json",
					success: function(result) {
						$(".hidden-input").val(result.no);				
						$("#action").val(result.action);
						$("#planned").val(result.planned);
						$("#description").val(result.description);
				    },
				    error: function(errorThrown) {
				        alert(errorThrown.statusText);
				    }
				});	
			});
			
	    	/*취소 버튼 클릭시 화면 초기화 jquery */
			$("#cancel").click(function(){
				$("#Ititle").val("");
				$("#Iaction").val("");
				$("#Iplanned").val("");
				$("#Idescription").val("");
				$("#notitle").css("display","none");
				$("#noaction").css("display","none");
				$("#insertModal").modal("toggle");
			});			

	    	/*글 수정 관련 jquery */
			$("#insertBtn").click(function(){
				
				var cnt = 0;
				
				if(!$("#Ititle").val()){
					$("#notitle").css("display","inline")
				}
				else{
					$("#notitle").css("display","none")
					cnt++;
				}
				
				if(!$("#Iaction").val()){
					$("#noaction").css("display","inline")
				}
				else{
					$("#noaction").css("display","none")
					cnt++;
				}
				
				if(cnt == 2){
					var title = $("#Ititle").val();
					var action = $("#Iaction").val();
					var planned = $("#Iplanned").val();
					var description = $("#Idescription").val();
					
					var obj = {
							"title": title,
							"action": action, 
							"planned": planned, 
							"description": description
					};
					console.log(obj);
					$.ajax({
						url: "/insert",
						data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
						method: "POST", // HTTP 요청 메소드(GET, POST 등) 
						contentType: "application/json",
						success: function(result) {
							alert("일지 등록하였습니다.");	
							$("#Ititle").val("");
							$("#Iaction").val("");
							$("#Iplanned").val("");
							$("#Idescription").val("");
							
							$("#insertModal").modal("toggle");
					    },
					    error: function(errorThrown) {
					        alert(errorThrown.statusText);				        
					    },
					});					
				}				
			}); 

	    	/*글 수정 관련 jquery */
			$("#updateBtn").click(function(){
				var no = $(".hidden-input").val();
				var action = $("#action").val();
				var planned = $("#planned").val();
				var description = $("#description").val();
				var obj = {
						"no": no,
						"action": action, 
						"planned": planned, 
						"description": description
				};
				console.log(obj);
				$.ajax({
					url: "/update",
					data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
					method: "POST", // HTTP 요청 메소드(GET, POST 등) 
					contentType: "application/json",
					success: function(result) {
						alert("수정하였습니다.");				
				    },
				    error: function(errorThrown) {
				        alert(errorThrown.statusText);				        
				    },
				});									
			});		

			/*글 삭제 관련 jquery */
			$("#deleteBtn").click(function(){
				var no = $(".hidden-input").val();
				var obj = {"no": no};
				console.log(obj);
				$.ajax({
					url: "/delete",
					data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
					method: "POST", // HTTP 요청 메소드(GET, POST 등) 
					contentType: "application/json",
					success: function(result) {
						alert("삭제하였습니다.");
						location.reload();
				    },
				    error: function(errorThrown) {
				        alert(errorThrown.statusText);				        
				    },
				});									
			});			
		});
	</script>
</body>
</html>

</layoutTag:layout>