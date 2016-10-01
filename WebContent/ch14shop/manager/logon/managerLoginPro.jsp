<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.master.ShopBookDBBean" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	//ShopBookDBBean instace 객체 생성
	ShopBookDBBean manager = ShopBookDBBean.getInstance();
	//ShopBookDBBean 클래스의 managerCheck method 호출
	int check = manager.managerCheck(id, passwd);
	
	//아이디/비밀번호 검증에 따른 세션 발급 여부 결정
	if (check==1){
		//인증 성공에 따른 세션 발급
		session.setAttribute("managerId", id);
		// . >> 현재 위치, .. >> 현 단계보다 한단계 상위
		response.sendRedirect("../managerMain.jsp");
	} else if(check==0) {
	%>
	
	<script>
	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);
	</script>
	
	<% } else{ %>
	
	<script>
	alert("해당 아이디가 존재하지 않습니다.");
	history.go(-1);
	</script>
	
	<%
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