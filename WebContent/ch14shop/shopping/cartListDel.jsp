<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="ch14.bookshop.shopping.CartDBBean" %>
<%@ include file = "../../etc/color.jspf" %>

<%
String list = request.getParameter("list");
String buyer = (String)session.getAttribute("id");
String book_kind = request.getParameter("book_kind");

if(session.getAttribute("id")==null||session.getAttribute("id").equals("")){
	response.sendRedirect("shopMain.jsp");
} else{
	CartDBBean bookProcess = CartDBBean.getInstance();
	   
	if(list.equals("all"))
	   bookProcess.deleteAll(buyer);
	else
	   bookProcess.deleteList(Integer.parseInt(list));
	
	response.sendRedirect("cartList.jsp?book_kind=" + book_kind);
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>