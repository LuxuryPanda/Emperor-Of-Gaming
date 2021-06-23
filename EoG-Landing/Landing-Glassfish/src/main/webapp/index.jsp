<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <!-- META -->
    <meta charset="utf-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">

    <title>Home | EoG Blog</title>

    <!-- FAVICON -->
    <link href="assets/images/emperor2.png" rel="shortcut icon">

    <!-- DarkMode -->
    <link href="assets/css/light.css" id="theme-link" rel="stylesheet">


    <!-- CORE CSS -->
    <link href="assets/third-party/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/utils.css" rel="stylesheet">
    <link href="./assets/css/loading.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700' rel='stylesheet' type='text/css'>

    <!-- PLUGINS -->
    <link href="assets/third-party/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/third-party/animate/animate.min.css" rel="stylesheet">
    <link href="assets/third-party/animate/animate.delay.css" rel="stylesheet">
    <link href="assets/third-party/owl-carousel/owl.carousel.css" rel="stylesheet">
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
        <a class="logo" href="index.jsp">
            <img alt="" src="assets/images/emperor2.png" style="max-width: 100%; height: 95%">
        </a>
        <!-- FINE LOGO -->
        <!-- MENU SX -->
        <nav>
            <div class="nav-control">
                <ul>
                    <!-- HOME -->
                    <li>
                        <a class="dropdown-toggle" href="index.jsp">Home</a>
                    </li>
                    <!-- BLOG -->
                    <li>
                        <a class="dropdown-toggle" href="pages/blog/home.jsp">Blog</a>
                    </li>
                    <!-- CHI SIAMO -->
                    <li>
                        <a class="dropdown-toggle" href="#chisiamo">Chi Siamo</a>
                    </li>
                    <div class="mobile-only">
                        <%
                            session = request.getSession();
                            String isAdmin =  String.valueOf(session.getAttribute("isAdmin"));
                            if(Boolean.parseBoolean(isAdmin))
                            {
                        %>
                        <li>
                            <a class="dropdown-toggle" href="./pages/admin/crea-post.jsp">Crea Post</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="./pages/admin/lista-post.jsp">Lista Post</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="./pages/admin/lista-utenti.jsp">Lista Utenti</a>
                        </li>
                        <% } %>
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
                            <a class="dropdown-toggle" href="pages/Login.jsp">Accedi</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="pages/Register.jsp">Registrati</a>
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
                        if(Boolean.parseBoolean(isAdmin))
                        {
                    %>
                    <li>
                        <a class="dropdown-toggle" href="./pages/admin/crea-post.jsp">Crea Post</a>
                    </li>
                    <li>
                        <a class="dropdown-toggle" href="./pages/admin/lista-post.jsp">Lista Post</a>
                    </li>
                    <li>
                        <a class="dropdown-toggle" href="./pages/admin/lista-utenti.jsp">Lista Utenti</a>
                    </li>
                    <% } %>
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
                            <a class="dropdown-toggle" href="pages/Login.jsp">Accedi</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="pages/Register.jsp">Registrati</a>
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

<script src="./assets/js/darkmode.js"></script>
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
    <!-- Slider -->
    <div class="ken-burns carousel slide full-carousel carousel-fade" data-ride="carousel" id="full-carousel">
        <ol class="carousel-indicators">
            <li class="active" data-slide-to="0" data-target="#full-carousel"></li>
            <li data-slide-to="1" data-target="#full-carousel"></li>
            <li data-slide-to="2" data-target="#full-carousel"></li>
        </ol>
        <div class="carousel-inner">
            <!-- SLIDE 1 -->
            <div class="item active inactiveUntilOnLoad parallax">
                <img alt="" style="width: 100%; height: 100%; object-fit: cover;" src="assets/images/slider/female-viking-assassin-s-creed-valhalla_1400x900.jpg">
                <div class="container">
                    <div class="carousel-caption">
                        <h1 data-animation="animated animate1 bounceInDown">Assassin's Creed Valhalla</h1>
                        <p data-animation="animated animate7 fadeInUp">Iscriviti ad EoG per scoprirne di più!</p>
                        <a class="btn btn-primary btn-lg btn-rounded" data-animation="animated animate10 fadeInDown"
                           data-toggle="modal"
                           href="https://emperor-of-gaming.herokuapp.com/">Unisciti alla community!</a>
                    </div>
                </div>
            </div>

            <!-- SLIDE 2 -->
            <div class="item">
                <img alt="" style="width: 100%; height: 100%; object-fit: cover;" src="assets/images/slider/star-wars-republic-commando-1920x1080.jpg">
                <div class="container">
                    <div class="carousel-caption">
                        <h1 data-animation="animated animate1 bounceInDown">Star Wars: Republic Commando</h1>
                        <p data-animation="animated animate7 fadeIn">Iscriviti ad EoG per scoprirne di più!</p>
                        <a class="btn btn-primary btn-lg btn-rounded" data-animation="animated animate10 fadeIn"
                           data-toggle="modal"
                           href="https://emperor-of-gaming.herokuapp.com/">Unisciti alla community!</a>
                    </div>
                </div>
            </div>

            <!-- SLIDE 3 -->
            <div class="item">
                <img alt="" style="width: 100%; height: 100%; object-fit: cover;" src="assets/images/slider/tom-clancys-elitè-squad-1920x1080.jpg">
                <div class="container">
                    <div class="carousel-caption">
                        <h1 data-animation="animated animate1 bounceInDown">Tom Clancy's Elite Squad</h1>
                        <p data-animation="animated animate7 fadeIn">Iscriviti ad EoG per scoprirne di più!</p>
                        <a class="btn btn-primary btn-lg btn-rounded" data-animation="animated animate10 fadeIn"
                           data-toggle="modal"
                           href="https://emperor-of-gaming.herokuapp.com/">Unisciti alla community!</a>
                    </div>
                </div>
            </div>

            <!-- FRECCE SLIDER -->
            <a class="left carousel-control" data-slide="prev" href="#full-carousel">
                <span aria-hidden="true" class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" data-slide="next" href="#full-carousel">
                <span aria-hidden="true" class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
    </div>

    <!-- CHI SIAMO -->
    <section class="bg relative" id="chisiamo">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="title outline">
                        <h4 style="margin-right: 10px"><a class="fa fa-group"></a></h4>
                        <h4> Chi siamo </h4>
                        <h4 style="margin-left: 10px"><a class="fa fa-group"></a></h4>
                        <p>Emperor of Gaming è una community privata dedicata agli amanti dei videogiochi.
                            <br>Se anche tu vuoi far parte di questa community accedi o registrati nell'area dedicata!</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ULTIME NEWS -->
    <section class="bg relative">
        <div class="container">
            <!-- TITOLO -->
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="title outline">
                        <h4 style="margin-right: 10px">
                            <a class="fa fa-newspaper-o"></a>
                        </h4>
                        <h4>Ultime News</h4>
                        <h4 style="margin-left: 10px">
                            <a class="fa fa-newspaper-o"></a>
                        </h4>
                        <p>Leggi le news degli ultimi giochi rilasciati ed in corso di rilascio!</p>
                    </div>
                </div>
            </div>

            <!-- POSTS -->
            <div class="row">
                <!-- GIOCO 1 - CRASH BANDICOOT 4: IT'S ABOUT TIME -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="assets/images/blog/crash-bandicoot-4.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="pages/blog/posts/crash-bandicoot-4.html">CRASH BANDICOOT 4:
                                IT'S ABOUT TIME</a></h3>
                            <ul>
                                <li>29 Marzo, 2021</li>
                            </ul>
                            <p><br>Crash è tornato! Nel primo capitolo della saga di Crash dopo oltre dieci anni ed ora
                                con nuovi poteri e nuovi mondi.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 2 - KINGDOM HEARTS III RE MIND -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="assets/images/blog/kingdom-hearts-3.png">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="pages/blog/posts/kingdom-hearts-iii.html">KINGDOM HEARTS III
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

                <!-- GIOCO 3 - OUTRIDERS -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="assets/images/blog/outriders.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="pages/blog/posts/outriders.html">OUTRIDERS</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Un vero ibrido di generi, unisce dei combattimenti brutali e sanguinosi a delle profonde
                                meccaniche dei GdR con alberi delle abilità estesi e un’infinità di modifiche per
                                l’equipaggiamento.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 4 - INDUSTRIA -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="assets/images/blog/industria.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="pages/blog/posts/industria.html">INDUSTRIA</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Un classico sparatutto in prima persona che ti catapulterà in un universo parallelo di
                                poco antecedente alla fine della Guerra Fredda.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 5 - ODDWORLD: SOULSTORM -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="assets/images/blog/oddworld-soulstorm.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="pages/blog/posts/oddworld-soulstorm.html">ODDWORLD:
                                SOULSTORM</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Un'esplosiva avventura d'azione in cui potrai creare, ricercare e muoverti furtivamente e
                                che presenta caratteristiche tipiche dei platform.</p>
                        </div>
                    </div>
                </div>

                <!-- GIOCO 6 - DAYS GONE -->
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="card card-hover">
                        <div class="card-img">
                            <img alt="" src="assets/images/blog/days-gone.jpg">
                        </div>
                        <div class="caption">
                            <h3 class="card-title"><a href="pages/blog/posts/days-gone.html">DAYS GONE</a></h3>
                            <ul>
                                <li>02 Maggio, 2021</li>
                            </ul>
                            <p>Combatti ed esplora i letali Stati Uniti d'America post-pandemici in questo gioco
                                open world di azione/avventura calandoti nel ruolo di Deacon St..</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- BTN ALTRI POST -->
            <div class="text-center">
                <a class="btn btn-primary btn-lg btn-rounded btn-icon-right margin-top-10 margin-bottom-20"
                   href="/BlogEoG/pages/Login.jsp"> Mostra altri post <i class="fa fa-angle-right"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- VIDEO YT -->
    <div class="background-image">
        <div class="container">
            <div class="embed-responsive embed-responsive-16by9">
                <iframe allowfullscreen
                        class="embed-responsive-item"
                        src="https://www.youtube.com/embed/PgI2Byf_AR4?rel=0&amp;showinfo=0"></iframe>
            </div>
        </div>
    </div>
</div>
<!-- FINE BODY -->

<!-- FOOTER -->
<footer>
    <div class="footer-bottom">
        <div class="container">
            <p>&copy; 2021 Copyright BorysProductions | Tutti i diritti riservati. |
                <a href="pages/PrivacyPolicy.jsp">Privacy Policy</a></p>
        </div>
    </div>
</footer>
<!-- FINE FOOTER -->

<style>
    @media (min-width: 768px) and (max-width: 100px) {
        .card .caption p {
            line-height: 1.5rem;
        }
    }
</style>

<!-- Javascript -->

<script src="assets/third-party/jquery/jquery-1.11.1.min.js"></script>
<script src="assets/third-party/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/third-party/core.min.js"></script>
<script src="assets/third-party/owl-carousel/owl.carousel.min.js"></script>

<script>
    (function ($) {
        "use strict";
        var owl = $(".owl-carousel");

        owl.owlCarousel({
            items: 4, //4 items above 1000px browser width
            itemsDesktop: [1000, 3], //3 items between 1000px and 0
            itemsTablet: [600, 1], //1 items between 600px and 0
            itemsMobile: false // itemsMobile disabled - inherit from itemsTablet option
        });

        $(".next").click(function () {
            owl.trigger('owl.next');
            return false;
        })
        $(".prev").click(function () {
            owl.trigger('owl.prev');
            return false;
        })
    })(jQuery);
</script>
<script>
    $(window).on("load",function(){
        $(".loader-wrapper").fadeOut(1600);
    });
</script>
</body>
</html>