<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>

<layoutTag:layout>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>미니 프로젝트</title>	
</head>
<body>
`	<!-- 화면 제목 및 검색 결과 출력 테이블 -->	
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
			        <tr style="border-top:3px solid #eee;">
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
						<!-- 숨겨진 값 두개(글 번호, 파일 유무)-->
						<input type="hidden" class="hidden-input" name="hiddenno">
						<input type="hidden" class="hidden-input" name="fileyn" id="fileyn">
						
						<div class="form-group">
					        <label for="action">수행업무</label>					        
					        <textarea class="form-control" id="action" name="action" rows="3" placeholder="수행업무를 입력하세요."></textarea>
				        </div>
				        <div class="form-group">
					        <label for="planned">예정업무</label>
					        <textarea class="form-control" id="planned" name="planned" rows="3" placeholder="예정업무를 입력하세요."></textarea>
				        </div>
				        <div class="form-group">
					        <label for="description">비고</label>					        
					        <textarea class="form-control" id="description" name="description" rows="3" placeholder="비고를 입력하세요."></textarea>
				        </div>
				        <div class="form-group">
					        <label for = "dateupdate">작성일자</label>
					        <input type="text" id="dateupdate" name="dateupdate" placeholder="날짜 넣기">	
				        </div>
				        <div class="form-group">
					        <label for="location">작성위치</label>					        
					        <textarea class="form-control" id="location" name="location" rows="2" readonly></textarea>
				        </div>		
				        <div class="form-group">
					        <label for="writer">작성자</label>					        
					        <textarea class="form-control" id="writer" name="writer" rows="1" readonly></textarea>
				        </div>		      
				        <div id="form-group">
				        	<label for="filename">첨부파일</label>
				        	<div id = "fileinfo">
				        		<!-- 숨겨진 값 (로컬 업로드 파일 이름)-->
				        		<p id = "filename"></p>
				        		<p id = "filerealname"></p>
				        		<i class="fas fa-times" id = "filedelete"></i>	
				        	</div>
				        	<input type="file" name="fileupdate" id="fileupdate" onchange="checkFile(this);">	      		
				        </div>
				        <div class="form-group">
				        	<div class = "imageupdate">
				        		<img id="imgupdate" src ="image/no.gif"/>
				        	</div>
				        </div>
					</div>
				</form>
				<!-- 모달 버튼 부분-->
				<div class="modal-footer">					
					<button type="button" class="btn btn-default" data-target="#myModal" id="returnBtn">뒤로가기</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal" id="deleteBtn">삭제</button>
					<button type="button" class="btn btn-primary" data-toggle="modal" id="updateBtn">수정</button>					
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
					        <label for = "Idescription">비고</label>
					        <textarea class="form-control" id="Idescription" name="Idescription" rows="3" placeholder="비고를 입력하세요."></textarea>
				        </div>
				        <div class="form-group">
					        <label for = "Idatepicker">작성일자</label>
					        <input type="text" id="Idatepicker" name="Idatepicker" placeholder="날짜 넣기">	
				        </div>
				        <div class="form-group">
				        	<label for=files">파일첨부</label>
				        	<input type="file" name="files" id="files" onchange="checkFile(this);">	        	
				        </div>
				        <div class="form-group">
				        	<div class = "image">
				        		<img id="img" src ="image/no.gif"/>
				        	</div>
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
	
	<!-- 설정 모달 -->	  
	<div class="modal fade" id="setupModal" role="dialog">
		<div class="modal-dialog">
	    	<!-- 모달 내용-->
	    	<div class="modal-content">
	    		<!-- 모달 헤더-->
		    	<div class="modal-header">		        	         
			        <h3 class="modal-title">알림 설정</h3>
		        </div>
		        <!-- 모달 내용부분-->
				<form>				
					<div class="modal-body">
						<div class="form-group">
					        <label for="alarm"><i class="fas fa-bell"></i> 알림 시간 설정</label>
							<div class="ui-timepicker-div">					        
					       		<input type="text" name="time" id="timepicker">
					       		<button type="button" class="btn btn-default" data-toggle="modal" id="timesetup">설정</button>
					       	</div>
				        </div>	
					</div>
				</form>		
				<!-- 모달 버튼 부분-->
				<div class="modal-footer">										
					<button type="button" class="btn btn-default" data-dismiss="modal" id="back">취소</button>						
		    	</div>
			</div>      
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
			
			var x = new Date();
			//datepicker 설정
			$("#datepicker,#Idatepicker, #dateupdate").datepicker({
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
		    $("#datepicker,#Idatepicker").datepicker("setDate", x);
			
		  	//timepicker text 현재 날짜로 세팅한다
		    $('#timepicker').timepicker({
		        timeFormat: 'HH:mm',
		        interval: 30,
		        minTime: '09',
		        maxTime: '22',
		        defaultTime: '17',
		        startTime: '09:00',
		        dynamic: false,
		        dropdown: false,
		        scrollbar: true
		    });

			//업무일지 조회 관련 jquery
			$("#searchdate").click(function(){
				var date = $("#datepicker").val();
				var obj = {"date": date};
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
				$.ajax({
					url: "/detail",
					data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
					method: "POST", // HTTP 요청 메소드(GET, POST 등) 
					contentType: "application/json",
					success: function(result) {						
						const {journal} = result;	
						const list = Object.values(journal);
						
						if(list[6] == "Y"){
							const {file} = result;
							const filelist = Object.values(file);
							
							console.log(filelist);						
							var img1 = "image";
							var img2 = filelist[2];
							var imgurl = img1.concat("/", img2);
							
							//파일 확장자 소문자로 체크함
							var fileext = imgurl.slice(imgurl.indexOf(".") + 1 ).toLowerCase();
							
							if(fileext != "jpg" && fileext != "png" && fileext != "jpeg" && fileext != "gif")
								$("#imgupdate").attr("src", "image/no.gif");
							else
								$("#imgupdate").attr("src", imgurl);
							
							$(".hidden-input").val(list[0]);	
							$("#dateupdate").val(list[1]);
							$("#action").val(list[3]);
							$("#planned").val(list[4]);
							$("#description").val(list[5]);
							$("#location").val(list[7]);
							$("#writer").val(list[8]);
							//yn이랑 name은 히든 value
							$("#fileyn").val(list[6]);	
							$("#filename").text(filelist[2]);
							
							$("#filerealname").text(filelist[3]);							
							
							$("#filerealname").css("display","inline");							
							$("#filedelete").css("display","inline");
							$("#fileupdate").css("display","none");
						}else{
							$(".hidden-input").val(list[0]);	
							$("#dateupdate").val(list[1]);
							$("#action").val(list[3]);
							$("#planned").val(list[4]);
							$("#description").val(list[5]);
							$("#fileyn").val(list[6]);	
							$("#location").val(list[7]);
							$("#writer").val(list[8]);
							
							$("#imgupdate").attr("src", "image/no.gif");
							
							$("#filerealname").css("display","none");
							$("#filedelete").css("display","none");
							$("#fileupdate").css("display","inline");
						}							
				    },
				    error: function(errorThrown) {
				        alert(errorThrown.statusText);
				    }
				});	
			});	   
			
	    	/* 업무일지 작성 관련 jquery */
			$("#insertBtn").click(function(){		
				$("#img").attr("src","image/no.gif");
				
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
				//필수 항목인 제목과 오늘 한일을 입력해야 ajax 통신 되도록 설계
				if(cnt == 2){
					//구글 geolocation api 메소드 호출
					navigator.geolocation.getCurrentPosition(function(pos){
						//var forAddress = document.getElementById("location_hidden");
						var latitude = pos.coords.latitude;
						var longitude = pos.coords.longitude;
						var geocoder = new google.maps.Geocoder();
						//geocoder를 사용하기 위해 변수를 선언하고 구글 맵 api에서 객체를 얻어옴
						
						var latlng = new google.maps.LatLng(pos.coords.latitude,
						pos.coords.longitude);
						//위도와 경도를 구글 맵스의 geocoder에서 사용할 형식으로 변환
						geocoder.geocode({'latLng' : latlng}, function(results, status){
							if (status == google.maps.GeocoderStatus.OK) {
								/*
								좌표를 주소로 변환 시키는 geocoder를 실행
								만약 성공적으로 변환이 되었다면, status라는 상태변수가 참이 되어 아래의 코드들이 실행됨
								*/
									if (results[1]) {
										
										var formData = new FormData();
										formData.append("Ititle", $("input[name=Ititle]").val());
										formData.append("Iaction", $("textarea[name=Iaction]").val());
										formData.append("Iplanned", $("textarea[name=Iplanned]").val());
										formData.append("Idescription", $("textarea[name=Idescription]").val());
										formData.append("Idatepicker", $("input[name=Idatepicker]").val());
										formData.append("files", $("input[name=files]")[0].files[0]);	
										formData.append("location", results[0].formatted_address);
										
										if($("input[name=files]")[0].files[0] == undefined){						
											formData.delete("files");
											var Ititle= $("#Ititle").val();
											var Iaction = $("#Iaction").val();
											var Iplanned = $("#Iplanned").val();
											var Idescription = $("#Idescription").val();
											var Idatepicker = $("#Idatepicker").val();
											var location = results[0].formatted_address;
											var obj = {		
													"title" : Ititle,
													"action": Iaction, 
													"planned": Iplanned, 
													"description": Idescription,
													"date" : Idatepicker,
													"location" : location
											};						
											$.ajax({
												url: "/insert",
												data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
												method: "POST", // HTTP 요청 메소드(GET, POST 등) 
												contentType: "application/json",
												success: function(result) {
													alert("등록하였습니다.");	
													
													$('#tablelist tbody').empty();
													$.each(result, function(){							
														$('#tablelist tbody').append("<tr data-toggle='modal' href='#myModal'><td>" 
																+ this.no
																+ "</td><td>" 
																+ this.title 
																+ "</td></tr>");
													});		
													clear();
											    },
											    error: function(errorThrown) {
											        alert("서버 문제 발생. 다시 시도 바람");				        
											    },
											});	
										}else{		
											$.ajax({
												url: "upload",
												type: "POST",
												data: formData,
												processData: false,
												contentType: false,
												cache: false,
												success: function(result) {
													alert("일지 등록 및 파일 업로드 성공!");	
													
													$('#tablelist tbody').empty();
													$.each(result, function(){							
														$('#tablelist tbody').append("<tr data-toggle='modal' href='#myModal'><td>" 
																+ this.no
																+ "</td><td>" 
																+ this.title 
																+ "</td></tr>");
													});	
													clear();
											    },
											    error: function(errorThrown) {
											    	alert("서버 문제 발생. 다시 시도 바람");				        
											    },
											});	
										}
									}
								} else {
									alert("Geocoder failed due to: " + status);				
								}
						});						
					});	
				}
			});

	    	/*글 수정 관련 jquery */
			$("#updateBtn").click(function(){
				var formData = new FormData();
				formData.append("fileupdate", $("input[name=fileupdate]")[0].files[0]);
				
				//구글 geolocation api 메소드 호출
				navigator.geolocation.getCurrentPosition(function(pos){
					//var forAddress = document.getElementById("location_hidden");
					var latitude = pos.coords.latitude;
					var longitude = pos.coords.longitude;
					var geocoder = new google.maps.Geocoder();
					//geocoder를 사용하기 위해 변수를 선언하고 구글 맵 api에서 객체를 얻어옴
					
					var latlng = new google.maps.LatLng(pos.coords.latitude,
					pos.coords.longitude);
					//위도와 경도를 구글 맵스의 geocoder에서 사용할 형식으로 변환
					
					geocoder.geocode({'latLng' : latlng}, function(results, status){
						if (status == google.maps.GeocoderStatus.OK) {
							if (results[1]) {
								if($("input[name=fileupdate]")[0].files[0] == undefined){
									var no = $(".hidden-input").val();
									var action = $("#action").val();
									var planned = $("#planned").val();
									var description = $("#description").val();
									var date = $("#dateupdate").val();
									var fileyn = $("#fileyn").val();
									var location = results[0].formatted_address;
									var obj = {
											"no": no,
											"action": action, 
											"planned": planned, 
											"description": description,
											"date" : date,
											"fileyn" : fileyn,
											"location" : location
									};					
									$.ajax({
										url: "/update",
										data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
										method: "POST", // HTTP 요청 메소드(GET, POST 등) 
										contentType: "application/json",
										success: function(result) {
											alert("수정하였습니다.");	
											$("#myModal").modal("toggle");											
									    },
									    error: function(errorThrown) {
									        alert(errorThrown.statusText);				        
									    },
									});							
							}else{
								formData.append("no", $("input[name=hiddenno]").val());
								formData.append("action", $("textarea[name=action]").val());
								formData.append("planned", $("textarea[name=planned]").val());
								formData.append("description", $("textarea[name=description]").val());
								formData.append("date", $("input[name=dateupdate]").val());
								formData.append("location", results[0].formatted_address);
								$.ajax({
									url: "/updateWithFile",
									type: "POST",
									data: formData,
									processData: false,
									contentType: false,
									cache: false,
									success: function(result) {
										alert("일지 수정 및 파일 업로드 성공!");
										$("#myModal").modal("toggle");
										$("#filerealname").css("display","inline");							
										$("#filedelete").css("display","inline");
										$("#fileupdate").css("display","none");
										$("#fileupdate").val("");
								    },
								    error: function(errorThrown) {
								    	alert("서버 문제 발생. 다시 시도 바람");				        
								    },
								});	
							}
							}
						}
					});	
				});
			});		

			/*글 삭제 관련 jquery */
			$("#deleteBtn").click(function(){
				var no = $(".hidden-input").val();
				var date = $("#dateupdate").val();
				var fileyn = $("#fileyn").val();
				var tr = $(".hidden-input").parent().parent();
				
				var obj = {
						"no": no,
						"date": date,
						"fileyn" : fileyn
				};
				$.ajax({
					url: "/delete",
					data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
					method: "POST", // HTTP 요청 메소드(GET, POST 등) 
					contentType: "application/json",
					success: function(result) {
						alert("삭제하였습니다.");
						
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
				    },
				});									
			});	
			
			/*파일 삭제 관련 jquery */
			$("#filedelete").click(function(){
				var name = $("#filerealname").text();
				var dname = $("#filename").text();
				var no = $(".hidden-input").val();
				var obj = {
						"fileName" : dname,
						"fileRealName" : name,
						"jno" : no
				};
				$.ajax({
					url: "/filedelete",
					data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
					method: "POST", // HTTP 요청 메소드(GET, POST 등) 
					contentType: "application/json",
					success: function(result) {
						alert("파일 삭제하였습니다.");
						$("#filerealname").css("display","none");
						$("#filedelete").css("display","none");
						$("#fileyn").val("N");	
						$("#imgupdate").attr("src","image/no.gif");
						$("#fileupdate").css("display","inline");						
				    },
				    error: function(errorThrown) {
				        alert(errorThrown.statusText);				        
				    },
				});									
			});	
			
			//이미지 썸네일 표출 쿼리
			//같은 헨들러를 여러 이벤트에 등록함
			$("#files,#fileupdate").on("change", function(event){
				//div 내용 비워주기
				$("#img,#imgupdate").css("display", "inline");				
				//파일의 정보들을 배열형태로 설정
				var files = event.target.files;
				var filesArr = Array.prototype.slice.call(files);				
				
				filesArr.forEach(function(file){
					//만약 파일의 타입이 이미지가 아니라면 for문 빠져나가게 설계
					if(!file.type.match("image.*")){
						$("#img,#imgupdate").attr("src", "image/no.gif");
						return;
					}					
					//비동기적으로 데이터를 저장할 수 있는 filereader 활용
					var reader = new FileReader();
					//읽기동작이 성공적으로 발생할때 마다 발생하도록 설계
					reader.onload = function(event){
						$("#img,#imgupdate").attr("src", event.target.result);
					}
					
					//지정된 blob의 내용을 화면에 출력
					reader.readAsDataURL(file);
				})				
			});
			
			
			
			/*취소 버튼 클릭시 화면 초기화 jquery */
			$("#cancel").click(function(){
				$("#Ititle").val("");
				$("#Iaction").val("");
				$("#Iplanned").val("");
				$("#Idescription").val("");
				$("#files").val("");
				$("#img").attr("src", "image/no.gif");
				$("#notitle").css("display","none");
				$("#noaction").css("display","none");
				$("#insertModal").modal("toggle");
			});		
	    	
			/*메인으로 돌아가기 버튼 클릭시 화면 초기화 jquery */
			$("#returnBtn").click(function(){
				$("#title").val("");
				$("#action").val("");
				$("#planned").val("");
				$("#description").val("");
				$("#fileupdate").val("");
				$("#filerealname").text("");
				$("#imgupdate").attr('src', '');
				$("#myModal").modal("toggle");
			});	  
			
			/* 추가하기 버튼 클릭시 요소를 전부 초기화 시킴 */
			$(".fa-plus").click(function(){
				$("#Ititle").val("");
				$("#Iaction").val("");
				$("#Iplanned").val("");
				$("#Idescription").val("");
				$("#files").val("");	
				$("#img").attr("src", "image/no.gif");
				$("#notitle").css("display","none");
				$("#noaction").css("display","none");			
			});
			
			/* 설정버튼 클릭시 설정 모달 나오도록 한다. */
			$(".fa-cog").click(function(){
				$("#setupModal").modal("toggle");
			});
			
			/* 설정버튼 클릭시 시간값을 서버에 보내도록 설정 */
			$("#timesetup").click(function(){
				var t = $("#timepicker").val();
				var str = t.split(':');
				console.log(str);
				var obj = {
						"hour": str[0],
						"minute" : str[1]
				};				
				$.ajax({
					url: "/timesetup",
					data: JSON.stringify(obj), // HTTP 요청과 함께 서버로 보낼 데이터
					method: "POST", // HTTP 요청 메소드(GET, POST 등) 
					contentType: "application/json",
					success: function(result) {
						alert("푸시 시간 설정 하였습니다.");	
						$("#setupModal").modal("toggle");
				    },
				    error: function(errorThrown) {
				        alert(errorThrown.statusText);				        
				    },
				});		
			});				
			
			/* 스위치 버튼 클릭시 화면 전환 설계 */
			var check = $("input[type='checkbox']");
			check.click(function(){
				$(".ui-timepicker-div").toggle();
			});
		});
		
		function checkFile(f){
			// files 로 해당 파일 정보 얻기.
			var file = f.files;			
			// 정규식으로 확장자 체크
			if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)) 
				alert('이미지 파일만 선택해 주세요.\n\n현재 파일 : ' + file[0].name);			
			else return;
			//체크에 걸리면 선택된  내용 취소 처리. 폼을 새로 써주는 방식으로 초기화
			f.outerHTML = f.outerHTML;
		}	
		
		function clear() {
			$("#Ititle").val("");
			$("#Iaction").val("");
			$("#Iplanned").val("");
			$("#Idescription").val("");
			$("#Idatepicker").val("");
			$("#files").val("");	
			$('#img').attr('src', '');
			$("#notitle").css("display","none");
			$("#noaction").css("display","none");
			$("#insertModal").modal("toggle");
		}		
	</script>
</body>
</html>

</layoutTag:layout>