<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it" style="background-color: #151718!important;">
<head>
    <!-- META -->
    <meta charset="UTF-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">

    <title>Registrazione | EoG Blog</title>

    <!-- FAVICON -->
    <link href="../assets/images/emperor2.png" rel="shortcut icon">

    <!-- DarkMode -->
    <link href="../assets/css/light.css" id="theme-link" rel="stylesheet">


    <!-- CORE CSS -->
    <link href="../assets/third-party/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/css/utils.css" rel="stylesheet">
    <link href="../assets/css/loading.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700' rel='stylesheet' type='text/css'>

    <style>
        /* Stile dell'area per la validazione della password */
        #messaggioPassword {
            display:none;
            background: rgba(251,247,247,0);
            color: #000;
            position: relative;
            margin-top: 10px;
        }

        #messaggioPassword p {
            padding: 10px 35px;
            font-size: 18px;
        }

        /* Stile per il colore del testo quando la password rispetta la regola  */
        .valid {
            color: green;
        }

        .valid:before {
            position: relative;
            left: -35px;
            content: "✔";
        }

        /* Add a red text color and an "x" when the requirements are wrong */
        .invalid {
            color: red;
        }

        .invalid:before {
            position: relative;
            left: -35px;
            content: "✖";
        }
        #text {display:none;color: #ff0000
        }
        ::marker{
            color: transparent;
        }
    </style>

    <!-- PLUGINS -->
    <script type="text/javascript">
        var onloadCallback = function () {
            grecaptcha.render('captcha', {
                'sitekey': '6Lcft70aAAAAACkboqCjisycCmWKHZsb4Gk7AjRf'
            });
        };
    </script>
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
                        <h4>Registrati</h4>
                    </div>
                    <form action="/BlogEoG/registrazione" method="POST" name="RegForm"
                          onsubmit="return validateRegistration()">
                        <label>
                            Nome utente:
                            <input class="form-control" maxlength="15" minlength="4" name="username"
                                   style="color: black" type="text"/>
                        </label>
                        <label>
                            Email:
                            <input class="form-control"
                                   name="email" required style="color: black" type="email"/>
                        </label><br/>

                        <label>
                            Nome:
                            <input class="form-control" maxlength="64" minlength="1" name="nome" style="color: black"
                                   type="text"/>
                        </label>
                        <label>
                            Cognome:
                            <input class="form-control" maxlength="64" minlength="1" name="cognome" style="color: black"
                                   type="text"/>
                        </label><br/>

                        <label>
                            Password:
                            <input class="form-control" id="password" maxlength="32" minlength="8"
                                   name="password"
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                                   style="color: black"
                                   title="Deve essere di almeno 8 caratteri, e deve contenere almeno un numero, una lettera maiuscola ed una minuscola"
                                   type="password"/>
                        </label>
                        <label>
                            Conferma Password:
                            <input class="form-control" id="confirmPassword" maxlength="32" minlength="8"
                                   name="confirmPassword"
                                   onkeyup='check();'
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" style="color: black"
                                   title="Deve contenere almeno un numero e una lettera maiuscola e minuscola e almeno 8 o piÃ¹ caratteri"
                                   type="password"/>
                        </label><br/>

                        <label>
                            Mostra Password
                            <input onclick="displayPassword()" type="checkbox">
                        </label><br/>

                        <br/><span id='message'></span><br/>
                        <div id="messaggioPassword">
                            <div class="title">
                                <h4 style="">La password deve contenere quanto segue:</h4>
                            </div>
                            <p id="letter" class="invalid">Una <b>lettera</b> minuscola</p>
                            <p id="capital" class="invalid">Una <b>lettera</b> maiuscola</p>
                            <p id="number" class="invalid">Un <b>numero</b></p>
                            <p id="length" class="invalid">Minimo <b>8 caratteri</b></p>
                        </div>


                        <br>
                        <div id="captcha" style="text-align: center; display: inline-block;"></div>
                        <br>


                        <input class="btn btn-primary" onClick="window.alert('Gentile utente, registrandoti accetti le nostre normative sulla Privacy')"
                               type="submit"
                               value="Registrati"/>
                        <input class="btn btn-danger" type="reset" value="Cancella"/>
                    </form>


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

<!-- Controllo della password -->
<script>
    var check = function () {
        if (document.getElementById('password').value ===
            document.getElementById('confirmPassword').value) {
            document.getElementById('message').style.color = 'green';
            document.getElementById('message').innerHTML = 'Le password corrispondono';
        } else {
            document.getElementById('message').style.color = 'red';
            document.getElementById('message').innerHTML = 'Le password non corrispondono';
        }
    }
</script>

<!-- Controllo completo della password -->
<script>
    var passwordField = document.getElementById("password");
    var letter = document.getElementById("letter");
    var capital = document.getElementById("capital");
    var number = document.getElementById("number");
    var length = document.getElementById("length");

    // When the user clicks on the password field, show the message box
    passwordField.onfocus = function() {
        document.getElementById("messaggioPassword").style.display = "block";
    }

    // When the user clicks outside of the password field, hide the message box
    passwordField.onblur = function() {
        document.getElementById("messaggioPassword").style.display = "none";
    }

    // When the user starts to type something inside the password field
    passwordField.onkeyup = function() {
        // Validate lowercase letters
        var lowerCaseLetters = /[a-z]/g;
        if(passwordField.value.match(lowerCaseLetters)) {
            letter.classList.remove("invalid");
            letter.classList.add("valid");
        } else {
            letter.classList.remove("valid");
            letter.classList.add("invalid");
        }

        // Validate capital letters
        var upperCaseLetters = /[A-Z]/g;
        if(passwordField.value.match(upperCaseLetters)) {
            capital.classList.remove("invalid");
            capital.classList.add("valid");
        } else {
            capital.classList.remove("valid");
            capital.classList.add("invalid");
        }

        // Validate numbers
        var numbers = /[0-9]/g;
        if(passwordField.value.match(numbers)) {
            number.classList.remove("invalid");
            number.classList.add("valid");
        } else {
            number.classList.remove("valid");
            number.classList.add("invalid");
        }

        // Validate length
        if(passwordField.value.length >= 8) {
            length.classList.remove("invalid");
            length.classList.add("valid");
        } else {
            length.classList.remove("valid");
            length.classList.add("invalid");
        }
    }
</script>

<!-- Controllo completo della form -->
<script>
    function validateRegistration() {
        var username = document.forms["RegForm"]["username"];
        var nome = document.forms["RegForm"]["nome"];
        var cognome = document.forms["RegForm"]["cognome"];
        var email = document.forms["RegForm"]["email"];
        var password = document.forms["RegForm"]["password"];
        var confermaPassword = document.forms["RegForm"]["confirmPassword"];

        if (username.value === "") {
            window.alert("Per favore inserisci il Nome Utente!");
            username.focus();
            return false;
        }

        if (nome.value === "") {
            window.alert("Per favore inserisci il Nome!");
            nome.focus();
            return false;
        }

        if (cognome.value === "") {
            window.alert("Per favore inserisci il Cognome!");
            cognome.focus();
            return false;
        }

        if (email.value === "") {
            window.alert("Per favore inserisci l'Email!");
            email.focus();
            return false;
        }

        if (password.value === "") {
            window.alert("Per favore inserisci la Password!");
            password.focus();
            return false;
        }

        if (confermaPassword.value === "") {
            window.alert("Per favore inserisci la Password di Conferma!");
            confermaPassword.focus();
            return false;
        }

        if (password.value !== confermaPassword.value) {
            window.alert("Attenzione, le Password non corrispondono!");
            password.focus();
            return false;
        }

        return true;
    }
</script>

<!-- Visualizzazione delle Password -->
<script>
    function displayPassword() {
        // Visualizzazione in chiaro della Password
        var x = document.getElementById("password");
        if (x.type === "password") {
            x.type = "text";
        } else {
            x.type = "password";
        }

        // Visualizzazione in chiaro della Conferma Password
        var x = document.getElementById("confirmPassword");
        if (x.type === "password") {
            x.type = "text";
        } else {
            x.type = "password";
        }
    }

    function displayConfirmPassword() {

    }
</script>

<!-- Controllo per il captcha -->
<script>
    $("RegForm").submit(function (event) {
        var recaptcha = $("#g-recaptcha-response").val();
        if (recaptcha === "") {
            event.preventDefault();
            alert("Spunta il recaptcha");
        }
    });
</script>

<script async defer src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"></script>
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