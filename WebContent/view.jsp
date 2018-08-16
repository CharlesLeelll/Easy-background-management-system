<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

		<title>Data View</title>
		
		<style type="text/css">
			body{
				background: url("Values/wall.jpg");
			}
			#div_0 {
				text-align: center;
				position: relative;
				width: 750px;
				min-height: 350px;
				margin: 0px auto;
				margin-top: 150px;
				padding:20px 0px;
				border: #ccc 2px solid;
				border-radius:10px;
				background-color: RGBA(236,233,216,0.5);
			}
			#table {
				border: 1px yellow solid;
				margin: 10px auto;
				width: 550px;
				text-align: center;
			}
			td,th,tr{
				border: 1px solid rgba(0, 0, 0, 0.3);
			}
			#nav *{
				display:inline-block;
				margin: 20px;
				height: 20px;
			}
			button {
				color: black;
				background: rgba(255, 255, 255, 0);
				width: 80px;
				height: 20px;
				border: 1px;
				font-weight: bold;
			}
			a {
				text-decoration: none;
				color: rbga(5, 5, 5, 0.8);
			}
		</style>
		
		<script type="text/javascript">
			
			function addUser() {
			
				var s_w = screen.width;//获得显示器的宽度
				var s_h = screen.height;//获得显示器的高度
				//console.log(s_w+"--->"+s_h);
				var w_w = 400; //窗口宽
				var w_h = 300; //窗口高
				//计算水平位置: 窗口的左上角的坐标
				var c_w = (s_w-w_w)/2;
				var c_h = (s_h-w_h)/2;
				window.open("addUser.html", "", "width=" + w_w + "px,height=" + w_h + "px,top=" + c_h + "" 
						+ "px,left=" + c_w + "px"); 
			}
			
			function upUser(id) {
			
				var s_w = screen.width;//获得显示器的宽度
				var s_h = screen.height;//获得显示器的高度
				//console.log(s_w+"--->"+s_h);
				var w_w = 400; //窗口宽
				var w_h = 300; //窗口高
				//计算水平位置: 窗口的左上角的坐标
				var c_w = (s_w-w_w)/2;
				var c_h = (s_h-w_h)/2;
				window.open("UserServlet?actionType=selforup&id=" + id, "", "width=" + w_w + "px,height=" + w_h + ""
						+ "px,top=" + c_h + "px,left=" + c_w + "px"); 
			}
			
			function delUser(id) {
			
				var tf = confirm('Are you sure del it?');
				if (tf) {
					//XMLHttpRequest表示异步请求对象: 可以实现页面不做任何跳转的情况下,向服务器发送请求.
					//创建异步请求对象
					var  XMLHttp=null;
					if (window.ActiveXObject){ //IE
						XMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
					} else if (window.XMLHttpRequest) {//NetSpace 火狐 欧鹏等
						XMLHttp = new XMLHttpRequest();
					}
					
					//创建请求
					XMLHttp.open("post", "UserServlet?actionType=delete", true);
					XMLHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
					
					//创建回调函数: 
					XMLHttp.onreadystatechange = function () {
					   if (XMLHttp.readyState == 4) { //服务器处理完成,并响应
							if (XMLHttp.status == 200) {//200表示服务器未报异常: 处理正常
								var  i = XMLHttp.responseText;//获得服务器响应的内容
								if (i != -1) {
									alert("Success!");
									delTag(id);
								} else {
									alert("Failed!");
								}
							}
					   }
					};
					//发送请求
					XMLHttp.send("id=" + id);
				}
			}
			
			function delTag(id) {
			
				var delTr = document.getElementById("t" + id);
				delTr.parentNode.removeChild(delTr);
			}
		</script>
	</head>

	<body>
		<div id="div_0">
			<span id="nav">
				<span>Account: ${sessionScope.nowUser}</span>
				<a href = UserServlet?actionType=select>
					<button value="View User" class="button">View User</button>
				</a>
				<a href="javascript:void(0)" onclick=addUser()>
					<button value="Add User" class="button">Add User</button>
				</a>
			</span>
			<table id="table">
				<tr>
					<th>ID</th><th>Name</th><th>Password</th><th>Sex</th><th>Age</th><th>Address</th><th>Action</th>
				</tr>
				<c:forEach items="${requestScope.allUsers }" var="user">
					<tr>
						<td>${user.id }</td>
						<td>${user.name }</td>
						<td>${user.password }</td>
						<td>${user.sex }</td>
						<td>${user.age }</td>
						<td>${user.address }</td>
						<td>
							<a href="javascript:void(0)" onclick="upUser(${user.id })">Modify</a>&nbsp;
							<a href="javascript:void(0)" onclick="return delUser(${user.id })">Delete</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</body>
</html>