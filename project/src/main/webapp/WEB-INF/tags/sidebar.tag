<%@ tag language="java" pageEncoding="EUC-KR"%>

<header>
	<div id='container'>
	    <div id='box-left'>	    	
	    	<span style="font-size:30px; cursor:pointer; color:white" onclick="openNav()">
	    		&#9776;
	    	</span>	    	 	
	    </div>
	    <div id='box-center'>
	    	<span>
	    		<img src="/image/logo.png" width="120px" height="50px" alt="회사 로고"/>
	    	</span>
	    </div>
	    <div id='box-right'>
	    	<span>
	    		<i class="fas fa-cog"></i>
	    	</span>		    
	    </div>
	</div>
	
	<div id="mySidenav" class="sidenav">
		
		<div class="pro" style="margin-left : 30px;">
			<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
				
			<div>			
				<img id="imgprofile"/>			
			</div>
			
			<p style="font-weight:900;font-size:30px;" id="name"></p>
			<p style="font-weight:500;font-size:15px;" id="email"></p>
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
</header>	
	
<script type="text/javascript">		
	/* 사이드 네비게이션 바 */
	function openNav() {
		document.getElementById("mySidenav").style.width = "270px";
	}

	function closeNav() {
		document.getElementById("mySidenav").style.width = "0";
	}
</script> 
