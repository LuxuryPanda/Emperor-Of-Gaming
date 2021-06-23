package com.borysproductions.Landing;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet(urlPatterns = {"/Autenticazione"})
public class A2F extends HttpServlet {

    private static final String nomedb = "username";
    private static final String passwordb = "password";
    private static final String jdbc_driver = "com.mysql.cj.jdbc.Driver";
    private static final String urldb = "jdbc:mysql://database/schema?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";

    private static final String encryptionKey = "#.NH/-$?J*@P^U6fDacnz,VhgD$L#QcP";


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int codice2FA = Integer.parseInt(request.getParameter("code"));

        try {

            Connection connection = null;
            Statement connStatement = null;

            try {
                Class.forName(jdbc_driver);
            } catch (Exception e) {
                System.out.println("Driver non trovato...");
            }


            try {
                connection = DriverManager.getConnection(urldb, nomedb, passwordb);
            } catch (SQLException ex) {
                Logger.getLogger(RecoverPassword.class.getName()).log(Level.SEVERE, null, ex);
            }

            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("Email");
            boolean isAdmin = false;

            connStatement = connection.createStatement();
            ResultSet resultSet = connStatement.executeQuery("select Codice2FA, Admin from Utente_Blog where Email = '" + email + "'");

            int savedCode = 0;

            int i = 0;
            while (resultSet.next()) {
                i++;
                savedCode = resultSet.getInt(1);
                isAdmin = resultSet.getBoolean(2);
            }


            try (PrintWriter out = response.getWriter()) {

                // se un codice 2FA è stato ottenuto dalla query allora proseguo
                if (i > 0) {

                    if(codice2FA == savedCode){
                        session.setAttribute("HasBeenValidated", true);
                        session.setAttribute("isAdmin", isAdmin);
                        response.sendRedirect("/BlogEoG/pages/blog/home.jsp");
                    }
                    else{
                        response.sendRedirect("/BlogEoG/pages/Autenticazione.jsp");
                    }

                } else {
                    // nessun utente trovato con l'email inserita
                    // non dovrebbe succedere visto che l'utente ha eseguito il login però non si sa mai
                    PrintPage(out, "Utente non trovato!",
                            "Per favore ricontrolla l'email!",
                            "/BlogEoG/pages/Login.jsp", "Riprova");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            Utils.CloseConnection(resultSet, connStatement, connection);

        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    // <editor-fold default state="collapsed" desc="## Page Printers ##">

    private void PrintPage(PrintWriter out, String messageTitle, String message, String urlBtn, String msgBtn) {
        out.println("<!DOCTYPE html><html lang=\"it\"><head> <meta charset=\"utf-8\"> <meta content=\"IE=edge\" http-equiv=\"X-UA-Compatible\"> <meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" name=\"viewport\"> " +
                "<title>Login | EoG Blog</title> <link href=\"assets/images/emperor2.png\" rel=\"shortcut icon\"> <link href=\"assets/css/light.css\" id=\"theme-link\" rel=\"stylesheet\"> <link href=\"assets/third-party/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\"> <link href=\"assets/css/utils.css\" rel=\"stylesheet\"> <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700' rel='stylesheet' type='text/css'> <link href=\"assets/third-party/font-awesome/css/font-awesome.min.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/animate/animate.min.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/animate/animate.delay.css\" rel=\"stylesheet\"> <link href=\"assets/third-party/owl-carousel/owl.carousel.css\" rel=\"stylesheet\"></head><body class=\"fixed-header\"><header> <div class=\"container\"> <span class=\"bar hide\"> <a class=\"logo\"> <i class=\"fa fa-bars\"></i> </a> </span> <a class=\"logo\" href=\"../index.html\"> <img alt=\"\" src=\"../assets/images/emperor2.png\" style=\"max-width: 100%; height: 95%\"> </a> <nav> <div class=\"nav-control\"> <ul> <li> <a class=\"dropdown-toggle\" href=\"../index.html\">Home</a> </li><li> <a class=\"dropdown-toggle\" href=\"../pages/blog/home.jsp\">Blog</a> </li><li> <a class=\"dropdown-toggle\" href=\"../index.html#chisiamo\">Chi Siamo</a> </li></ul> </div></nav> <nav class=\"nav-right\"> <div> <ul> <li> <a class=\"dropdown-toggle\" href=\"Login.jsp\">Accedi</a> </li><li> <a class=\"dropdown-toggle\" href=\"Register.jsp\">Registrati</a> </li><li> <a class=\"dropdown-toggle\"> <button class=\"btn btn-primary btn-lg\" id=\"btn-darkmode\">Dark</button> </a> </li></ul> </div></div></div></header><script src=\"assets/js/darkmode.js\"></script><div id=\"body\"> <section class=\"error-404\"> <div class=\"container\"> <div class=\"row\"> <div class=\"col-lg-8 col-lg-offset-2\"> <div class=\"title\"> " +
                "<h4>" + messageTitle + "</h4> </div>" +
                "<p>" + message + "</p>" +
                "<a class=\"btn btn-primary btn-lg margin-top-20 btn-shadow btn-rounded\" " +
                "href='" + urlBtn + "'>" + msgBtn + "</a> </div></div></div></section></div><footer> <div class=\"footer-bottom\"> <div class=\"container\"> <p>&copy; 2021 Copyright BorysProductions | Tutti i diritti riservati.</p></div></div></footer><script src=\"assets/third-party/jquery/jquery-1.11.1.min.js\"></script><script src=\"assets/third-party/bootstrap/js/bootstrap.min.js\"></script><script src=\"assets/third-party/core.min.js\"></script></body></html>");
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
