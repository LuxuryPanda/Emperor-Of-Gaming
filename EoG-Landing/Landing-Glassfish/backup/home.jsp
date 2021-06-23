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

                <!-- GIOCO 1 - RESIDENT EVIL 8 -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="../../assets/images/blog/re-village.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="../../pages/blog/posts/resident-evil-village.jsp">RESIDENT
                                EVIL VILLAGE</a></h3>
                            <ul>
                                <li>28 Maggio, 2021</li>
                            </ul>
                            <p><br>Vivi un'esperienza survival horror senza precedenti nell'ottavo capitolo della saga
                                di Resident Evil: Resident Evil Village.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 2  CRASH BANDICOOT 4: IT'S ABOUT TIME -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="../../assets/images/blog/crash-bandicoot-4.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="../../pages/blog/posts/crash-bandicoot-4.html">CRASH
                                BANDICOOT 4:
                                IT'S ABOUT TIME</a></h3>
                            <ul>
                                <li>29 Marzo, 2021</li>
                            </ul>
                            <p><br>Crash è tornato! Nel primo capitolo della saga di Crash dopo oltre dieci anni ed ora
                                con nuovi poteri e nuovi mondi.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 3 - KINGDOM HEARTS III RE MIND -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="../../assets/images/blog/kingdom-hearts-3.png">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="../../pages/blog/posts/kingdom-hearts-iii.html">KINGDOM
                                HEARTS III
                                + RE MIND</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Determinato a salvare Kairi, Sora raggiunge il Cimitero dei Keyblade prima che la
                                battaglia finale abbia inizio. Privo di una forma corporea, segue i cuori dei sette
                                guardiani della luce.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 4 - OUTRIDERS -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="../../assets/images/blog/outriders.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="../../pages/blog/posts/outriders.html">OUTRIDERS</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Un vero ibrido di generi, unisce dei combattimenti brutali e sanguinosi a delle profonde
                                meccaniche dei GdR con alberi delle abilità estesi.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 5 - INDUSTRIA -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="../../assets/images/blog/industria.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="../../pages/blog/posts/industria.html">INDUSTRIA</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Un classico sparatutto in prima persona che ti catapulterà in un universo parallelo di
                                poco antecedente alla fine della Guerra Fredda.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 6 - ODDWORLD: SOULSTORM -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="../../assets/images/blog/oddworld-soulstorm.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="../../pages/blog/posts/oddworld-soulstorm.html">ODDWORLD:
                                SOULSTORM</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Un'esplosiva avventura d'azione in cui potrai creare, ricercare e muoverti furtivamente e
                                che presenta caratteristiche tipiche dei platform.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 7 - DAYS GONE -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="../../assets/images/blog/days-gone.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="../../pages/blog/posts/days-gone.html">DAYS GONE</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Combatti ed esplora i letali Stati Uniti d'America post-pandemici in questo gioco
                                open world di azione/avventura calandoti nel ruolo di Deacon St..</p>
                        </div>
                    </div>
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
                <a href="../PrivacyPolicy.html">Privacy Policy</a></p>
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
