<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*, java.text.*, db.conn.JDBCUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>connectionPoolTest01</title>
<style>
#container{ width: 600px; margin: 20px auto;}
h2{text-align: center;}
table{width:100%; border: 1px solid black; border-collapse: collapse;}
tr{height: 35px;}
td,th{border: 1px solid black;}
td{text-align: center;}
th{background: #ccc;}
</style>
</head>
<%--
< 일반적인 서버 접속 방법의 문제점 >
- 클라이언트가 커넥션을 하나씩 획득하여 DBMS 접속하는 방법은 접속 요청이 많아지면, 서버에 부하가 생기고, 
- 곧 서버가 부하를 견디지 못해서 서버가 다운되는 문제가 발생함.
- 핵심적인 문제: 커넥션의 개수가 많아지는 문제
-> 해결책: 커넥션의 개수를 일정하게 유지하여 서버의 부담을 주지 않도록함. 커넥션풀로 이 문제를 해결함.

< Connection Pool (CP), 커넥션풀 >
- 커넥션의 개수를 정해서 미리 생성해 풀에 던져놓고, 접속하는 클라이언트는 이 풀에 있는 커넥션을 가져다가 사용하고,
- 사용이 끝나면, 이 풀에 다시 던져 놓으면 됨.
--%>
<body>
<div id="container">
	<h2>전체 회원 정보 확인 (select)</h2>
	<%
	request.setCharacterEncoding("utf-8");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from member";
	try{
		conn = JDBCUtil.getConnection(); //1~2 단계 클래스 생성해서 간결하게 만드는 방법
		
		// 3~5단계
		pstmt = conn.prepareStatement(sql); // 3단계 - PreparedStatement 객체 생성
		rs = pstmt.executeQuery(); // 4단계 - sql 실행
		
		out.print("<table><tr><th>아이디</th><th>비밀번호</th><th>이름</th><th>나이</th><th>가입일자</th></tr>");
		while(rs.next()){ // rs로 가져온 결과 테이블에 다음 데이터가 있다면 
			String id = rs.getString("id");
			String pwd = rs.getString("pwd");
			String name = rs.getString("name");
			int age = rs.getInt("age");
			Timestamp regDate = rs.getTimestamp("regDate");
			
			out.print("<tr>");
			out.print("<td width = '15%'>"+ id + "</td>");
			out.print("<td width = '15%'>"+ pwd + "</td>");
			out.print("<td width = '15%'>"+ name + "</td>");
			out.print("<td width = '10%'>"+ age + "</td>");
			out.print("<td width = '45%'>"+ sdf.format(regDate) + "</td>");
			out.print("</tr>");
		}
		out.print("</table>");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		JDBCUtil.close(conn, pstmt, rs);
	}
	%>
</div>
</body>
</html>