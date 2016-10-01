<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "../../../etc/color.jspf" %>

<%
String managerId = "";

try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")){
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} else{
		//삭제하려는 bookid와 종류?f를 받을 변수 설정
		int book_id = Integer.parseInt(request.getParameter("book_id")); //list(box??)에 저장될때는 형이 존재하지 않음
		String book_kind = request.getParameter("book_kind"); //list에 기본적으로는 String으로 저장???
		
		%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	</head>
	<body bgcolor="<%= bodyback_c %>">
	<p>책 삭제</p>
	<form method="post" action="bookDeletePro.jsp?book_id=<%=book_id %>&book_kind=<%=book_kind %>" onsubmit="return deleteSave()">
	<table>
		<tr height="30">
			<td align="right" bgcolor="<%=value_c %>"><a href="../managerMain.jsp">관리자 메인으로</a> &nbsp;
			<a href="bookList.jsp?book_kind=<%=book_kind %>">목록으로</a></td>
		</tr>
		<tr height="30">
			<td align="center" bgcolor="<%=value_c %>"><input type="submit" value="삭제"></td>
		</tr>
	</table>
	</form>
	
	</body>
	</html>		
		<%
	}
} catch(Exception e){
	e.printStackTrace();
}
%>