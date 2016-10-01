<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../etc/color.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Book Shopping Mall</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<table>
	<tr>
		<td width="150" valign="top"> <!-- valign: 세로(vertical)정렬 -->
			<img src="../module/logo.png" border="0" width="150" height="120">
		</td>
		<td>
			<%-- <jsp:include page="../module/top.jsp"></jsp:include> >> action tag: forward, include, useBean --%>
			<jsp:include page="../module/top.jsp"/>
		</td>
	</tr>
	<tr>
		<td width="150" valign="top">
			<jsp:include page="../module/left.jsp"/>
		</td>
		<td>
			<jsp:include page="introList.jsp"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" width="700" align="center">
			<jsp:include page="../module/bottom.jsp"/>
		</td>
	</tr>


</table>

</body>
</html>