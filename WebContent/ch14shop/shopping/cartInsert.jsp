<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- bookContent.jsp 에서 넘어온 데이터를 받음 -->
<% request.setCharacterEncoding("utf-8"); %>
<!-- DAO import -->
<!-- jsp:useBean >> DAO의 모든 항목(book table의 12가지 속성)을 사용(setProperty)하지 않고 선택적인 항목만을 사용함로 파라미터 값을 설정하여 사용 -->
<!-- 이전 페이지의 form에서 입력되지 않은 속성의 데이터는 null값이 입력되는 것이 아니라 無인 상태 -->
<%@ page import ="ch14.bookshop.shopping.CartDBBean" %>

<%
//DB 내 book table를 사용하지 않음
String book_kind = request.getParameter("book_kind");
String buy_count = request.getParameter("buy_count");
String book_id = request.getParameter("book_id");
String book_title = request.getParameter("book_title");
String book_image = request.getParameter("book_image");
String buy_price = request.getParameter("buy_price");
String buyer = (String)session.getAttribute("id");

%>
<!-- DB내 cart table을 useBean을 사용하여 접근 -->
<jsp:useBean id="cart" scope="page" class="ch14.bookshop.shopping.CartDataBean"/>

<%
cart.setBook_id(Integer.parseInt(book_id));
cart.setBook_image(book_image);
cart.setBook_title(book_title);
cart.setBuy_count(Byte.parseByte(buy_count));
cart.setBuy_price(Integer.parseInt(buy_price));
cart.setBuyer(buyer);

//DAO 접근
CartDBBean bookProcess = CartDBBean.getInstance();
bookProcess.insertCart(cart);
response.sendRedirect("cartList.jsp?book_kind="+book_kind);
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