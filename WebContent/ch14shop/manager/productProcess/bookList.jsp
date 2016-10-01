<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %> 
<!-- select 문 실행 -->
<%@ page import="ch14.bookshop.master.ShopBookDBBean, ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import="java.util.List" %>
<%@ include file="../../../etc/color.jspf" %>

<%
String managerId = "";
try{
	managerId = (String)session.getAttribute("managerId");
	
	if(managerId==null||managerId.equals("")){
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} else{ //세션이 유효한 경우
		%> <!-- 스크립트 릿:지역변수 -->
		<%! /* 디클레이션: 전역변수 */
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		%>
		
		<%
		/* object - > collection -> 제네릭 선언  */
		/* <ShopBookDataBean> => DTO(Data Transfor Object), VO(Value Object), Beans */
		List<ShopBookDataBean> bookList = null;
		
		int number = 0;
		
		String book_kind ="";
		
		book_kind = request.getParameter("book_kind");
		/* select를 사용하여 book_kind값을 표현?? */
		/* DataBase 접속을 위해 DAO에 작성해 둔  */
		ShopBookDBBean bookProcess = ShopBookDBBean.getInstance(); //single tone: class object생성 방법
		/* 접속자마다 객체를 생성하는 것이 아닌 생성된 객체를 공유(최소 생성시 메모리에 올라간 메소드를 사용시에만 할당_접근)하는 방법  */
		
		
		int count = bookProcess.getBookCount();
		
		if(count > 0){
			// DAO 내 method 호출
			bookList = bookProcess.getBooks(book_kind);
		}
		%>
		
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link href="../../../etc/style.css" rel="stylesheet" type="text/css">
	</head>
	<body>
 	
 	<body bgcolor="<%=bodyback_c %>">
 	<%
 	String book_kindName = "";
 	if(book_kind.equals("100")){
 		book_kindName = "문학";
 	} else if(book_kind.equals("200")){
 		book_kindName = "외국어";
 	} else if(book_kind.equals("300")){
 		book_kindName = "컴퓨터";
 	} else if(book_kind.equals("all")){
 		book_kindName = "전체";
 	}
 	
 	%>
 	<a href="../managerMain.jsp">관리자 메인으로</a><br>
 	<p><%= book_kindName %> 전체분류의 목록:
 	<%
 	if(book_kind.equals("all")){ /* 전체갯수 */
 		%> <%=count %>개 <br><%
 	} else{%>
 		<%=bookList.size() %>개 <!-- arrayList의 항목 갯수  -->
 		<%
 	}
 	
 	%>
 	</p>
 	
 	<table>
 		<tr>
 			<td align="right" bgcolor="<%=value_c%>"><a href="bookRegisterForm.jsp">책 등록</a></td>
 		</tr>
 	</table>
 	<%
 	if(count==0){
 	%>
 	<table>
 		<tr>
 			<td align="center">등록된 책이 없습니다.</td>
 		</tr>
 	</table>
 	<%} else{ %>
 	<table>
 		<tr>
 			<td align="center" width="30">번호</td>
 			<td align="center" width="30">책분류</td>
 			<td align="center" width="100">제목</td>
 			<td align="center" width="50">가격</td>
 			<td align="center" width="50">수량</td>
 			<td align="center" width="70">저자</td>
 			<td align="center" width="100">출판사</td>
 			<td align="center" width="100">출판일</td>
 			<td align="center" width="100">책이미지</td>
 			<td align="center" width="100">할인율</td>
 			<td align="center" width="100">등록일</td>
 			<td align="center" width="50">수정</td>
 			<td align="center" width="50">삭제</td>
 		</tr>
 		
 		<%
 		for(int i=0; i<bookList.size(); i++){
 			/* DTO 값을 형변환?? */
 			ShopBookDataBean book = (ShopBookDataBean)bookList.get(i); //booklist의 행벼 데이터를 가져옴
 			%>
 			<tr>
 				<td><%=++number %></td>
 				<td><%=book.getBook_kind() %></td>
 				<td><%=book.getBook_title() %></td>
 				<td><%=book.getBook_price() %></td>
 				<td><%=book.getBook_count() %></td>
 				<td><%=book.getAuthor() %></td>
 				<td><%=book.getPublishing_com() %></td>
 				<td><%=book.getPublishing_date() %></td>
 				<td><%=book.getBook_image() %></td>
 				<td><%=book.getDiscount_rate() %></td>
 				<td><%=sdf.format(book.getReg_date()) %></td>
 				<td><a href="bookUpdateForm.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind()%>">수정</a></td>
 				<td><a href="bookDeleteForm.jsp?book_id=<%=book.getBook_id()%>&book_kind=<%=book.getBook_kind()%>">삭제</a></td>	
 			</tr>
 			
 			<%
 		}
 		
 		
 		%>
 	</table><br>
		<a href="../managerMain.jsp"> 관리자 메인으로</a> 
	</body>
	</html>
		
		<%
		}
 	}
} catch(Exception e){
	e.printStackTrace();
} 
%>
