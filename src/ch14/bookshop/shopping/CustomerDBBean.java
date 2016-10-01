package ch14.bookshop.shopping;

/*import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;*/
import java.sql.*;

/*import javax.naming.Context;
import javax.naming.InitialContext;*/
import javax.naming.*;

import javax.sql.DataSource;

public class CustomerDBBean {

	//DB 접속방법
	//1) 페이마다 로드하는 경우  2)single tone 생성
	//class method : 접근하기 위한 객체 생성 필요
	private static CustomerDBBean instance = new CustomerDBBean();
	
	// 1)의 방식 class for name?? driver load/ 접속 시 마다 connection이 발생하여 과부화 발생가능
	/*public CustomerDBBean(){
		CustomerDBBean instance = new CustomerDBBean();
	}*/
	
	// 2)의 방식: single tone pattern
	// static: 생성된 객체를 공유(메모리 공유??)
	public static CustomerDBBean getInstance(){
		return instance;
	}
	
	//connection pool 생성: DBCP 사용
	private Connection getConnection() throws Exception{
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env"); //DB접속 정의
		DataSource ds = (DataSource)envCtx.lookup("jdbc/jsp");
		return ds.getConnection();
	}
	
	
	//회원 가입
	public void insertMember(CustomerDataBean member) throws Exception{
		
		//객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		//ResultSet rs = null;
		
		try{
			conn = getConnection();
			//동적쿼리 쿼리 실행 후 동적으로 쿼리를 할당???
			pstmt = conn.prepareStatement("insert into member values(?,?,?,?,?,?)");
			
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, member.getReg_date());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getTel());
			
			pstmt.executeUpdate(); //select를 제외한 모든 DML은 update
			
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(pstmt!=null)
				pstmt.close();
			if(conn!=null)
				conn.close();
		}
		
	}
	
	//회원 중복 아이디 체크
	public int confirmId(String id) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement("select id from where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				x = 1; //해당 아이디 존재
			} else{
				x = -1; //해당 아이디 없음
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
	
	//client 로그인
	public int userCheck(String id, String passwd) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)){
					x = 1; //인증성공
				} else{
					x = 0 ; //비밀번호 틀림
				}
			} else{
				x = -1; //해당 아이디 없음
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
	
	
	//
}
