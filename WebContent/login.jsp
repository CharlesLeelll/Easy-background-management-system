<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Login</title>
	
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="this is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	
		<!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
		<style type="text/css">
			
			body{
				background: url("Values/wall.jpg");
			}
		    #div_0 {
				text-align: center;
				position: relative;
				margin: 20% auto;
				width: 300px;
			}
		    input {
				background: rgba(255, 255, 255, 0.4);
			}
			button {
				color: black;
				background: rgba(255, 255, 255, 0);
				width: 80px;
				height: 25px;
				border: 1px;
				font-weight: bold;
			}
			#div_1 {
				text-align: right;
				float: left;
			}
			#div_2 {
				left: 30px;
				float: left;
			}
			#div_3 {
				float: left;
				position: relative;
				left: 270px;
				top: -70px;
			}
			span {
				height: 30px;
			}
	    </style>
	    
	    <script type="text/javascript">
	    	
	    	function show() {
	    		
	    		var img = document.getElementById("img");
	    		img.src = "/Tomcat/VCodeServlet?" + new Date().getTime();
	    	}
	    </script>
	</head>
  
	<body>
		<div id="div_0">
			<div id=div_1>
				<span></span><br />
				<span>Account:</span><br />
				<span>Password:</span><br />
				<span class="vc">Verify Code:</span>
			</div>
			<div id=div_2>
				<form action="UserServlet?actionType=login" method="post">
					<span>${empty sessionScope.error?"":sessionScope.error}</span><br />
					<span><input type="text" name="name" /></span><br />
					<span><input type="password" name="pass" /></span><br />
					<span><input type="text" name="invcode" /></span><br />
					<button type="submit" value="Login">Login</button>
					<button type="reset" value="Reset">Reset</button>
				</form>
			</div>
			<div id="div_3">
				<img alt="vc" src="/Tomcat/VCodeServlet" id="img" onclick="show()">
			</div>
		</div>
	</body>
</html>
