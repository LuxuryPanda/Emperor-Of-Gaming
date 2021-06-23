<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it" >
<head>
    <%
        try {
            String validated =  String.valueOf(session.getAttribute("HasBeenValidated"));
            if (session.getAttribute("Username") == null || session.getAttribute("Username").equals("")) {
            }
            else if(!Boolean.parseBoolean(validated)){
                // ha già effettuato il login ma non ha inserito il codice 2FA
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <!-- META -->
    <meta charset="utf-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">

    <title>Accedi | EoG Blog</title>

    <!-- FAVICON -->
    <link href="../assets/images/emperor2.png" rel="shortcut icon">

    <!-- DarkMode -->
    <link href="../assets/css/light.css" id="theme-link" rel="stylesheet">


    <!-- CORE CSS -->
    <link href="../assets/third-party/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/css/utils.css" rel="stylesheet">
    <link href="../assets/css/loading.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700' rel='stylesheet' type='text/css'>

    <!-- PLUGINS -->
    <script type="text/javascript">
        var onloadCallback = function() {
            grecaptcha.render('captcha', {
                'sitekey' : '6Lcft70aAAAAACkboqCjisycCmWKHZsb4Gk7AjRf'
            });
        };
    </script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <link href="../assets/third-party/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="../assets/third-party/animate/animate.min.css" rel="stylesheet">
    <link href="../assets/third-party/animate/animate.delay.css" rel="stylesheet">
    <link href="../assets/third-party/owl-carousel/owl.carousel.css" rel="stylesheet">
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
        <a class="logo" href="../index.jsp">
            <img alt="" src="../assets/images/emperor2.png" style="max-width: 100%; height: 95%">
        </a>
        <!-- FINE LOGO -->
        <!-- MENU SX -->
        <nav>
            <div class="nav-control">
                <ul>
                    <!-- HOME -->
                    <li>
                        <a class="dropdown-toggle" href="../index.jsp">Home</a>
                    </li>
                    <!-- BLOG -->
                    <li>
                        <a class="dropdown-toggle" href="./blog/home.jsp">Blog</a>
                    </li>
                    <!-- CHI SIAMO -->
                    <li>
                        <a class="dropdown-toggle" href="../index.jsp#chisiamo">Chi Siamo</a>
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
                            <a class="dropdown-toggle" href="./Login.jsp">Accedi</a>
                        </li>
                        <li>
                            <a class="dropdown-toggle" href="./Register.jsp">Registrati</a>
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
                        <a class="dropdown-toggle" href="./Login.jsp">Accedi</a>
                    </li>
                    <li>
                        <a class="dropdown-toggle" href="./Register.jsp">Registrati</a>
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

<script src="../assets/js/darkmode.js"></script>
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
                    <div class="title">
                        <h4>Accedi</h4>
                    </div>
                    <form action="/BlogEoG/login" method="POST" name="LoginForm" onsubmit="return validateLogin()">
                        <label>
                            Nome utente:
                            <input class="form-control" type="text" name="nome" required style="color: black"/>
                        </label><br/>
                        <label>
                            Password:
                            <input class="form-control" type="password" name="password" required style="color: black"/>
                        </label><br/>

                        <br><div id="captcha" style="text-align: center; display: inline-block;"></div><br>

                        <input type="submit" value="Accedi" class="btn btn-primary"/>
                        <input type="reset" value="Cancella" class="btn btn-danger"/>
                    </form>
                    <p><a href="Password-Reset.html">Password dimenticata ?</a></p>


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
                <a href="PrivacyPolicy.jsp">Privacy Policy</a></p>
        </div>
    </div>
</footer>
<!-- FINE FOOTER -->

<!-- Javascript -->

<!-- Controllo completo della form -->
<script>
    function validateLogin() {
        var username = document.forms["LoginForm"]["username"];
        var password = document.forms["LoginForm"]["password"];

        if (username.value === "") {
            window.alert("Per favore inserisci il Nome Utente!");
            username.focus();
            return false;
        }


        if (password.value === "") {
            window.alert("Per favore inserisci la Password!");
            password.focus();
            return false;
        }

        return true;
    }
</script>
<!-- Controllo per il captcha -->
<script>
    $("LoginForm").submit(function (event) {
        var recaptcha = $("#g-recaptcha-response").val();
        if (recaptcha === "") {
            event.preventDefault();
            alert("Spunta il recaptcha");
        }
    });
</script>

<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
<script src="../assets/third-party/jquery/jquery-1.11.1.min.js"></script>
<script src="../assets/third-party/bootstrap/js/bootstrap.min.js"></script>
<script src="../assets/third-party/core.min.js"></script>
<script>
    $(window).on("load",function(){
        $(".loader-wrapper").fadeOut(1600);
    });
</script>
</body>
</html>