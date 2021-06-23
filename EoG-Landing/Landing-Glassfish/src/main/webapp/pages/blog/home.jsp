<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="com.borysproductions.Landing.AES" %>
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
    Statement statement = null;
    ResultSet resultSet = null;
%>
<html lang="it">
<head>
    <%
        try {
            String username = String.valueOf(session.getAttribute("Username"));
            String validated = String.valueOf(session.getAttribute("HasBeenValidated"));

            String redirectURL = "../Login.jsp";

            if (username == null || username.equals("")) {
                // la sessione non esiste quindi redirect
                response.sendRedirect(redirectURL);
            } else if (!Boolean.parseBoolean(validated)) {
                // ha effettuato il login ma non ha inserito il codice 2FA
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

    <title>Blog | EoG Blog</title>

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
                        <a class="dropdown-toggle" href="./home.jsp">Blog</a>
                    </li>
                    <!-- CHI SIAMO -->
                    <li>
                        <a class="dropdown-toggle" href="../../index.jsp#chisiamo">Chi Siamo</a>
                    </li>
                    <div class="mobile-only">
                        <%
                            session = request.getSession();
                            String isAdmin = String.valueOf(session.getAttribute("isAdmin"));
                            if (Boolean.parseBoolean(isAdmin)) {
                        %>
                        <li>
                            <a class="dropdown-toggle" href="../admin/crea-post.jsp">Crea Post</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="../admin/lista-post.jsp">Lista Post</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="../admin/lista-utenti.jsp">Lista Utenti</a>
                        </li>
                        <% } %>
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
                        if (Boolean.parseBoolean(isAdmin)) {
                    %>
                    <li>
                        <a class="dropdown-toggle" href="../admin/crea-post.jsp">Crea Post</a>
                    </li>
                    <li>
                        <a class="dropdown-toggle" href="../admin/lista-post.jsp">Lista Post</a>
                    </li>
                    <li>
                        <a class="dropdown-toggle" href="../admin/lista-utenti.jsp">Lista Utenti</a>
                    </li>
                    <% } %>
                    <%
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
    <!-- HEADER -->
    <section class="pageheader parallax height-300 parallax"
             style="background-image: url(../../assets/images/blog/assassins-creed-valhalla.jpg);">
        <div class="pageheader-bg"></div>
        <div class="container">
            <div class="page-header" style="margin: 100px 0 20px">
                <div class="page-title bold">Benvenuto <%=session.getAttribute("Username")%>
                </div>
                <p style="color: white">Qui troverai tutti i post del nostro blog.</p>
            </div>
        </div>
    </section>


    <section class="bg">
        <div class="container">

            <!-- POSTS -->
            <div class="row">
                <%
                    try {
                        connection = DriverManager.getConnection(urldb, nomedb, passwordb);
                        statement = connection.createStatement();
                        String sql = "select * from Post_Blog order by PostID desc";
                        resultSet = statement.executeQuery(sql);
                        while (resultSet.next()) {
                %>
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="<%= AES.decrypt(resultSet.getString("Immagine"), encryptionKey) %>">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a
                                    href="../../pages/blog/post.jsp?id=<%= resultSet.getInt("PostID") %>">
                                <%= AES.decrypt(resultSet.getString("Titolo"), encryptionKey) %>
                            </a></h3>
                            <ul>
                                <li><%= AES.decrypt(resultSet.getString("DataPubb"), encryptionKey) %>
                                </li>
                            </ul>
                            <p><br><%= AES.decrypt(resultSet.getString("DescrizioneCard"), encryptionKey) %>
                            </p>
                        </div>
                    </div>
                </div>
                <%
                        }
                        connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
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
    $(window).on("load", function () {
        $(".loader-wrapper").fadeOut(1600);
    });
</script>
</body>
</html>
