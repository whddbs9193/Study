package db.conn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class JDBCUtil {
	// 1~2단계 - Connection Pool 사용
	public static Connection getConnection() throws Exception{
		Context initCtx = new InitialContext(); //객체 생성
		Context envCtx = (Context)initCtx.lookup("java:comp/env"); //환경 검색
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db01");
		return ds.getConnection();
	}
	//Connection, PreparedStatement 닫는 메소드 - insert, update, delete 작업
	public static void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null)try {
			pstmt.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	// Connection, PreparedStatement, ResultSet 객체를 닫는 메소드 - select 작업
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null)try {
			rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		if(pstmt != null)try {
			pstmt.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
