<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
    String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
    String user = "dhkang";
    String pass = "ekskdn1";
    Connection conn;
    Statement  stmt;
    PreparedStatement pstmt;
    ResultSet rs;
     
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    stmt = conn.createStatement();
    pstmt=conn.prepareStatement("select * from test");
    rs=pstmt.executeQuery();
    
     out.println("<table border=\"1\">");
    while(rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString("num")+"</td>");
        out.println("<td>"+rs.getString("name")+"</td>");
         out.println("</tr>");
    }
    out.println("</table>");
    conn.close();
%>
</body>
</html>