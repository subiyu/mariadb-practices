package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SelectEx02 {
	public static void main(String[] args) {
		search("pat");
	}
	
	public static void search(String keyword) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 1. JDBC Driver 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			
			//2. 연결하기
			String url = "jdbc:mariadb://192.168.0.193:3306/employees?charset=utf8";
			conn = DriverManager.getConnection(url, "hr", "hr");
			
			// 3. Statement 준비하기
			String sql = "SELECT emp_no, first_name, last_name FROM employees WHERE first_name like ?" + 
					"and last_name like ?"; //stream 통째로 value 자리로 바인딩 시킴
			pstmt = conn.prepareStatement(sql);
			
			// 4. 파라미터 binding
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			
			// 5. SQL 실행
			//rs = pstmt.executeQuery(sql); // sql은 미완성 문장이므로 날리면 안됨.
			rs = pstmt.executeQuery(); //binding 돼있는 sql을 실행해
			
			// 5. 결과 처리
			while(rs.next()) {
				Long empNo = rs.getLong(1);
				String firstName = rs.getString(2);
				String lastName = rs.getString(3);
				
				System.out.println(empNo + ":" + firstName + ":" + lastName);
			}
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실퍠: " + e);
		} catch (SQLException e) {
			System.out.println("error: " + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}

		}
	}
}
