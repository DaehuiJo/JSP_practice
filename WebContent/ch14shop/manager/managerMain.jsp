<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- css?? import -->
<%@ include file="../../etc/color.jspf" %>

<!-- session 유효 여부 확인:모든 웹페이지 처음에 입력!! -->
<%
	String managerId = "";

	try{
		//세션값 가져옴
		managerId = (String)session.getAttribute("managerId");
		
		//세션이 없거나 유효가 만료된 경우
		if(managerId == null || managerId.equals("")){
			response.sendRedirect("logon/managerLoginForm.jsp");
		} else{
			%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="logon/managerLogout.jsp">
	<b>관리 작업중</b><br>
	<input type="submit" value="로그아웃"><br><br>
	</form>
	<table>
		<tr>
			<td align="center" bgcolor="<%=bar %>">상품관련작업</td>
		</tr>
		<tr>
			<td><a href="productProcess/bookRegisterForm.jsp">상품등록</a></td>
		</tr>
		<tr>
			<!-- ?book_kind=all => book_kind의 모든 값(all, 설정값)을 가지고 넘어가겠다는 의미 -->
			<td><a href="productProcess/bookList.jsp?book_kind=all">상품수정/삭제</a></td>
		</tr>
	</table> <br><br>
	
	<table>
		<tr>
			<td align="center" bgcolor="<%=bar %>">구매된 상품관련 작업</td>
		</tr>
		<tr>
			<td><a href="orderdProduct/orderdList.jsp">전체 구매목록 확인</a></td>
		</tr>
	</table>

</body>
</html>		
			<%
	
		}
	} catch(Exception e){
		e.printStackTrace();
	}

%>