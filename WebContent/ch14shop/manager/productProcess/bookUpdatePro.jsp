<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
String realFolder = ""; //web Application상의 절대경로
String filename = "";
MultipartRequest imageUp = null;

String saveFolder = "./imageFile"; //파일이 업로드 되는 폴더
String encType = "utf-8"; //엔코딩 타입
int maxSize = 5*1024*1024; //5Mbyte

//현재 jsp페이지의 웹 어플리게션상의 절대경로를 구함
ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);

try{
	//객체 생성
	//전송을 담당할 콤포넌트를 생성하고 파일을 전송
	//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로, 최대 업로드될 파일 크기, 문자코드, 기본 보안 적용
	imageUp = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	//전송할 파일 정보를 가져와 출력한다.
	 Enumeration<?> files = imageUp.getFileNames();
	
	//파일정보가 있다면
	while(files.hasMoreElements()){
		//input 태그의 속성이 file인 태그의 name 속성값: 파라미터 이름
		String name = (String)files.nextElement();
	
	//서버에 저장된 파일 이름
	filename = imageUp.getFilesystemName(name);
	}
	
} catch(IOException e){
	System.out.println(e);
} catch(Exception e){
	e.printStackTrace();
}
%>
<jsp:useBean id="book" scope="page" class="ch14.bookshop.master.ShopBookDataBean"></jsp:useBean>
<%
int book_id= Integer.parseInt( imageUp.getParameter("book_id"));
String book_kind = imageUp.getParameter("book_kind");
String book_title = imageUp.getParameter("book_title");
String book_price = imageUp.getParameter("book_price");
String book_count = imageUp.getParameter("book_count");
String author = imageUp.getParameter("author");
String publishing_com = imageUp.getParameter("publishing_com");
String book_content = imageUp.getParameter("book_content");
String discount_rate = imageUp.getParameter("discount_rate");

String year = imageUp.getParameter("publishing_year");
String month = (imageUp.getParameter("publishing_month").length()==1)?
		 "0"+ imageUp.getParameter("publishing_month"): 
			 imageUp.getParameter("publishing_month");
String day =  (imageUp.getParameter("publishing_day").length()==1)?
		 "0"+ imageUp.getParameter("publishing_day"): 
			 imageUp.getParameter("publishing_day");

book.setBook_kind(book_kind);
book.setBook_title(book_title);
book.setBook_price(Integer.parseInt(book_price));
book.setBook_count(Short.parseShort(book_count));
book.setAuthor(author);
book.setPublishing_com(publishing_com);
book.setPublishing_date(year+"-"+month+"-"+day);
book.setBook_image(filename);
book.setBook_content(book_content);
book.setDiscount_rate(Byte.parseByte(discount_rate));
book.setReg_date(new Timestamp(System.currentTimeMillis()));

ShopBookDBBean bookprocess = ShopBookDBBean.getInstance();
bookprocess.updateBook(book, book_id); //DTO객체 와 book_id 전송

response.sendRedirect("bookList.jsp?book_kind="+book_kind);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
hello
</body>
</html>