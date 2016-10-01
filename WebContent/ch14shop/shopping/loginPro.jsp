<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.shopping.CustomerDBBean" %>
<% request.setCharacterEncoding("utf-8"); %>

<%

String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

CustomerDBBean custom = CustomerDBBean.getInstance();

int check = custom.userCheck(id, passwd);

if(check==1){
	session.setAttribute("id", id);
	response.sendRedirect("shopMain.jsp");
} else if(check==0){
	%>
	<script>
		alert('비밀번호 틀림');
		history.go(-1);
	</script>
	<%
} else{
	%>
	<script>
		alert('없는 아이디');
		history.go(-1);
	</script>
	<%
}
%>
<!-- 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html> -->