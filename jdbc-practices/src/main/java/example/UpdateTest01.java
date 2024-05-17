package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class UpdateTest01 {

	public static void main(String[] args) {
		DeptVo vo = new DeptVo();
		vo.setNo(1L);
		vo.setName("경영지원");
		
		boolean result = update(vo);
		System.out.println(result? "성공" : "실패");
	}
	
	public static boolean update(DeptVo vo) {
		boolean result = false;
		Connection conn = null;
		Statement stmt = null;
		
		try {
			// 1. JDBC Driver 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			
			//2. 연결하기
			String url = "jdbc:mariadb://192.168.0.193:3306/webdb?charset=utf8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
			// 3. Statement 생성하기
			stmt = conn.createStatement();
			
			// 4. SQL 실행
			String sql = "UPDATE dept set name='" + vo.getName() + "' WHERE no=2";
			int count = stmt.executeUpdate(sql);
			
			// 5. 결과 처리
			result = (count == 1);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실퍠: " + e);
		} catch (SQLException e) {
			System.out.println("error: " + e);
		} finally {
			try {
				if(stmt != null) {
					stmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}

		}
		
		return result;
	}
	
}
