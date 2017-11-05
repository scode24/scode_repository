<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.MongoClient"%>
<%@ page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>ChatBox</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	/* $(document).ready(function(){
	 refreshTable();
	 });

	 function refreshTable(){
	 $('#chatDiv').load('chat-table.jsp', function(){
	 setTimeout(refreshTable, 5000);
	 });
	 } */
	/* 
	 $(document).ready(function () {
	 var seconds = 5000; // time in milliseconds
	 var reload = function() {
	 $.ajax({
	 type : "GET",
	 url : "http://localhost:8080/MavenMVC/getTable",
	 cache : false,
	 success : function(data) {
	 $("#chatDiv").append(data);
	 setTimeout(function() {
	 reload();
	 }, 5000);
	 }
	 });
	 });  */

	$(document).ready(function() {
		var seconds = 5000; // time in milliseconds
		var reload = function() {
			$.ajax({
				type : "GET",
				url : "http://192.168.0.9:8999/MavenMVC/getTable",
				cache : false,
				success : function(data) {
					//alert("hello");

					$('#chatDiv').html(data);
					var box = document.getElementById("chatDiv");
					box.scrollTop = box.scrollHeight - box.clientHeight;
					//alert(box.scrollHeight );
					setTimeout(function() {
						reload();
					}, seconds);
				}
			});
		};
		reload();
	});

	/* function updateDiv()
	 {
	 $("#chatDiv").load(window.location.href+"#chatDiv");	
	 }

	 var refreshId = setInterval(updateDiv, 5000); */
</script>
<style>
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
	width: 600px;
	padding: 4% 0 0;
	margin: 5 auto 20 auto;
}

.form {
	position: relative;
	z-index: 1;
	background: #FFFFFF;
	max-width: 600px;
	margin: 0 auto 100px;
	padding: 45px;
	text-align: center;
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0
		rgba(0, 0, 0, 0.24);
}

.form input {
	font-family: "Roboto", sans-serif;
	outline: 0;
	background: #f2f2f2;
	width: 100%;
	border: 0;
	margin: 0 0 0;
	padding: 15px;
	box-sizing: border-box;
	font-size: 14px;
}

.form button {
	font-family: "Roboto", sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #4CAF50;
	width: 100%;
	border: 0;
	padding: 15px;
	color: #FFFFFF;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
	cursor: pointer;
}

.form button:hover, .form button:active, .form button:focus {
	background: #43A047;
}

.form .message {
	margin: 15px 0 0;
	color: #b3b3b3;
	font-size: 12px;
}

.form .message a {
	color: #4CAF50;
	text-decoration: none;
}

.form .register-form {
	display: none;
}

.container {
	position: relative;
	z-index: 1;
	max-width: 300px;
	margin: 0 auto;
}

.container:before, .container:after {
	content: "";
	display: block;
	clear: both;
}

.container .info {
	margin: 50px auto;
	text-align: center;
}

.container .info h1 {
	margin: 0 0 15px;
	padding: 0;
	font-size: 36px;
	font-weight: 300;
	color: #1a1a1a;
}

.container .info span {
	color: #4d4d4d;
	font-size: 12px;
}

.container .info span a {
	color: #000000;
	text-decoration: none;
}

.container .info span .fa {
	color: #EF3B3A;
}

body {
	background: #76b852; /* fallback for old browsers */
	background: -webkit-linear-gradient(right, #76b852, #8DC26F);
	background: -moz-linear-gradient(right, #76b852, #8DC26F);
	background: -o-linear-gradient(right, #76b852, #8DC26F);
	background: linear-gradient(to left, #76b852, #8DC26F);
	font-family: "Roboto", sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}
</style>

<script type="text/javascript">
	$(function() {
		setTimeout(function() {
			$('#chatDiv').show(); // to show div after 5 sec of page load

			// To reshow on every one minute
			setInterval(function() {
				$('#chatDiv').show();
			}, 60000);
		}, 5000);
	});
</script>

</head>

<body>
	<div class="login-page">
		<div class="form">
			<form class="register-form">
				<input type="text" placeholder="name" /> <input type="password"
					placeholder="password" /> <input type="text"
					placeholder="email address" />
				<button>create</button>
				<p class="message">
					<%
						String url = "http://" + request.getLocalAddr() + ":8999/Maven/register";
					%>
					Already registered? <a href=<%=url%>>Sign In</a>
				</p>
			</form>
			<form class="login-form" action="/MavenMVC/send" method="post">
				<h2>Hey ${greeting}..let's chat</h2>
				<p></p>
				<div id="chatDiv" style="overflow-y: auto; height: 350px;">
					<%-- <ul style="list-style: none; padding:0px; text-align: left;  overflow-y:scroll; height:350px;">
						<%
							try {

								MongoClient client = new MongoClient("192.168.0.9", 27017);
								DB db = client.getDB("CHAT");
								DBCollection coll = db.getCollection("msg");
								//out.print(coll);
								DBCursor cursor = coll.find();
								//out.print(cursor.count());

								while (cursor.hasNext()) {
									DBObject o = cursor.next();
						%>
						<li>
							<div style="background-color: #F3FEF3; margin:4px; padding:3px;">
								<div><small>&nbsp;&nbsp;<b>${greeting}</b></small></div>
								<div style="margin-bottom:10px; margin-top: 3px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small><%=o.get("message")%></small></div>
								<div style="text-align: right;"><small><%=o.get("time")%></small></div>															
							</div>

						<%
							}
							} catch (Exception e) {
								out.print(e.getMessage());
							}
						%>
					</ul> --%>
				</div>




				<table style="width: 500;">
					<tr>
						<td><input type="text" placeholder="Your message"
							name="msgBox" /></td>
						<td><button>Send</button></td>
					</tr>
				</table>
<%-- 				<%
					String ip1 = request.getRemoteAddr();
					if (ip1.equalsIgnoreCase("0:0:0:0:0:0:0:1")) {
						InetAddress inetAddress = InetAddress.getLocalHost();
						String ipAddress = inetAddress.getHostAddress();
						ip1 = ipAddress;
					}
				%> --%>

				<p class="message">
					<a href='<%="http://192.168.0.9:8999/MavenMVC/logout"%>'>Logout</a>
				</p>

			</form>

			<script type="text/javascript">
				//alert("hi...");
				//var box = document.getElementById("chatDiv");
				//alert(box.scrollHeight );
				//box.scrollTop = 500;
			</script>

		</div>
	</div>



</body>
</html>
