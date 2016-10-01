<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");  %>
<%@ page import="ch14.bookshop.master.ShopBookDBBean" %>

<%
//값 받아오기
 int book_id = Integer.parseInt(request.getParameter("book_id"));
 String book_kind = request.getParameter("book_kind");

//DB처리
ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
bookProcess.deleteBook(book_id);
//화면 넘김
response.sendRedirect("bookList.jsp?book_kind="+book_kind);
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