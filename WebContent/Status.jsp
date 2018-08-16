<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		
		<title>Status</title>
		
		<script type="text/javascript">
	
			function closeWindow(){
		
				//刷新父窗口
				window.opener.location.href="UserServlet?actionType=select";
				//关闭当前窗口
				window.close();
			}
			
			function autoCloseWindow(){
		
				window.setTimeout("closeWindow()",2000);
			}
		</script>
	</head>
	
	<body onload="closeWindow()">
		${param.i!=1?"Failed":"Success" }!Close after 2s.
		<button onclick="closeWindow()">Close</button>
	</body>
</html>