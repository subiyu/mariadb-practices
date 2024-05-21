package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import bookmall.vo.OrderBookVo;
import bookmall.vo.OrderVo;

public class OrderDao {
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");			
			//String url = "jdbc:mariadb://192.168.0.193:3306/bookmall?charset=utf8";
			String url = "jdbc:mariadb://192.168.35.55:3306/bookmall?charset=utf8";
			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
		} catch(ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패: " + e);
		}
		
		return conn;
	}

	public int insert(OrderVo vo) {
		int result = 0;
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt1 = conn.prepareStatement("INSERT INTO orders(user_no, order_number, payment, shipping, status) VALUES(?, ?, ?, ?, ?)");
			PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
		) {
			pstmt1.setLong(1, vo.getUserNo());
			pstmt1.setString(2, vo.getNumber());
			pstmt1.setInt(3, vo.getPayment());
			pstmt1.setString(4, vo.getShipping());
			pstmt1.setString(5, vo.getStatus());
			result = pstmt1.executeUpdate();
			
			ResultSet rs = pstmt2.executeQuery();
			vo.setNo(rs.next() ? rs.getLong(1) : null);
			rs.close();
		} catch(SQLException e) {
			System.out.println("error: " + e);
		} 
		
		return result;
	}

	public int insertBook(OrderBookVo vo) {
		int result = 0;
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt1 = conn.prepareStatement("INSERT INTO orders_book(order_no, book_no, quantity, price) VALUES(?, ?, ?, ?)");
			PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
		) {
			pstmt1.setLong(1, vo.getOrderNo());
			pstmt1.setLong(2, vo.getBookNo());
			pstmt1.setInt(3, vo.getQuantity());
			pstmt1.setInt(4, vo.getPrice());
			result = pstmt1.executeUpdate();
		} catch(SQLException e) {
			System.out.println("error: " + e);
		} 
		
		return result;
	}

	public OrderVo findByNoAndUserNo(long orderNo, Long userNo) {
		OrderVo result = null;		//test code(testOrder())에서 assertNull 검사를 하므로, 매칭되는 값이 없으면 null을 반환해야한다.
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT no, user_no, order_number, payment, status, shipping "
															+ "FROM orders "
															+ "WHERE no = ? "
															+ "AND user_no = ?");
		) {
			pstmt.setLong(1, orderNo);
			pstmt.setLong(2, userNo);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = new OrderVo();		 // 매칭되는 값이 존재하면 객체 생성
				Long no = rs.getLong(1);
				userNo = rs.getLong(2); 
				String orderNumber = rs.getString(3);
				Integer payment = rs.getInt(4);
				String status = rs.getString(5);
				String shipping = rs.getString(6);

				result.setNo(no);
				result.setUserNo(userNo);
				result.setNumber(orderNumber);
				result.setPayment(payment);
				result.setStatus(status);
				result.setShipping(shipping);
			}
		} catch(SQLException e) {
			System.out.println("error: " + e);
		} 
		
		return result;
	}

	public List<OrderBookVo> findBooksByNoAndUserNo(Long orderNo, Long userNo) {
		List<OrderBookVo> result = new ArrayList<>();
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT a.order_no, a.book_no, a.quantity, a.price, b.title "
															+ "FROM orders_book a, book b, orders c, user d "
															+ "WHERE a.book_no = b.no "
															+ "AND a.order_no = c.no "
															+ "AND c.user_no = d.no "
															+ "AND order_no = ? "
															+ "AND user_no = ?");
		) {
			pstmt.setLong(1, orderNo);
			pstmt.setLong(2, userNo);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				orderNo = rs.getLong(1);
				Long bookNo = rs.getLong(2);
				Integer quantity = rs.getInt(3);
				Integer price = rs.getInt(4);
				String bookTitle = rs.getString(5);

				OrderBookVo vo = new OrderBookVo();
				vo.setOrderNo(orderNo);
				vo.setBookNo(bookNo);
				vo.setQuantity(quantity);
				vo.setPrice(price);
				vo.setBookTitle(bookTitle);
				
				result.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("error: " + e);
		} 
		
		return result;
	}
}
