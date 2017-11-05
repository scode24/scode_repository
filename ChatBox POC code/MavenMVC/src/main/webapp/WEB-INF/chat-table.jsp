<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.MongoClient"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<ul id="box" style="list-style: none; padding: 0px; text-align: left;">
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
			<div style="background-color: #F3FEF3; margin: 4px; padding: 3px;">
				<div>
				hello
					<small>&nbsp;&nbsp;<b>${greeting}</b></small>
				</div>
				<div style="margin-bottom: 10px; margin-top: 3px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small><%=o.get("message")%></small>
				</div>
				<div style="text-align: right;">
					<small><%=o.get("time")%></small>
				</div>
			</div> <%
 	}
 	} catch (Exception e) {
 		out.print(e.getMessage());
 	}
 %>
		
	</ul>

</body>
</html>