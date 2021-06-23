package com.borysproductions.Landing;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet(urlPatterns = {"/PasswordDimenticata"})
public class RecoverPassword extends HttpServlet {

    private static final String nomedb = "username";
    private static final String passwordb = "password";
    private static final String jdbc_driver = "com.mysql.cj.jdbc.Driver";
    private static final String urldb = "jdbc:mysql://database/schema?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";

    private static final String emailPassword = "password1";
    private static final String encryptionKey = "#.NH/-$?J*@P^U6fDacnz,VhgD$L#QcP";


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");


        try {

            Connection connection = null;
            Statement connStatement = null;

            String passwordUtente = "";
            String passwordUtenteDecryptata = "";
            String email = request.getParameter("email");
            String emailCriptata = AES.encrypt(email, encryptionKey);


            // cerco il driver JDBC
            try {
                Class.forName(jdbc_driver);
            } catch (Exception e) {
                System.out.println("Driver non trovato...");
            }


            // effettuo la connessione al Database
            try {
                connection = DriverManager.getConnection(urldb, nomedb, passwordb);
            } catch (SQLException ex) {
                Logger.getLogger(RecoverPassword.class.getName()).log(Level.SEVERE, null, ex);
            }


            // Controllo se l'email inserita appartiene ad un utente registrato
            boolean exists = false;
            connStatement = connection.createStatement();
            ResultSet tempResultSet = connStatement.executeQuery("select Username from Utente_Blog where Email = '" + emailCriptata + "'");
            int a = 0;
            while (tempResultSet.next()) {
                a++;
            }

            if(a > 0){
                exists = true;
            }

            if (exists) {

                connStatement = connection.createStatement();
                ResultSet resultSet = connStatement.executeQuery("select UserPassword, Nome from Utente_Blog where Email = '" + emailCriptata + "'");
                String Nome = "";

                int i = 0;
                while (resultSet.next()) {
                    i++;
                    passwordUtente = resultSet.getString(1);
                    Nome = AES.decrypt(resultSet.getString(2), encryptionKey);
                    passwordUtenteDecryptata = AES.decrypt(passwordUtente, encryptionKey);
                }


                // nel caso esista stampo la pagina e provo ad inviare la password via email
                try (PrintWriter out = response.getWriter()) {

                    // se una password è stata ottenuta
                    if (i > 0) {
                        EmailSender.SendEmail(email,
                                "La tua password dell'account",
                                "" + passwordUtenteDecryptata,
                                Nome, "Hai richiesto il recupero della password del tuo account, se non sei stato tu per favore contattaci per ottenere maggiori informazioni o per controllare che il tuo account non sia stato compromesso.");

                        PrintPage(out,"Password inviata con successo!",
                                "Controlla la tua Email per ottenere la password.",
                                "/BlogEoG/pages/Login.jsp", "Riprova");

                    } else {
                        // nessun utente trovato
                        PrintPage(out, "C'è stato un problema!",
                                "Non è stato possibile inviare l'Email, per favore riprova.",
                                "/BlogEoG/pages/Password-Reset.jsp", "Riprova");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("/BlogEoG/pages/Password-Reset.jsp");
                }

                Utils.CloseConnection(resultSet, connStatement, connection);
            } else {
                try (PrintWriter out = response.getWriter()) {

                    PrintPage(out, "Errore durante il recupero della Password!",
                            "L'Email inserita non appartiene a nessun utente registrato, riprova.",
                            "/BlogEoG/pages/Password-Reset.jsp", "Riprova");
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold default state="collapsed" desc="## Page Printers ##">

    private void PrintPage(PrintWriter out, String messageTitle, String message, String urlBtn, String msgBtn) {
        out.println("<!DOCTYPE html><html lang=\"it\"><head> <meta charset=\"utf-8\"> <meta content=\"IE=edge\" http-equiv=\"X-UA-Compatible\"> <meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" name=\"viewport\"> " +
                "<title>Recupero Password | EoG Blog</title> " +
                "<link href=\"assets/images/emperor2.png\" rel=\"shortcut icon\"> <link href=\"assets/css/light.css\" id=\"theme-link\" rel=\"stylesheet\"> <link href=\"assets/third-party/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\"> <link href=\"assets/css/utils.css\" rel=\"stylesheet\"> <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700' rel='stylesheet' type='text/css'> <link href=\"assets/third-party/font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/animate/animate.min.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/animate/animate.delay.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/owl-carousel/owl.carousel.css\" rel=\"stylesheet\"></head><body class=\"fixed-header\"><header> <div class=\"container\"> <span class=\"bar hide\"> <a class=\"logo\"> <i class=\"fa fa-bars\"></i> </a> </span> <a class=\"logo\" href=\"/BlogEoG/index.jsp\"> <img alt=\"\" src=\"../assets/images/emperor2.png\" style=\"max-width: 100%; height: 95%\"> </a> <nav> <div class=\"nav-control\"> <ul> <li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/index.jsp\">Home</a> </li><li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/pages/blog/home.jsp\">Blog</a> </li><li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/index.jsp#chisiamo\">Chi Siamo</a> </li></ul> </div></nav> <nav class=\"nav-right\"> <div> <ul> <li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/pages/Login.jsp\">Accedi</a> </li><li> <a class=\"dropdown-toggle\" href=\"/BlogEoG/pages/Register.jsp\">Registrati</a> </li><li> <a class=\"dropdown-toggle\"> <button class=\"btn btn-primary btn-lg\" id=\"btn-darkmode\">Dark</button> </a> </li></ul> </div></div></div></header><script src=\"assets/js/darkmode.js\"></script><div id=\"body\"> <section class=\"error-404\"> <div class=\"container\"> <div class=\"row\"> <div class=\"col-lg-8 col-lg-offset-2\"> " +
                "<div class=\"title\"> <h4>" + messageTitle + "</h4> </div>" +
                "<p>" + message + "</p>" +
                "<a class=\"btn btn-primary btn-lg margin-top-20 btn-shadow btn-rounded\" " +
                "href='"+ urlBtn +"'>" + msgBtn + "'</a> </div></div></div></section></div><footer> <div class=\"footer-bottom\"> <div class=\"container\"> <p>&copy; 2021 Copyright BorysProductions | Tutti i diritti riservati.</p></div></div></footer><script src=\"assets/third-party/jquery/jquery-1.11.1.min.js\"></script><script src=\"assets/third-party/bootstrap/js/bootstrap.min.js\"></script><script src=\"assets/third-party/core.min.js\"></script></body></html>");
    }

    // </editor-fold>

    // <editor-fold defaultstate="collapsed" desc="## HttpServlet methods. ##">

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

    // </editor-fold>

}
