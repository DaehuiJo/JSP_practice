<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Manager Login Form</title>
</head>
<body>
	<h2>로그인 폼</h2>
	<form method="post" action="managerLoginPro.jsp">
		<p>아이디</p><input type="text" name="id" maxlength="50" style="ime-mode:inactive"><br>
		<p>비밀번호</p><input type="password" name="passwd" maxlength="16" style="ime-mode:inactive"><br><br>
		<input type="submit" value="관리자 로그인">
	</form>
</body>
</html>