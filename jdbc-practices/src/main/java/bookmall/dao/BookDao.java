package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bookmall.vo.BookVo;

public class BookDao {
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

	public int insert(BookVo vo) {
		int result = 0;
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt1 = conn.prepareStatement("INSERT INTO book(title, price, category_no) VALUES(?, ?, ?)");
			PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
		) {
			pstmt1.setString(1, vo.getTitle());
			pstmt1.setInt(2, vo.getPrice());
			pstmt1.setLong(3, vo.getCategoryNo());
			result = pstmt1.executeUpdate();
			
			ResultSet rs = pstmt2.executeQuery();
			vo.setNo(rs.next() ? rs.getLong(1) : null);
			rs.close();
		} catch(SQLException e) {
			System.out.println("error: " + e);
		} 
		
		return result;
	}

	
}
