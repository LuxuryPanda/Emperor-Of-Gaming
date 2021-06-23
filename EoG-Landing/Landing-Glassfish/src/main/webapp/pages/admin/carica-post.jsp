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
    FileInputStream fis = null;
    String titolo = request.getParameter("titolo");
    String autore = request.getParameter("autore");
    String dataPubb = request.getParameter("dataPubb");
    String foto = request.getParameter("foto");
    String contenutoCard = request.getParameter("contenutoCard");
    String contenuto = request.getParameter("contenuto");

    try {

        connection = DriverManager.getConnection(urldb, nomedb, passwordb);

        prepStatement = connection.prepareStatement("insert into Post_Blog(Titolo, Autore, DataPubb, DescrizioneCard, Descrizione, Immagine) "
                + "values(?, ?, ?, ?, ?, ?)");

        String newTitolo = Utils.StringFixer(titolo);
        String newContenutoCard = Utils.StringFixer(contenutoCard);
        String newContenuto = Utils.StringFixer(contenuto);

        prepStatement.setString(1, AES.encrypt(newTitolo, encryptionKey));
        prepStatement.setString(2, AES.encrypt(autore, encryptionKey));
        prepStatement.setString(3, AES.encrypt(dataPubb, encryptionKey));
        prepStatement.setString(4, AES.encrypt(newContenutoCard, encryptionKey));
        prepStatement.setString(5, AES.encrypt(newContenuto, encryptionKey));
        prepStatement.setString(6, AES.encrypt(foto, encryptionKey));


        int count = prepStatement.executeUpdate();
        if (count > 0) {
            System.out.println("Post caricato con successo!");
            response.sendRedirect("./lista-post.jsp");
        } else {
            System.out.println("Il post non è stato caricato");
            response.sendRedirect("./crea-post.jsp");
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
