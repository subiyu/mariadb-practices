package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import bookmall.vo.CategoryVo;

public class CartDao {
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

	public int insert(CartVo vo) {
		int result = 0;
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt1 = conn.prepareStatement("INSERT INTO cart(user_no, book_no, quantity) VALUES(?, ?, ?)");
		) {
			pstmt1.setLong(1, vo.getUserNo());
			pstmt1.setLong(2, vo.getBookNo());
			pstmt1.setInt(3, vo.getQuantity());
			result = pstmt1.executeUpdate();
		} catch(SQLException e) {
			System.out.println("error: " + e);
		} 
		
		return result;
	}

	public List<CartVo> findByUserNo(Long no) {
		List<CartVo> result = new ArrayList<>();
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT b.book_no, b.user_no, b.quantity, a.title "
															+ "FROM book a, cart b "
															+ "WHERE a.no = b.book_no "
															+ "AND user_no = ?");
		) {
			pstmt.setLong(1, no);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Long bookNo = rs.getLong(1);
				Long userNo = rs.getLong(2);
				Integer quantity = rs.getInt(3);
				String bookTitle = rs.getString(4);

				CartVo vo = new CartVo();
				vo.setBookNo(bookNo);
				vo.setUserNo(userNo);
				vo.setQuantity(quantity);
				vo.setBookTitle(bookTitle);
				
				result.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("error: " + e);
		} 
		
		return result;
	}
}
