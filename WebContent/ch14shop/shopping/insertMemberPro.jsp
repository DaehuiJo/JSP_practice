<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.shopping.CustomerDBBean, ch14.bookshop.shopping.CustomerDataBean" %>
<%@ page import="java.sql.Timestamp"%>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="member" class="ch14.bookshop.shopping.CustomerDataBean">
	<jsp:setProperty name="member" property="*"/>
</jsp:useBean>

<%
member.setReg_date(new Timestamp(System.currentTimeMillis()));
CustomerDBBean data = CustomerDBBean.getInstance();
data.insertMember(member);
response.sendRedirect("./main.jsp");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
야로
</body>
</html>