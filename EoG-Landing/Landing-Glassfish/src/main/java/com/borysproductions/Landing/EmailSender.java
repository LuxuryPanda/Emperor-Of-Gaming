package com.borysproductions.Landing;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.PrintWriter;
import java.util.Properties;

public class EmailSender {

    private static final String emailMittente = "email";
    private static final String emailPassword = "password";
    private static final String encryptionKey = "#.NH/-$?J*@P^U6fDacnz,VhgD$L#QcP";

    public static void SendEmail(String destinatario, String titolo, String var, String nome, String messaggio){

        try {

            String host = "smtp.gmail.com"; //Server google

            Properties properties = System.getProperties(); //Ricevo le proprietà per impostare
            properties.put("mail.smtp.host", host); //Setta il server google
            properties.put("mail.smtp.port", "465"); //Setta la porta
            properties.put("mail.smtp.ssl.enable", "true"); //Abilita SSL per la sicurezza
            properties.put("mail.smtp.auth", "true"); //Prepara l'invio delle credenziali per l'accesso

            Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(emailMittente, AES.decrypt(emailPassword, encryptionKey)); //Qui si inseriscono le credenziali dell'account mail mittente
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailMittente));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));

            String email = BuildEmail(titolo, var, nome, messaggio);

            // composizione del messaggio
            message.setSubject(titolo + " | EoG Blog"); //Oggetto dell'email
            message.setContent(email,  "text/html; charset=utf-8"); //Messaggio dell'email
            message.saveChanges();


            Transport.send(message); //Trasporta il messaggio
        }
        catch (Exception e) {
             e.printStackTrace();
        }
    }


    private static String BuildEmail(String titolo, String var, String nome, String messaggio){

        // TITOLO = (TITOLO)
        // VARIABILE = (VAR)
        // NOME UTENTE = (NOME)
        // MESSAGGIO = (MESSAGGIO)

        String BaseEmail = "<!DOCTYPE html><html lang=\"it\" xmlns=\"http://www.w3.org/1999/xhtml\"><head> <meta charset=\"utf-8\"> <meta content=\"width=device-width\" name=\"viewport\"> <meta content=\"IE=edge\" http-equiv=\"X-UA-Compatible\"> <meta name=\"x-apple-disable-message-reformatting\"> <title>TITOLO</title> <link href=\"https://fonts.googleapis.com/css?family=Lato:300,400,700\" rel=\"stylesheet\"></head><body style=\"display: grid; height: 100vh; grid-template-rows: auto 1fr auto;\"><header style=\"padding: 2rem; text-align: center\"> <h1 style=\"font-size: 26px; font-weight: 700; font-family: 'Lato', sans-serif;\"> <a href=\"https://emperorofgaming.it/BlogEoG/\" style=\"color: #5299f5; text-decoration: none;\"> EMPEROR OF GAMING</a> </h1></header><main style=\"\"> <div class=\"text\" style=\"padding: 0 2.5em; text-align: center;\"> <h3>TITOLO:</h3> <h2 style=\"font-weight: lighter\">VAR</h2> </div><div class=\"text\" style=\"margin: auto; text-align: center; width: 30rem\"> <br><br><p style=\"text-align: left\">Ciao NOME,</p><p style=\"line-height: 134%; letter-spacing: 0.5px; text-align: justify\"> MESSAGGIO </p><p style=\"text-align: justify\"> Grazie,<br>Il team di BorysProductions </p></div></main><footer style=\"padding: 2rem; text-align: center;\"> <p>&copy; 2021 Copyright BorysProductions | Tutti i diritti riservati. | <a href=\"https://emperorofgaming.it/BlogEoG/pages/PrivacyPolicy.html\" style=\"text-decoration: none;\"> Privacy Policy</a> </p></footer></body></html>";

        String Email = BaseEmail.replaceAll("TITOLO", titolo);
        Email = Email.replaceAll("VAR", var);
        Email = Email.replaceAll("NOME", nome);
        Email = Email.replaceAll("MESSAGGIO", messaggio);

        return Email;
    }
}
