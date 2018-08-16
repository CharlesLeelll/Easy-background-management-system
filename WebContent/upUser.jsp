<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>ModifyUser</title>
		
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="this is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	    
		<!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
		<style type="text/css">
		
			body{
				background: url("Values/wall.jpg");
			}
			.button {
				color: black;
				background: rgba(255, 255, 255, 0);
				width: 80px;
				height: 20px;
				border: 1px;
				font-weight: bold;
			}
			input {
				background: rgba(255, 255, 255, 0.4);
			}
			#div_0 {
				text-align: center;
				position: relative;
				margin: 0px auto;
				width: 260px;
			}
			#div_1 {
				text-align: right;
				float: left;
			}
			#div_2 {
				left: 30px;
				float: left;
			}
			span {
				height: 30px;
			}
			#button_img {
				width: 28px;
				height: 28px;
				background: rgb(255, 255, 255, 0);
				border: 0px;
				position: relative;
				left: -8px;
			}
			#div_img {
				position: absolute;
				top: 0px;
				overflow: hidden;
			}
			#showHiddPass{
				cursor: pointer;
				margin-top: 42px;
				margin-left: 225px;
		    	float: left;
		    	overflow: hidden;
		    	border-radius: 10px;
		    	position: absolute;
		    	height: 20px;
		    }
		    #eye {
		    	opacity:0.4;
		    	filter: alpha(opacity=40);
		    }
		</style>
		
		<script type="text/javascript">
			
			function showHiddPass(){
		    
				var pass = document.getElementsByName("pass")[0];
		    	var showHiddPass = document.getElementById("showHiddPass");
		    	var passType = pass.type;
		    	if(passType == "text"){
		    		pass.type = "password";
		    	}else{
		    		pass.type = "text";
		    	}
		    }
			
			function back() {
			
				history.back();
			}
		</script>
	</head>
  
	<body>
		<div id="div_0">
			<h1>Modify User.</h1><br>
		    <div id="div_1">
				<span>			</span><br />
				<span>Name:		</span><br />
				<span>Password:	</span><br />
				<span>Sex:		</span><br />
				<span>Age:		</span><br />
				<span>Address:	</span><br />
			</div>
		    <div id="div_2">	    
				<form action="UserServlet?actionType=update" method="post" >
					<span>	<input type="hidden" name="id" value="${requestScope.upUsers[0].id }" />		</span><br />
					<span>	<input type="text" name="name" value="${requestScope.upUsers[0].name }" />		</span><br />
					<span>	<input type="password" name="pass" value="${requestScope.upUsers[0].password }"></span><br />
			 		<span>	<input type="radio" name="sex" value="Male" ${requestScope.upUsers[0].sex == 'Male'?"checked='checked'":"" } />Male
			 				<input type="radio" name="sex" value="Female" ${requestScope.upUsers[0].sex == 'Female'?"checked='checked'":"" } />Female
			 		</span><br />
			 		<span><input type="text" name="age" value="${requestScope.upUsers[0].age }" />			</span><br />
					<span><input type="text" name="address" value="${requestScope.upUsers[0].address }" />	</span><br />
			    	
				<button type="submit" value="Modify" class="button">Modify</button>
				<button type="reset" value="Reset" class="button">Reset</button>
				</form>
			</div>
			<div  id="showHiddPass" onclick="showHiddPass()">
				<img alt="Eye" src="Values/Eye.jpg" id="eye" />
			</div>
		</div>
		<div id="div_img">
			<button onclick=back() id="button_img"><img src="Values/left.jpg" /s></button>
		</div>
	</body>
</html>
