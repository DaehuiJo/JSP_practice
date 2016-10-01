<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../etc/color.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<%
try{
	if(session.getAttribute("id")==null||session.getAttribute("id").equals("")){
		%>
		<a href="../shopping/list.jsp?book_kind=all">전체목록보기</a>&nbsp;
		<br><br>
		<form name="inform" method="post" action="loginPro.jsp">
			아이디: <input type="text" name="id" size="15" maxlength="50">&nbsp;
			비밀번호: <input type="password" name="passwd" size="15" maxlength="16">&nbsp;&nbsp;
			<input type="submit" name="Sunmit" value="로그인">
		</form><br>
		<font color="red">★반드시 로그인을 하셔야 쇼핑을 하실 수 있습니다.★</font>
		<%} else{%>
		<a href="../shopping/list.jsp?book_kind=all">전체목록보기</a>&nbsp;
		<a href="../shopping/cartList.jsp?book_kind=all">장바구니보기</a>&nbsp;
		<a href="../shopping/buyList.jsp">구매목록보기</a>&nbsp;<br><br>
		<b><%=session.getAttribute("id")%></b> 님 즐거운 쇼핑시간이 되세요.
		<input type="button" value="로그아웃" onclick="javascript:window.location='../shopping/logout.jsp'">
		<%
	}
} catch(Exception e){
	e.printStackTrace();
}

%>
</body>
</html>