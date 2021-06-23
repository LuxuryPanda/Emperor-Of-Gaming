<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%
    String nomedb = "username";
    String passwordb = "password";
    String jdbc_driver = "com.mysql.cj.jdbc.Driver";
    String urldb = "jdbc:mysql://database/schema?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    String encryptionKey = "#.NH/-$?J*@P^U6fDacnz,VhgD$L#QcP";

    try {
        Class.forName(jdbc_driver);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    int id = Integer.parseInt(request.getParameter("id"));
    try {
        connection = DriverManager.getConnection(urldb, nomedb, passwordb);
        statement = connection.createStatement();

        String sql = "DELETE FROM Post_Blog WHERE PostID = " + id;
        statement.executeUpdate(sql);

        response.sendRedirect("./lista-post.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <title>Eliminazione Post</title>
</head>
<body>
</body>
</html>
