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
