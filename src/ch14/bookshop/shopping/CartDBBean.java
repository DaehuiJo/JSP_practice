package ch14.bookshop.shopping;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class CartDBBean {

	//싱글톤(getInstance) 생성
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getInstance(){
		return instance;
	}
	
	private CartDBBean(){}
	
	//connection pool 생성
	private Connection getConnection() throws Exception{
		
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/jsp");
		
		return ds.getConnection();
	}
	
	
	//장바구니 추가
	public void insertCart(CartDataBean cart) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into cart (buyer, book_id, book_title, buy_price, buy_count, book_image) values(?,?,?,?,?,?)");
			pstmt.setString(1, cart.getBuyer());
			pstmt.setInt(2, cart.getCart_id());
			pstmt.setString(3, cart.getBook_title());
			pstmt.setInt(4, cart.getBuy_price());
			pstmt.setByte(5, cart.getBuy_count());
			pstmt.setString(6, cart.getBook_image());
			
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
	
	//id에 해당하는 레코드의 수를 얻어내는 메소드
	public int getListCount(String id) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		//System.out.println(id);
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from cart where buyer=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			//System.out.println("x = " + x);
			if(rs.next()){
				x = rs.getInt(1);
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
	
	//id에 해당하는 레코드의 목록을 얻어내는 메소드
    public List<CartDataBean> getCart(String id) throws Exception{
    	
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	CartDataBean cart = null;
    	List<CartDataBean> lists = null;
    	
    	try{
    		
    		conn = getConnection();
    		pstmt = conn.prepareStatement("select * from cart where buyer = ?");
    		
    		pstmt.setString(1, id);
    		rs = pstmt.executeQuery();
    		
    		lists = new ArrayList<CartDataBean>();
    		
    		while(rs.next()){
    			cart = new CartDataBean();
    			
    			cart.setCart_id(rs.getInt("cart_id"));
    			cart.setBook_id(rs.getInt("book_id"));
    			cart.setBook_title(rs.getString("book_title"));
    			cart.setBuy_price(rs.getInt("buy_price"));
    			cart.setBuy_count(rs.getByte("buy_count"));
    			cart.setBook_image(rs.getString("book_image"));
    			
    			lists.add(cart); // remove:
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
    	return lists;
    }
    
    //cart_id에 대한 각 레코드를 삭제
    public void deleteList(int cart_id) throws Exception{
    	
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	System.out.println(cart_id);
    	
    	try{
    		conn = getConnection();
    		pstmt = conn.prepareStatement("delete from cart where cart_id = ?");
    		pstmt.setInt(1, cart_id);
    		
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
    
    //id에 해당하는 모든 레코드를 삭제하는 메소드
    public void deleteAll(String id) throws Exception {
    	
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	
    	try{
    		conn = getConnection();
    		pstmt = conn.prepareStatement("delete from cart where buyer = ?");
    		pstmt.setString(1, id);
    		
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
    
    //
}
