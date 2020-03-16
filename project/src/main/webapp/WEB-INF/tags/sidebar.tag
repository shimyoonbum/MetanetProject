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
	    </div>
	</div>
</header>	
	
<div id="mySidenav" class="sidenav">	
   	<div class="cancel">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		
		<a href="/insert" class = "menu">  				
			<i class="fas fa-pencil-alt"></i> 업무일지작성
		</a>
	    
	    <a href="/list" class = "menu">
	    	<i class="fas fa-tasks"></i> 업무일지관리
	    </a>
	</div>  	
</div> 
	
<script type="text/javascript">		
	/* 사이드 네비게이션 바 */
	function openNav() {
		document.getElementById("mySidenav").style.width = "270px";
	}

	function closeNav() {
		document.getElementById("mySidenav").style.width = "0";
	}
</script> 
