<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.FileInputStream" %>
<%@page import="java.io.File" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="com.borysproductions.Landing.AES" %>
<%@ page import="com.borysproductions.Landing.Utils" %>

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
    PreparedStatement prepStatement = null;

%>
<!DOCTYPE html>
<html>
<head>
    <%
        try {
            String username = String.valueOf(session.getAttribute("Username"));
            String validated = String.valueOf(session.getAttribute("HasBeenValidated"));
            String isAdmin = String.valueOf(session.getAttribute("isAdmin"));

            String redirectURL = "../Login.jsp";
            if (username == null || username.equals("")) {
                // la sessione non esiste quindi redirect
                response.sendRedirect(redirectURL);
            } else if (!Boolean.parseBoolean(validated)) {
                // ha effettuato il login ma non ha inserito il codice 2FA
                response.sendRedirect(redirectURL);
            } else if (!Boolean.parseBoolean(isAdmin)) {
                // ha già effettuato il login ma non ha inserito il codice 2FA
                response.sendRedirect(redirectURL);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("../Login.jsp");
        }
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Caricamento Post</title>
</head>
<body>
<%
    String Username = request.getParameter("username");
    String Email = request.getParameter("email");
    String Nome = request.getParameter("nome");
    String Cognome = request.getParameter("cognome");
    int userID = 0;

    try {
        connection = DriverManager.getConnection(urldb, nomedb, passwordb);

        String GetUserID = "SELECT UserID FROM Utente_Blog WHERE Username = ?;";
        PreparedStatement prepStatementCheck = connection.prepareStatement(GetUserID);
        prepStatementCheck.setString(1, AES.encrypt(Username, encryptionKey));

        ResultSet result = prepStatementCheck.executeQuery();
        while (result.next()){
            userID = result.getInt("UserID");
        }



        // Controllo se esiste già un'utente con lo stesso username
        boolean isUsernameRegistered = false;
        String CheckUsername = "SELECT * FROM Utente_Blog WHERE Username = ? AND UserID != ?;";
        prepStatementCheck = connection.prepareStatement(CheckUsername);
        prepStatementCheck.setString(1, AES.encrypt(Username, encryptionKey));
        prepStatementCheck.setInt(2, userID);

        result = prepStatementCheck.executeQuery();
        int i = 0;
        while (result.next()){
            i++;
        }

        isUsernameRegistered = i == 0;
        if(isUsernameRegistered){
            response.sendRedirect("./aggiorna-dati.jsp");
        }


        // Controllo se esiste già un'utente con la stessa email
        boolean isEmailRegistered = false;
        String CheckEmail = "SELECT * FROM Utente_Blog WHERE Email = ? AND UserID != ?;";
        prepStatementCheck = connection.prepareStatement(CheckEmail);
        prepStatementCheck.setString(1, AES.encrypt(Username, encryptionKey));
        prepStatementCheck.setInt(2, userID);

        result = prepStatementCheck.executeQuery();
        i = 0;
        while (result.next()){
            i++;
        }

        isEmailRegistered = i == 0;
        if(isEmailRegistered){
            response.sendRedirect("./aggiorna-dati.jsp");
        }



        prepStatement = connection.prepareStatement(
                "UPDATE Utente_Blog SET Username = ?, Email = ?, Nome = ?, Cognome = ?" +
                "where Username = " + Username);

        prepStatement.setString(1, AES.encrypt(Username, encryptionKey));
        prepStatement.setString(2, AES.encrypt(Email, encryptionKey));
        prepStatement.setString(3, AES.encrypt(Nome, encryptionKey));
        prepStatement.setString(4, AES.encrypt(Cognome, encryptionKey));


        int count = prepStatement.executeUpdate();
        if (count > 0) {
            System.out.println("Profilo aggiornato con successo!");
            response.sendRedirect("../blog/home.jsp");
        } else {
            System.out.println("Profilo non aggiornato!");
            response.sendRedirect("./aggiorna-dati.jsp");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        try {
            if (prepStatement != null) {
                prepStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
