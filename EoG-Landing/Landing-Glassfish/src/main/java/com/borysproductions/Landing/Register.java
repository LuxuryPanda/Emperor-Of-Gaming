package com.borysproductions.Landing;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet(name = "Register", value = {"/register", "/registrazione"})
public class Register extends HttpServlet {

    //#region ## Variabili ##
    private static final String nomedb = "username";
    private static final String passwordb = "password";
    private static final String jdbc_driver = "com.mysql.cj.jdbc.Driver";
    private static final String urldb = "jdbc:mysql://database/schema?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";

    Connection connection = null;
    ResultSet resultSet = null;
    Statement connStatement = null;

    private static final String encryptionKey = "#.NH/-$?J*@P^U6fDacnz,VhgD$L#QcP";

    //#endregion

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("[REGISTER]: PROCESSING REQUEST");
        String Insert_into_Utente = "insert into Utente_Blog"
                + "  (Username, UserPassword, Email, Nome, Cognome) values "
                + " (?, ?, ?, ?, ?);";

        // Trova il JDBC DRIVER
        try {
            Class.forName(jdbc_driver);
        } catch (ClassNotFoundException e) {
            System.out.println("[Registrazione]: DRIVER NON TROVATO!");
        }

        try (Connection connection = DriverManager.getConnection(urldb, nomedb, passwordb)) {

            response.setContentType("text/html;charset=UTF-8");

            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String username = request.getParameter("username");

            String usernameCifrato = AES.encrypt(username, encryptionKey);
            String passwordCifrata = AES.encrypt(password, encryptionKey);
            String emailCifrata = AES.encrypt(email, encryptionKey);
            String nomeCifrato = AES.encrypt(nome, encryptionKey);
            String cognomeCifrato = AES.encrypt(cognome, encryptionKey);

            // Controllo se l'utente è già registrato
            boolean isNewUser = true;
            String CheckUser_Query = "select * from Utente_Blog where Username = ? or Email = ?;";
            PreparedStatement prepStatementCheck = connection.prepareStatement(CheckUser_Query);
            prepStatementCheck.setString(1, usernameCifrato);
            prepStatementCheck.setString(2, emailCifrata);

            ResultSet result = prepStatementCheck.executeQuery();
            int i = 0;
            while (result.next()){
                i++;
            }

            // In base al risultato della query se il numero di istanze trovate è pari a zero allora
            // lo username è inutilizzato
            isNewUser = i == 0;

            if (isNewUser)
            {
                // Creazione dello statement usando la stringa Insert_into_Utente
                PreparedStatement preparedStatement = connection.prepareStatement(Insert_into_Utente);

                // Inserisco nella query i valori criptati
                preparedStatement.setString(1, usernameCifrato);
                preparedStatement.setString(2, passwordCifrata);
                preparedStatement.setString(3, emailCifrata);
                preparedStatement.setString(4, nomeCifrato);
                preparedStatement.setString(5, cognomeCifrato);

                preparedStatement.executeUpdate();


                response.setContentType("text/html;charset=UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    PrintPage(out, "Registrazione Effettuata!",
                            "La registrazione è stata effettuata con successo, " +
                                    "ora ti basta solo accedere.",
                            "/BlogEoG/pages/Login.jsp", "Vai al Login");
                }
                catch (Exception e){
                    e.printStackTrace();
                }
            }
            else{
                try (PrintWriter out = response.getWriter()) {
                    PrintPage(out, "Errore durante la registrazione!",
                            "I dati inseriti risultano già registrati, per favore riprova.",
                            "/BlogEoG/pages/Register.jsp", "Riprova");
                }
                catch (Exception e){
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        Utils.CloseConnection(resultSet, connStatement, connection);
    }

    // <editor-fold default state="collapsed" des="## Printers ##">

    private void PrintPage(PrintWriter out, String messageTitle, String message, String urlBtn, String msgBtn) {
        out.println("<!DOCTYPE html><html lang=\"it\"><head> <meta charset=\"utf-8\"> <meta content=\"IE=edge\" http-equiv=\"X-UA-Compatible\"> <meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" name=\"viewport\"> " +
                "<title>Registrazione | EoG Blog</title> " +
                "<link href=\"assets/images/emperor2.png\" rel=\"shortcut icon\"> <link href=\"assets/css/light.css\" id=\"theme-link\" rel=\"stylesheet\"> <link href=\"assets/third-party/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\"> <link href=\"assets/css/utils.css\" rel=\"stylesheet\"> <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700' rel='stylesheet' type='text/css'> <link href=\"assets/third-party/font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/animate/animate.min.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/animate/animate.delay.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/owl-carousel/owl.carousel.css\" rel=\"stylesheet\"></head><body class=\"fixed-header\"><header> <div class=\"container\"> <span class=\"bar hide\"> <a class=\"logo\"> <i class=\"fa fa-bars\"></i> </a> </span> <a class=\"logo\" href=\"/BlogEoG/index.jsp\"> <img alt=\"\" src=\"assets/images/emperor2.png\" style=\"max-width: 100%; height: 95%\"> </a> <nav> <div class=\"nav-control\"> <ul> <li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/index.jsp\">Home</a> </li><li> <a class=\"dropdown-toggle\" href=\"pages/blog/home.jsp\">Blog</a> </li><li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/index.jsp#chisiamo\">Chi Siamo</a> </li></ul> </div></nav> <nav class=\"nav-right\"> <div> <ul> <li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/pages/Login.jsp\">Accedi</a> </li><li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/pages/Register.jsp\">Registrati</a> </li><li> <a class=\"dropdown-toggle\"> <button class=\"btn btn-primary btn-lg\" id=\"btn-darkmode\">Dark</button> </a> </li></ul> </div></div></div></header><script src=\"assets/js/darkmode.js\"></script><div id=\"body\"> <section class=\"error-404\"> <div class=\"container\"> <div class=\"row\"> <div class=\"col-lg-8 col-lg-offset-2\"> " +
                "<div class=\"title\"> <h4>" + messageTitle + "</h4> " +
                "</div><p>" + message + "</p>" +
                "<a class=\"btn btn-primary btn-lg margin-top-20 btn-shadow btn-rounded\" " +
                "href='" + urlBtn + "'>" + msgBtn + "</a> </div></div></div></section></div><footer> <div class=\"footer-bottom\"> <div class=\"container\"> <p>&copy; 2021 Copyright BorysProductions | Tutti i diritti riservati.</p></div></div></footer><script src=\"assets/third-party/jquery/jquery-1.11.1.min.js\"></script><script src=\"assets/third-party/bootstrap/js/bootstrap.min.js\"></script><script src=\"assets/third-party/core.min.js\"></script></body></html>");
    }

    // </editor-fold>

    //#region ## DoGet & DoPost ##
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
    //#endregion

}
