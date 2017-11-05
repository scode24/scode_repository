<!DOCTYPE html>

<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.DB"%>
<%@page import="com.mongodb.MongoClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="utf-8">
<title>Welcome</title>


</head>
<body>
	<h2>${message}</h2>
	<table>
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
						<tr><td><%= o.get("message") %></td></tr>
					<%
					
				}
		} catch (Exception e) {
			out.print(e.getMessage());
		}
	%>
</table>

	<form action="/MavenMVC/send">
		<input type="text" name="chatBox" /> <input type="submit"
			value="Send" />
	</form>
</body>
</html>