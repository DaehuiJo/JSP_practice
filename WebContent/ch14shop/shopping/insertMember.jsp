<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<form method="post" action="insertMemberPro.jsp" name="registForm">
		<table>
			<tr align="right">
				<td colspan="2"><a href="./main.jsp">main</a></td>
			</tr>
			<tr>
				<td width="60" bgcolor="back_c">아이디</td>
				<td width="300" bgcolor="value_c">
					<input type="text" name="id" value="">&nbsp;&nbsp;
					<input type="button" value="중복확인" onclick="idCheck(this)">
					<!-- <input type="button" name="Check" value="중복확인" onclick="idCheck(id.this)"> -->
				</td>
			</tr>
			<tr>
				<td width="60" bgcolor="back_c">암호</td>
				<td width="300" bgcolor="value_c"><input type="password" name="passwd" value=""></td>
			</tr>
			<tr>
				<td width="60" bgcolor="back_c">이름</td>
				<td width="300" bgcolor="value_c"><input type="text" name="name" value=""></td>
			</tr>
			<tr>
				<td width="60" bgcolor="back_c">등록일</td>
				<td width="300" align="left" ><select name="publishing_year">
						<%
					//현재 시스템 시간을 가져옴
					Timestamp nowTime = new Timestamp(System.currentTimeMillis());
					//가져온 시간을 4글자(연도)를 자름: substring?? tokenizer??
					int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
					
					for(int i = lastYear; i>2010; i--){
						%>
						<option value="<%=i %>"><%=lastYear %></option>

						<%
					}
				%>
				</select>년 <select name="publishing_month">
						<%
				int lastMonth = Integer.parseInt(nowTime.toString().substring(5,7));
				for(int i=1; i<=12; i++){
					%>
						<option value="<%=i %>" ><%=lastMonth %></option>

						<%
				}
			%>
				</select>월 <select name="publishing_day">
						<%
				int lastDay = Integer.parseInt(nowTime.toString().substring(8,10));
				
				for(int i=1; i<=31; i++){
					%>
						<option value="<%=i %>" ><%=lastDay %></option>

						<%
				}
			%>
				</select>일</td>
			</tr>
			<tr>
				<td width="60" bgcolor="back_c">주소</td>
				<td width="300" bgcolor="value_c"><input type="text" name="address" value=""></td>
			</tr>
			<tr>
				<td width="60" bgcolor="back_c">전화</td>
				<td width="300" bgcolor="value_c"><input type="text" name="tel" value=""></td>
			</tr>
			<tr align="center">
				<td colspan="2" bgcolor="value_c">
					<input type="submit" name="가입">
					<input type="reset" name="다시작성">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>