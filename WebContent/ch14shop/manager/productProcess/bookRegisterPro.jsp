<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "ch14.bookshop.master.ShopBookDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<!-- 파일 업로드 시 사용되는 라이브러리 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<!-- 파일 업로드 시 보안 정책 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<!-- 인코딩 변환 -->
<% request.setCharacterEncoding("utf-8");%>

<%
  String realFolder = "";//웹 어플리케이션상의 절대 경로
  String filename ="";
  /* 멀티파트 리퀘스트의 객체 생성 */
  MultipartRequest imageUp = null; 

  String saveFolder = "./imageFile";//파일이 업로드되는 폴더를 지정한다.
  String encType = "utf-8"; //엔코딩타입
  int maxSize = 2*1024*1024;  //최대 업로될 파일크기 5Mb
  //현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
  ServletContext context = getServletContext();
  realFolder = context.getRealPath(saveFolder);  

  try{
     //전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
     //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
     imageUp = new MultipartRequest(
		 request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
   
     //전송한 파일 정보를 가져와 출력한다
     //제네릭??
     Enumeration<?> files = imageUp.getFileNames();
   
     //파일 정보가 있다면(파일 갯수 체크)
     while(files.hasMoreElements()){
       //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
       String name = (String)files.nextElement();
   
       //서버에 저장된 파일 이름
       filename = imageUp.getFilesystemName(name);
     }
  }catch(Exception e){
     e.printStackTrace();
  }
%>
<!-- DTO 사용설정: 파일 업로드 사용에 대한 DTO사용 방법 상이   -->
<jsp:useBean id="book" scope="page" 
       class="ch14.bookshop.master.ShopBookDataBean">
</jsp:useBean>

<%
  //DTO setter로 저장하기 전 입력받은 data값을 가져옴, imageUP: 파일 이름
  String book_kind = imageUp.getParameter("book_kind");
  String book_title = imageUp.getParameter("book_title");
  String book_price = imageUp.getParameter("book_price");
  String book_count = imageUp.getParameter("book_count");
  String author = imageUp.getParameter("author");
  String publishing_com = imageUp.getParameter("publishing_com");
  String book_content = imageUp.getParameter("book_content");
  String discount_rate = imageUp.getParameter("discount_rate");
  String year = imageUp.getParameter("publishing_year");
  //month의 자릿수가 일의 자리 또는 십의 자리에 따른 처리(삼항연산자) 분류
  String month = (imageUp.getParameter("publishing_month").length()==1)?
		  "0"+imageUp.getParameter("publishing_month"):imageUp.getParameter("publishing_month");
  String day = (imageUp.getParameter("publishing_day").length()==1)?
		  "0"+imageUp.getParameter("publishing_day"):imageUp.getParameter("publishing_day");
  
  //data값을 DTO Setter에 저장
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
  
  //DAO 객체 생성
  ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
  //DAO class 내 insert method 호출
  bookProcess.insertBook(book);
  
  //list page로 넘어감??
  response.sendRedirect("bookList.jsp?book_kind="+book_kind);

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	what's up.
</body>
</html>