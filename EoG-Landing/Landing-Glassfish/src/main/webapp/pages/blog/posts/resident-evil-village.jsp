<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.print.DocFlavor" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <%
        try {
            String username = String.valueOf(session.getAttribute("Username"));
            String validated =  String.valueOf(session.getAttribute("HasBeenValidated"));

            String redirectURL = "../../Login.jsp";

            if (username == null || username.equals("")) {
                // la sessione non esiste quindi redirect
                response.sendRedirect(redirectURL);
            }
            else if(!Boolean.parseBoolean(validated)){
                // ha effettuato il login ma non ha inserito il codice 2FA
                response.sendRedirect(redirectURL);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("../../Login.jsp");
        }
    %>

    <!-- META -->
    <meta charset="utf-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">

    <title>Resident Evil Village | EoG Blog</title>

    <!-- FAVICON -->
    <link href="../../../assets/images/emperor2.png" rel="shortcut icon">

    <!-- DarkMode -->
    <link href="../../../assets/css/light.css" id="theme-link" rel="stylesheet">


    <!-- CORE CSS -->
    <link href="../../../assets/third-party/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../assets/css/utils.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700' rel='stylesheet' type='text/css'>

    <!-- PLUGINS -->
    <link href="../../../assets/third-party/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="../../../assets/third-party/animate/animate.min.css" rel="stylesheet">
    <link href="../../../assets/third-party/animate/animate.delay.css" rel="stylesheet">
    <link href="../../../assets/third-party/owl-carousel/owl.carousel.css" rel="stylesheet">
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
        <a class="logo" href="../../../index.jsp">
            <img alt="" src="../../../assets/images/emperor2.png" style="max-width: 100%; height: 95%">
        </a>
        <!-- FINE LOGO -->
        <!-- MENU SX -->
        <nav>
            <div class="nav-control">
                <ul>
                    <!-- HOME -->
                    <li>
                        <a class="dropdown-toggle" href="../../../index.jsp">Home</a>
                    </li>
                    <!-- BLOG -->
                    <li>
                        <a class="dropdown-toggle" href="../home.jsp">Blog</a>
                    </li>
                    <!-- CHI SIAMO -->
                    <li>
                        <a class="dropdown-toggle" href="../../../index.jsp#chisiamo">Chi Siamo</a>
                    </li>
                    <div class="mobile-only">
                        <%
                            session = request.getSession();
                            String validatedMobile =  String.valueOf(session.getAttribute("HasBeenValidated"));
                            if(Boolean.parseBoolean(validatedMobile))
                            {
                        %>
                        <li>
                            <a class="dropdown-toggle" href="/BlogEoG/logout">Logout</a>
                        </li>
                        <% } else { %>
                        <li>
                            <a class="dropdown-toggle" href="../../Login.jsp">Accedi</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="../../Register.jsp">Registrati</a>
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
                        String validated =  String.valueOf(session.getAttribute("HasBeenValidated"));
                        if(Boolean.parseBoolean(validated))
                        {
                    %>
                    <li>
                        <a class="dropdown-toggle" href="/BlogEoG/logout">Logout</a>
                    </li>
                    <% } else { %>
                    <li>
                        <a class="dropdown-toggle" href="../../Login.jsp">Accedi</a>
                    </li>
                    <li>
                        <a class="dropdown-toggle" href="../../Register.jsp">Registrati</a>
                    </li>
                    <% } %>
                    <li>
                        <a class="dropdown-toggle">
                            <button class="btn btn-primary btn-lg" id="btn-darkmode">Modalità Scura</button>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>
<!-- FINE MENU -->

<script src="../../../assets/js/darkmode.js"></script>

<!-- BODY -->
<div id="body">
    <!-- HEADER -->
    <section class="pageheader parallax height-450 parallax"
             style="background-image: url(../../../assets/images/blog/re-village.jpg);">
        <div class="pageheader-bg"></div>
    </section>

    <!-- POST -->
    <section class="bg padding-top-50 padding-bottom-50 padding-top-30">
        <div class="container">
            <div class="row sidebar">
                <div class="col-md-9 leftside">
                    <div class="post post-single">
                        <!-- TITOLO -->
                        <div class="post-header post-author">
                            <div class="post-title">
                                <h2>RESIDENT EVIL VILLAGE</h2>
                                <ul class="post-meta">
                                    <li><i class="fa fa-user"></i> Roman</li>
                                    <li><i class="fa fa-calendar-o"></i>02 Maggio, 2021</li>
                                </ul>
                            </div>
                        </div>

                        <!-- TRAMA -->
                        <div class="widget widget-list">
                            <div class="title">Trama</div>

                            <p>La nuova generazione del survival horror prende vita con Resident Evil Village,
                                l'ottavo capitolo della serie di Resident Evil. Immergiti in una grafica
                                ultra-realistica offerta dal RE Engine,
                                combatti per la tua sopravvivenza e scampa ai pericoli che si celano dietro ogni angolo.
                            </p>


                            <div class="post-thumbnail">
                                <img alt="" src="../../../assets/images/blog/reviii/re-1.jpg">
                            </div>

                            <p>Ambientata alcuni anni dopo gli orribili eventi dell'acclamato Resident Evil 7 biohazard,
                            questa inedita storia inizia con Ethan Winters e sua moglie Mia che vivono tranquilli in un
                            altro paese,
                            liberi dagli incubi del passato. Mentre si accingono a ricostruire la loro nuova vita
                            insieme, però,
                            la tragedia li colpisce ancora una volta. Quando il capitano della BSAA Chris Redfield
                            attacca la loro abitazione,
                            Ethan dovrà affrontare di nuovo l'inferno per riportare indietro sua figlia rapita.
                            </p>

                            <div class="post-thumbnail">
                                <img alt="" src="../../../assets/images/blog/reviii/re-2.jpg">
                            </div>
                        </div>

                        <!-- CARATTERISTICHE -->
                        <div class="widget widget-list">
                            <div class="title">Caratteristiche</div>

                            <p>Utilizza un gran numero di armi e oggetti contro avversari feroci e aggiungi risorse al
                                tuo inventario per superare ostacoli anche al di fuori del combattimento.</p>
                            <div class="post-thumbnail">
                                <img alt="" src="../../../assets/images/blog/reviii/re-3.jpg">
                            </div>
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
                <a href="../../PrivacyPolicy.jsp">Privacy Policy</a></p>
        </div>
    </div>
</footer>
<!-- FINE FOOTER -->

<!-- Javascript -->
<script src="../../../assets/third-party/jquery/jquery-1.11.1.min.js"></script>
<script src="../../../assets/third-party/bootstrap/js/bootstrap.min.js"></script>
<script src="../../../assets/third-party/core.min.js"></script>
</body>
</html>