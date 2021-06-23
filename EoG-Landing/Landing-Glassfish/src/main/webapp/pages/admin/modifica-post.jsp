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
%>
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
    <!-- META -->
    <meta charset="utf-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">

    <title>Modifica Post | EoG Blog</title>

    <!-- FAVICON -->
    <link href="../../assets/images/emperor2.png" rel="shortcut icon">

    <!-- DarkMode -->
    <link href="../../assets/css/light.css" id="theme-link" rel="stylesheet">


    <!-- CORE CSS -->
    <link href="../../assets/third-party/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../assets/css/utils.css" rel="stylesheet">
    <link href="../../assets/css/loading.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700' rel='stylesheet' type='text/css'>

    <!-- PLUGINS -->
    <link href="../../assets/third-party/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="../../assets/third-party/animate/animate.min.css" rel="stylesheet">
    <link href="../../assets/third-party/animate/animate.delay.css" rel="stylesheet">
    <link href="../../assets/third-party/owl-carousel/owl.carousel.css" rel="stylesheet">
</head>
<body class="fixed-header">
<!-- MENU -->
<header>
    <div class="container">
                <span class="bar hide">
                    <a class="logo">
                        <i class="fa fa-bars"></i>
                    </a>
                </span>
        <!-- LOGO -->
        <a class="logo" href="../../index.jsp">
            <img alt="" src="../../assets/images/emperor2.png" style="max-width: 100%; height: 95%">
        </a>
        <!-- FINE LOGO -->
        <!-- MENU SX -->
        <nav>
            <div class="nav-control">
                <ul>
                    <!-- HOME -->
                    <li>
                        <a class="dropdown-toggle" href="../../index.jsp">Home</a>
                    </li>
                    <!-- BLOG -->
                    <li>
                        <a class="dropdown-toggle" href="../blog/home.jsp">Blog</a>
                    </li>
                    <!-- CHI SIAMO -->
                    <li>
                        <a class="dropdown-toggle" href="../../index.jsp#chisiamo">Chi Siamo</a>
                    </li>
                    <div class="mobile-only">
                        <%
                            session = request.getSession();
                            String validatedMobile = String.valueOf(session.getAttribute("HasBeenValidated"));
                            if (Boolean.parseBoolean(validatedMobile)) {
                        %>
                        <li>
                            <a class="dropdown-toggle" href="/BlogEoG/logout">Logout</a>
                        </li>
                        <% } else { %>
                        <li>
                            <a class="dropdown-toggle" href="../Login.jsp">Accedi</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="../Register.jsp">Registrati</a>
                        </li>
                        <% } %>
                        <li>
                            <a class="dropdown-toggle">
                                <button class="btn btn-primary btn-lg" id="btn-darkmode-mobile">Modalità Scura</button>
                            </a>
                        </li>
                    </div>
                </ul>
            </div>
        </nav>
        <!-- FINE MENU SX -->
        <nav class="nav-right">
            <div>
                <ul>
                    <%
                        session = request.getSession();
                        String validated = String.valueOf(session.getAttribute("HasBeenValidated"));
                        if (Boolean.parseBoolean(validated)) {
                    %>
                    <li>
                        <a class="dropdown-toggle" href="/BlogEoG/logout">Logout</a>
                    </li>
                    <% } else { %>
                    <li>
                        <a class="dropdown-toggle" href="../Login.jsp">Accedi</a>
                    </li>
                    <li>
                        <a class="dropdown-toggle" href="../Register.jsp">Registrati</a>
                    </li>
                    <% } %>
                    <li>
                        <a class="dropdown-toggle">
                            <button class="btn btn-primary btn-lg" id="btn-darkmode" style="margin-top: 0.7rem">Modalità
                                Scura
                            </button>
                        </a>
                    </li>
                </ul>
            </div>
    </div>
    </div>
</header>
<!-- FINE MENU -->

<script src="../../assets/js/darkmode.js"></script>
<div class="loader-wrapper">
    <div class="containerCubes">
        <div class="📦"></div>
        <div class="📦"></div>
        <div class="📦"></div>
        <div class="📦"></div>
        <div class="📦"></div>
    </div>
</div>

<!-- BODY -->
<div id="body">
    <section class="bg relative">
        <div class="container">
            <div class="row" style="text-align: center">
                <div class="col-lg-8 col-lg-offset-2">
                    <%
                        int id = Integer.parseInt(request.getParameter("id"));
                        try {
                            connection = DriverManager.getConnection(urldb, nomedb, passwordb);
                            statement = connection.createStatement();

                            resultSet = statement.executeQuery("SELECT * FROM Post_Blog WHERE PostID = " + id);
                            while (resultSet.next()){



                    %>
                    <div class="title">
                        <h4>Modifica il post!</h4>
                    </div>
                    <form action="./aggiorna-post.jsp" method="POST" name="PostForm">
                        <input id="postID" name="postID" type="hidden" value="<%= id %>">
                        <label>
                            Titolo:
                            <input class="form-control" type="text" name="titolo" required style="color: black"
                                value="<%= AES.decrypt(resultSet.getString("Titolo"), encryptionKey) %>"/>
                        </label>
                        <label>
                            Autore
                            <input class="form-control" type="text" name="autore" required style="color: black"
                                   value="<%= AES.decrypt(resultSet.getString("Autore"), encryptionKey) %>"/>
                        </label>

                        <br/>
                        <label>
                            Data Pubblicazione:
                            <input class="form-control" type="text" name="dataPubb" required style="color: black"
                                   value="<%= AES.decrypt(resultSet.getString("DataPubb"), encryptionKey) %>"/>
                        </label>
                        <label>
                            URL Foto (768x432):
                            <input class="form-control" type="text" name="foto" required style="color: black"
                                   value="<%= AES.decrypt(resultSet.getString("Immagine"), encryptionKey) %>"/>
                        </label>

                        <br/>
                        <label>
                            Contenuto Card (Non superare le 25 parole):
                            <textarea class="form-control" rows="6" cols="30" name="contenutoCard" required
                                      style="color: black"><%= AES.decrypt(resultSet.getString("DescrizioneCard"), encryptionKey) %></textarea>
                        </label><br/>
                        <label>
                            Contenuto:
                            <textarea class="form-control" rows="6" cols="50" name="contenuto" required
                                      style="color: black"><%= AES.decrypt(resultSet.getString("Descrizione"), encryptionKey) %></textarea>
                        </label><br/>

                        <input type="submit" value="Modifica" class="btn btn-primary"/>
                        <input type="reset" value="Cancella" class="btn btn-danger"/>
                    </form>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    %>
                </div>
            </div>
        </div>
    </section>
</div>
<!-- FINE BODY -->

<!-- FOOTER -->
<footer>
    <div class="footer-bottom">
        <div class="container">
            <p>&copy; 2021 Copyright BorysProductions | Tutti i diritti riservati. |
                <a href="../PrivacyPolicy.jsp">Privacy Policy</a></p>
        </div>
    </div>
</footer>
<!-- FINE FOOTER -->

<!-- Javascript -->
<script src="../../assets/third-party/jquery/jquery-1.11.1.min.js"></script>
<script src="../../assets/third-party/bootstrap/js/bootstrap.min.js"></script>
<script src="../../assets/third-party/core.min.js"></script>
<script>
    $(window).on("load",function(){
        $(".loader-wrapper").fadeOut(1600);
    });
</script>
</body>
</html>
