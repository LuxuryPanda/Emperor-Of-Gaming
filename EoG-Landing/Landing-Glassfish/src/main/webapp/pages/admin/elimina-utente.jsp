<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@ page import="com.borysproductions.Landing.AES" %>
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
        int UserID = Integer.parseInt(String.valueOf(session.getAttribute("UserID")));


        String emailCriptata = AES.encrypt("romanborys02@gmail.com", encryptionKey);
        // se l'id dell'utente da eliminare è diverso dall'utente attualmente loggato
        if (UserID != id) {
            String sql = "DELETE FROM Utente_Blog WHERE UserID = " + id + " AND Email != '" + emailCriptata + "'";
            int i = statement.executeUpdate(sql);
        }

        response.sendRedirect("./lista-utenti.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <title>Eliminazione Utente</title>
</head>
<body>
</body>
</html>
