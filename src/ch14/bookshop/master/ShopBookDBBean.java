package ch14.bookshop.master;

/*import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;*/
import java.sql.*;

/*import java.util.ArrayList;
import java.util.List;*/
import java.util.*;

/*import javax.naming.Context;
import javax.naming.InitialContext;*/
import javax.naming.*;

import javax.sql.DataSource;

import com.sun.org.apache.regexp.internal.recompile;

//DAO(Data Access Object): data 처리
public class ShopBookDBBean {
	
	//객체 생성(접근한정자로 인해 외부에서 생성 불가)
	private static ShopBookDBBean instance = new ShopBookDBBean();
	
	//메소드: 객체 호출(생성) 및 반환
	//single tone pattern: DB접속 시 마다 클레스 객체가 생성되어 메모리가 과부화(잠식)되는 것을 막기위해
	//메모리(메모리에 올라간 DB 접속객체)를 공유하는 방법
	public static ShopBookDBBean getInstance(){
		return instance;
	}
	
	//DBCP(Database Connection Poll) - apatch server상에 미리 생성하여 접속하는 node 수 제한
	//DB연동을 위한 Connection poll로부터 Connection object를 얻어내는 메소드
	//Connection poll: 미 사용 시 접속자마다 process 할당하여 과접속 시 시스템 다운
	private Connection getConnection() throws Exception{
		//아파치 서버의 server.xml파일내의 Context 객체 생성
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/jsp");
		return ds.getConnection();
	}
	
	//관리자 로인인 부분
	public int managerCheck(String id, String passwd) throws Exception{
		
		//DB접속 객체
		Connection conn = null;
		//(동적)쿼리입력 객체
		PreparedStatement pstmt = null;
		//결과값을 갖는 백터
		ResultSet rs = null;
		//결과처리를 위한 변수
		String dbpasswd = "";
		int x = -1;
		
		try{
			//DB연동 메소드 호출
			conn = getConnection();
			//동적쿼리: 입력받은 Id와 DB내 id값과 비교
			pstmt = conn.prepareStatement("select managerpasswd from manager where managerId=?");
			pstmt.setString(1, id);
			//쿼리 실행 결과를 rs에 적재
			rs = pstmt.executeQuery();
			
			//DB내 id값이 일치할 경우
			if(rs.next()){
				//DB에 있는 값을 가져옴
				dbpasswd = rs.getString("managerPasswd");
				
				if(dbpasswd.equals(passwd))
					x = 1; //x값을 1로 리턴, 인증성공
				else
					x = 0; //비밀번호 틀림
				} else
					x = -1; //해당 아이디 없음
			
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(rs!=null)
				rs.close();
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
		
		return x;
	}
		
	//책 등록 메소드(반환값 void: insertBook 호출 후 저장값이 없음)
	//book이라는 class객체(DTO)
	public void insertBook(ShopBookDataBean book) throws Exception {
		//DB사용 시(conn, pstmt or pst, result set)
		Connection conn = null;
		PreparedStatement pstmt = null;
		//ResultSet rs = null; //insert의 경우 필요 없음
		
		try{
			String sql ="insert into book values (?,?,?,?,?,?,?,?,?,?,?,?)";
			//conn객체를 통한 getConnection 호출
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			//getParameter DTO(임시기억장소)에 있는 값을 가져옴
			pstmt.setInt(1, book.getBook_id());
			pstmt.setString(2, book.getBook_kind());
			pstmt.setString(3, book.getBook_title());
			pstmt.setInt(4, book.getBook_price());
			pstmt.setShort(5, book.getBook_count());
			pstmt.setString(6, book.getAuthor());
			pstmt.setString(7, book.getPublishing_com());
			pstmt.setString(8, book.getPublishing_date());
			pstmt.setString(9, book.getBook_image());
			pstmt.setString(10, book.getBook_content());
			pstmt.setByte(11, book.getDiscount_rate());
			pstmt.setTimestamp(12, book.getReg_date());
			pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
	}

	//분류별 또는 전체 등록된 책의 정보를 얻어내는 메소드
	public List<ShopBookDataBean> getBooks(String book_kind) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ShopBookDataBean> bookList = null; //행 단위로 데이터를 저장하기 위한 vector
		
		//전체 검색과 세부 검색
		try{
			conn = getConnection();
			String sql1 = "select * from book";
			String sql2 = "select * from book where book_kind = ? order by reg_date desc";
			
			if(book_kind.equals("all")){
				pstmt = conn.prepareStatement(sql1);
			} else{
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1,  book_kind);
			}
			
			rs = pstmt.executeQuery();
			
			//rs에 데이타가 있을 경우
			if(rs.next()){
				bookList = new ArrayList<ShopBookDataBean>(); //<ShopBookDataBean>의 데이터 필드만이 저장가능한 arraylist 생성
				do{
					//접근하기 위한 객체 생성
					ShopBookDataBean book = new ShopBookDataBean();
					//DB 데이터를 DTO(임시기억장소)
					//index값 사용 가능 1,2,3,... book.setBook_id(rs.getInt(1));
					book.setBook_id(rs.getInt("book_id"));
					book.setBook_kind(rs.getString("book_kind"));
					book.setBook_title(rs.getString("book_title"));
					book.setBook_price(rs.getInt("book_price"));
					book.setBook_count(rs.getShort("book_count"));
					book.setAuthor(rs.getString("author"));
					book.setPublishing_com(rs.getString("publishing_com"));
					book.setPublishing_date(rs.getString("publishing_date"));
					book.setBook_image(rs.getString("book_image"));
					book.setDiscount_rate(rs.getByte("discount_rate"));
					book.setReg_date(rs.getTimestamp("reg_date"));
					
					//추가 적인 자료는 list에 add(첨가)??
					bookList.add(book);
					
				} while(rs.next());
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(rs!=null)
				rs.close();
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
		return bookList;
	}
	
	//DB내 등록된 책의 갯수를 얻어내는 메소드
	public int getBookCount() throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int x = 0;
		
		try{
			conn = getConnection(); //DB 연결
			pstmt = conn.prepareStatement("select count(*) from book"); //count(*): MySql 내장함수, 행의 수를 구함
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				//rs객체의 첫번째 인덱스 값
				x = rs.getInt(1); //count
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(rs!=null)
				rs.close();
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
		
		return x;
	}
	
	
	//book_id에 해당하는 책의 정보를 삭제하는 메소드
	public void deleteBook(int book_id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		//ResultSet rs = null;
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement("delete from book where book_id=?");
			pstmt.setInt(1, book_id);
			pstmt.executeUpdate();
			
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
	}
	
	//book_id에 해당하는 책의 정보를 얻어내는 메소드로
	//등록된 책을 수정하기 위해 수정폼으로 읽어들기이 위한 메소드
	public ShopBookDataBean getBook(int booK_id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ShopBookDataBean book = null;
		
		try{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from book where book_id = ?");
			pstmt.setInt(1, booK_id);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				
				book = new ShopBookDataBean(); //DTO에 저장
				book.setBook_kind(rs.getString("book_kind"));
				book.setBook_title(rs.getString("book_title"));
				book.setBook_price(rs.getInt("book_price"));
				book.setBook_count(rs.getShort("book_count"));
				book.setAuthor(rs.getString("author"));
				book.setPublishing_com(rs.getString("publishing_com"));
				book.setPublishing_date(rs.getString("publishing_date"));
				book.setBook_image(rs.getString("book_image"));
				book.setBook_content(rs.getString("book_content"));
				book.setDiscount_rate(rs.getByte("discount_rate"));
				
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(rs!=null)
				rs.close();
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
		return book;
	}
	
	

	//등록된 책의 정ㅂ로를 수정 시 사용하는 메소드
	public void updateBook(ShopBookDataBean book, int book_id) throws Exception{
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		//ResultSet rs = null;
		String sql = "";
		
		try{
			
			conn = getConnection();
			sql = "update book set book_kind=?, book_title=?, book_price=?, book_count=?, author=?, publishing_com=?, publishing_date=?, book_image=?, book_content=?, discount_rate=? where book_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, book.getBook_kind());
			pstmt.setString(2, book.getBook_title());
			pstmt.setInt(3, book.getBook_price());
			pstmt.setShort(4, book.getBook_count());
			pstmt.setString(5, book.getAuthor());
			pstmt.setString(6, book.getPublishing_com());
			pstmt.setString(7, book.getPublishing_date());
			pstmt.setString(8, book.getBook_image());
			pstmt.setString(9, book.getBook_content());
			pstmt.setByte(10, book.getDiscount_rate());
			pstmt.setInt(11, book_id);
			pstmt.executeUpdate();
			
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
	}
	
	
	//client단에서 사용하는분류별 또는 전체 등록된 책의 정보를 얻어내는 메소드
	public ShopBookDataBean[] getBooks(String book_kind, int count) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ShopBookDataBean bookList[] = null;
		int i = 0;
		
		try{
			conn = getConnection();
			String sql = "select * from book where book_kind = ? order by reg_date desc limit ?,?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, book_kind);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, count);
			rs = pstmt.executeQuery(); //sql 실행결과를 저장하는 백터: 필드값과 각 데이값이 모두 포함
			
			if(rs.next()){
				
				bookList = new ShopBookDataBean[count];
				
				do{
					
					ShopBookDataBean book = new ShopBookDataBean();
					
					book.setBook_id(rs.getInt("book_id")); //DB에 데이터가 없을 경우에도 테이블 필드값은 검색됨
					book.setBook_kind(rs.getString("book_kind"));
					book.setBook_title(rs.getString("book_title"));
					book.setBook_price(rs.getInt("book_price"));
					book.setBook_count(rs.getShort("book_count"));
					book.setAuthor(rs.getString("author"));
					book.setPublishing_com(rs.getString("publishing_com"));
					book.setPublishing_date(rs.getString("publishing_date"));
					book.setBook_image(rs.getString("book_image"));
					book.setDiscount_rate(rs.getByte("discount_rate"));
					book.setReg_date(rs.getTimestamp("reg_date"));
					
					bookList[i] = book; //i번쨰 검색결과를 bookList라는 배열의 i번째 입력
					i++;
					
				} while(rs.next());
			}
			
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(rs!=null)
				rs.close();
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
		return bookList;
	}
	
	//
	
	

}
