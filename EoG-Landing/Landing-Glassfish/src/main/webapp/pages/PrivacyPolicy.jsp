<!DOCTYPE html>
<html lang="it">
<head>
    <!-- META -->
    <meta charset="utf-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">

    <title>Privacy Policy | EoG Blog</title>

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
    <link href="../assets/third-party/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="../assets/third-party/animate/animate.min.css" rel="stylesheet">
    <link href="../assets/third-party/animate/animate.delay.css" rel="stylesheet">
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
                                <button class="btn btn-primary btn-lg" id="btn-darkmode-mobile">Modalita' Scura</button>
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
                            <button class="btn btn-primary btn-lg" id="btn-darkmode">Modalita' Scura</button>
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
            <div class="row" style="text-align: justify !important; text-justify: inter-word;">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="post" style="text-align: justify !important; text-justify: inter-word;">
                        <div class="title">
                            <h3>Privacy Policy di <strong>Blog.EmperorOfGaming.it</strong></h3>
                        </div>
                        <p>Questa Applicazione raccoglie alcuni Dati Personali dei propri Utenti.
                            Questo documento puo' essere stampato utilizzando il comando di stampa presente nelle
                            impostazioni di qualsiasi browser.</p><br><br>

                        <!-- TITOLARE TRATTAMENTO DATI -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h4 style="font-size: 16px; text-align: justify"> Titolare del Trattamento dei Dati </h4>
                        </div>
                        <p>BorysProductions Srl - Via Principessa Margherita, 25, 80074 Casamicciola Terme (Italia)</p>
                        <p><strong>Indirizzo email del Titolare:</strong> borysproductions@gmail.com</p><br><br><br>

                        <!-- TIPOLOGIE DI DATI -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h4 style="font-size: 16px;"> Tipologie di Dati raccolti </h4>
                        </div>
                        <p> Fra i Dati Personali raccolti da questa Applicazione, in modo autonomo o tramite terze
                            parti, ci sono: Cookie; Dati di utilizzo; email; nome; cognome; username; password. </p>
                        <p>Dettagli completi su ciascuna tipologia di dati raccolti sono forniti nelle sezioni dedicate
                            di questa privacy policy o mediante specifici testi informativi visualizzati prima della
                            raccolta dei dati stessi.<br> I Dati Personali possono essere liberamente forniti
                            dall'Utente o, nel caso di Dati di Utilizzo, raccolti automaticamente durante l'uso di
                            questa Applicazione.<br> Se non diversamente specificato, tutti i Dati richiesti da questa
                            Applicazione sono obbligatori. Se l'Utente rifiuta di comunicarli, potrebbe essere
                            impossibile per questa Applicazione fornire il Servizio. Nei casi in cui questa Applicazione
                            indichi alcuni Dati come facoltativi, gli Utenti sono liberi di astenersi dal comunicare
                            tali Dati, senza che cio' abbia alcuna conseguenza sulla disponibilita' del Servizio o sulla
                            sua operativita'.<br> Gli Utenti che dovessero avere dubbi su quali Dati siano obbligatori,
                            sono incoraggiati a contattare il Titolare.<br> L'eventuale utilizzo di Cookie - o di altri
                            strumenti di tracciamento - da parte di questa Applicazione o dei titolari dei servizi terzi
                            utilizzati da questa Applicazione, ove non diversamente precisato, ha la finalita' di fornire
                            il Servizio richiesto dall'Utente, oltre alle ulteriori finalita' descritte nel presente
                            documento e nella Cookie Policy, se disponibile.</p>
                        <p>L'Utente si assume la responsabilita' dei Dati Personali di terzi ottenuti, pubblicati o
                            condivisi mediante questa Applicazione e garantisce di avere il diritto di comunicarli o
                            diffonderli, liberando il Titolare da qualsiasi responsabilita' verso terzi.</p>
                        <br><br><br>

                        <!-- MODALITA' E LUOGO DEL TRATTAMENTO DEI DATI -->
                        <div class="title" style="padding-bottom: 10px;">
                            <h3 style="font-size: 18px;">Modalita' e luogo del trattamento dei Dati raccolti</h3>
                        </div>
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Modalita' di trattamento</h3>
                        </div>
                        <p>Il Titolare adotta le opportune misure di sicurezza volte ad impedire l'accesso, la
                            divulgazione, la modifica o la distruzione non autorizzate dei Dati Personali. <br> Il
                            trattamento viene effettuato mediante strumenti informatici e/o telematici, con modalita'
                            organizzative e con logiche strettamente correlate alle finalita' indicate. Oltre al
                            Titolare, in alcuni casi, potrebbero avere accesso ai Dati altri soggetti coinvolti
                            nell'organizzazione di questa Applicazione (personale amministrativo, commerciale,
                            marketing, legali, amministratori di sistema) ovvero soggetti esterni (come fornitori di
                            servizi tecnici terzi, corrieri postali, hosting provider, societa' informatiche, agenzie di
                            comunicazione) nominati anche, se necessario, Responsabili del Trattamento da parte del
                            Titolare. L'elenco aggiornato dei Responsabili potra' sempre essere richiesto al Titolare del
                            Trattamento.</p>

                        <!-- BASE GIURIDICA DEL TRATTAMENTO -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Base giuridica del trattamento</h3>
                        </div>
                        <p>Il Titolare tratta Dati Personali relativi all'Utente in caso sussista una delle seguenti
                            condizioni:</p>
                        <ul>
                            <li>l'Utente ha prestato il consenso per una o piu' finalita' specifiche; Nota: in alcuni
                                ordinamenti il Titolare puo' essere autorizzato a trattare Dati Personali senza che debba
                                sussistere il consenso dell'Utente o un'altra delle basi giuridiche specificate di
                                seguito, fino a quando l'Utente non si opponga (“opt-out”) a tale trattamento. Cio' non e'
                                tuttavia applicabile qualora il trattamento di Dati Personali sia regolato dalla
                                legislazione europea in materia di protezione dei Dati Personali;
                            </li>
                            <li>il trattamento e' necessario all'esecuzione di un contratto con l'Utente e/o
                                all'esecuzione di misure precontrattuali;
                            </li>
                            <li>il trattamento e' necessario per adempiere un obbligo legale al quale e' soggetto il
                                Titolare;
                            </li>
                            <li>il trattamento e' necessario per l'esecuzione di un compito di interesse pubblico o per
                                l'esercizio di pubblici poteri di cui e' investito il Titolare;
                            </li>
                            <li>il trattamento e' necessario per il perseguimento del legittimo interesse del Titolare o
                                di terzi.
                            </li>
                        </ul>
                        <p>e' comunque sempre possibile richiedere al Titolare di chiarire la concreta base giuridica di
                            ciascun trattamento ed in particolare di specificare se il trattamento sia basato sulla
                            legge, previsto da un contratto o necessario per concludere un contratto.</p>

                        <!-- LUOGO -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Luogo</h3>
                        </div>
                        <p>I Dati sono trattati presso le sedi operative del Titolare ed in ogni altro luogo in cui le
                            parti coinvolte nel trattamento siano localizzate. Per ulteriori informazioni, contatta il
                            Titolare.<br> I Dati Personali dell'Utente potrebbero essere trasferiti in un paese diverso
                            da quello in cui l'Utente si trova. Per ottenere ulteriori informazioni sul luogo del
                            trattamento l'Utente puo' fare riferimento alla sezione relativa ai dettagli sul trattamento
                            dei Dati Personali.</p>
                        <p>L'Utente ha diritto a ottenere informazioni in merito alla base giuridica del trasferimento
                            di Dati al di fuori dell'Unione Europea o ad un'organizzazione internazionale di diritto
                            internazionale pubblico o costituita da due o piu' paesi, come ad esempio l'ONU, nonche' in
                            merito alle misure di sicurezza adottate dal Titolare per proteggere i Dati.<br><br>
                            L'Utente puo' verificare se abbia luogo uno dei trasferimenti appena descritti esaminando la
                            sezione di questo documento relativa ai dettagli sul trattamento di Dati Personali o
                            chiedere informazioni al Titolare contattandolo agli estremi riportati in apertura.</p>

                        <!-- PERIODO DI CONSERVAZIONE -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Periodo di conservazione</h3>
                        </div>
                        <p>I Dati sono trattati e conservati per il tempo richiesto dalle finalita' per le quali sono
                            stati raccolti.</p>
                        <p>Pertanto:</p>
                        <ul>
                            <li>I Dati Personali raccolti per scopi collegati all'esecuzione di un contratto tra il
                                Titolare e l'Utente saranno trattenuti sino a quando sia completata l'esecuzione di tale
                                contratto.
                            </li>
                            <li>I Dati Personali raccolti per finalita' riconducibili all'interesse legittimo del
                                Titolare saranno trattenuti sino al soddisfacimento di tale interesse. L'Utente puo'
                                ottenere ulteriori informazioni in merito all'interesse legittimo perseguito dal
                                Titolare nelle relative sezioni di questo documento o contattando il Titolare.
                            </li>
                        </ul>
                        <p>Quando il trattamento e' basato sul consenso dell'Utente, il Titolare puo' conservare i Dati
                            Personali piu' a lungo sino a quando detto consenso non venga revocato. Inoltre, il Titolare
                            potrebbe essere obbligato a conservare i Dati Personali per un periodo piu' lungo in
                            ottemperanza ad un obbligo di legge o per ordine di un'autorita'.<br><br> Al termine del
                            periodo di conservazione i Dati Personali saranno cancellati. Pertanto, allo spirare di tale
                            termine il diritto di accesso, cancellazione, rettificazione ed il diritto alla portabilita'
                            dei Dati non potranno piu' essere esercitati.</p>
                        <br><br><br>

                        <!-- FINALITA' TRATTAMENTO DATI -->
                        <div class="title" style="padding-bottom: 10px;">
                            <h2 style="font-size: 18px;">Finalita' del Trattamento dei Dati raccolti</h2>
                        </div>
                        <p> I Dati dell'Utente sono raccolti per consentire al Titolare di fornire il Servizio,
                            adempiere agli obblighi di legge, rispondere a richieste o azioni esecutive, tutelare i
                            propri diritti ed interessi (o quelli di Utenti o di terze parti), individuare eventuali
                            attivita' dolose o fraudolente, nonche' per le seguenti finalita': Statistica, Interazione con
                            social network e piattaforme esterne, Contattare l'Utente, Accesso agli account su servizi
                            terzi, Pubblicita', Geolocalizzazione, Monitoraggio dell'infrastruttura, Visualizzazione di
                            contenuti da piattaforme esterne, Registrazione ed autenticazione, Commento dei contenuti,
                            Remarketing e behavioral targeting, Gestione dei database di Utenti e Gestione dei tag. </p>
                        <p>Per ottenere informazioni dettagliate sulle finalita' del trattamento e sui Dati Personali
                            trattati per ciascuna finalita', l'Utente puo' fare riferimento alla sezione “Dettagli sul
                            trattamento dei Dati Personali”.</p>


                        <!-- GESTIONE DEI DATABASE -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Gestione dei database di Utenti</h3>
                        </div>
                        <p>Questo tipo di servizi permettono al Titolare di costruire profili utente partendo da un
                            indirizzo email, il nome o qualunque altra informazione che l'Utente fornisce a questa
                            Applicazione, cosi' come di tracciare le attivita' dell'Utente tramite funzionalita'
                            statistiche. Questi Dati Personali potrebbero inoltre venire incrociati con informazioni
                            sull'Utente disponibili pubblicamente (come i profili sui social network) ed usati per
                            costruire profili privati che il Titolare puo' visualizzare ed utilizzare per migliorare
                            questa Applicazione.<br> Alcuni di questi servizi potrebbero inoltre permettere l'invio
                            programmato di messaggi all'Utente, come email basate su azioni specifiche compiute su
                            questa Applicazione.</p>

                        <!-- MONITORAGGIO DELL'INFRASTRUTTURA -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Monitoraggio dell'infrastruttura</h3>
                        </div>
                        <p>Questo tipo di servizi permette a questa Applicazione di monitorare l'utilizzo ed il
                            comportamento di componenti della stessa, per consentirne il miglioramento delle prestazioni
                            e delle funzionalita', la manutenzione o la risoluzione di problemi.<br> I Dati Personali
                            trattati dipendono dalle caratteristiche e della modalita' d'implementazione di questi
                            servizi, che per loro natura filtrano l'attivita' di questa Applicazione.</p>

                        <!-- REGISTRAZIONE ED AUTENTICAZIONE -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Registrazione ed autenticazione</h3>
                        </div>
                        <p>Con la registrazione o l'autenticazione l'Utente consente all'Applicazione di indentificarlo
                            e di dargli accesso a servizi dedicati.<br> A seconda di quanto indicato di seguito, i
                            servizi di registrazione e di autenticazione potrebbero essere forniti con l'ausilio di
                            terze parti. Qualora questo avvenga, questa applicazione potra' accedere ad alcuni Dati
                            conservati dal servizio terzo usato per la registrazione o l'identificazione.</p>

                        <!-- REGISTRAZIONE DIRETTA -->
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h4 style="font-size: 16px;">Registrazione diretta (Questa Applicazione)</h4>
                        </div>
                        <p>L'Utente si registra compilando il modulo di registrazione e fornendo direttamente a questa
                            Applicazione i propri Dati Personali.</p>
                        <p>Dati Personali trattati: cognome; email; nome; password; username.</p>
                        <br><br><br>

                        <div class="title" style="padding-bottom: 10px;">
                            <h2 style="font-size: 18px;">Ulteriori informazioni sul trattamento</h2>
                        </div>
                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Difesa in giudizio</h3>
                        </div>

                        <p>I Dati Personali dell'Utente possono essere utilizzati da parte del Titolare in giudizio o
                            nelle fasi preparatorie alla sua eventuale instaurazione per la difesa da abusi
                            nell'utilizzo di questa Applicazione o dei Servizi connessi da parte dell'Utente.<br>
                            L'Utente dichiara di essere consapevole che il Titolare potrebbe essere obbligato a rivelare
                            i Dati per ordine delle autorita' pubbliche.</p>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Informative specifiche</h3>
                        </div>
                        <p>Su richiesta dell'Utente, in aggiunta alle informazioni contenute in questa privacy policy,
                            questa Applicazione potrebbe fornire all'Utente delle informative aggiuntive e contestuali
                            riguardanti Servizi specifici, o la raccolta ed il trattamento di Dati Personali.</p>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Log di sistema e manutenzione</h3>
                        </div>
                        <p>Per necessita' legate al funzionamento ed alla manutenzione, questa Applicazione e gli
                            eventuali servizi terzi da essa utilizzati potrebbero raccogliere log di sistema, ossia file
                            che registrano le interazioni e che possono contenere anche Dati Personali, quali
                            l'indirizzo IP Utente.</p>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 16px;">Informazioni non contenute in questa policy</h3>
                        </div>
                        <p>Ulteriori informazioni in relazione al trattamento dei Dati Personali potranno essere
                            richieste in qualsiasi momento al Titolare del Trattamento utilizzando gli estremi di
                            contatto.</p>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h3 style="font-size: 18px;"> Definizioni e riferimenti legali </h3>
                        </div>
                            <h4 style="font-size: 16px;">Dati Personali (o Dati)</h4>
                        <p>Costituisce dato personale qualunque informazione che, direttamente o indirettamente, anche
                            in collegamento con qualsiasi altra informazione, ivi compreso un numero di identificazione
                            personale, renda identificata o identificabile una persona fisica.</p>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h4 style="font-size: 16px;">Dati di Utilizzo</h4>
                        </div>
                        <p>Sono le informazioni raccolte automaticamente attraverso questa Applicazione (anche da
                            applicazioni di parti terze integrate in questa Applicazione), tra cui: gli indirizzi IP o i
                            nomi a dominio dei computer utilizzati dall'Utente che si connette con questa Applicazione,
                            gli indirizzi in notazione URI (Uniform Resource Identifier), l'orario della richiesta, il
                            metodo utilizzato nell'inoltrare la richiesta al server, la dimensione del file ottenuto in
                            risposta, il codice numerico indicante lo stato della risposta dal server (buon fine,
                            errore, ecc.) il paese di provenienza, le caratteristiche del browser e del sistema
                            operativo utilizzati dal visitatore, le varie connotazioni temporali della visita (ad
                            esempio il tempo di permanenza su ciascuna pagina) e i dettagli relativi all'itinerario
                            seguito all'interno dell'Applicazione, con particolare riferimento alla sequenza delle
                            pagine consultate, ai parametri relativi al sistema operativo e all'ambiente informatico
                            dell'Utente.</p>
                        <br><br><br>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h4 style="font-size: 16px;">Utente</h4>
                        </div>
                        <p>L'individuo che utilizza questa Applicazione che, salvo ove diversamente specificato,
                            coincide con l'Interessato.</p>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h4 style="font-size: 16px;">Interessato</h4>
                        </div>
                        <p>La persona fisica cui si riferiscono i Dati Personali.</p> <h4>Responsabile del Trattamento
                        (o Responsabile)</h4>
                        <p>La persona fisica, giuridica, la pubblica amministrazione e qualsiasi altro ente che tratta
                            dati personali per conto del Titolare, secondo quanto esposto nella presente privacy
                            policy.</p> <h4>Titolare del Trattamento (o Titolare)</h4>
                        <p>La persona fisica o giuridica, l'autorita' pubblica, il servizio o altro organismo che,
                            singolarmente o insieme ad altri, determina le finalita' e i mezzi del trattamento di dati
                            personali e gli strumenti adottati, ivi comprese le misure di sicurezza relative al
                            funzionamento ed alla fruizione di questa Applicazione. Il Titolare del Trattamento, salvo
                            quanto diversamente specificato, e' il titolare di questa Applicazione.</p> <h4>Questa
                        Applicazione</h4>
                        <p>Lo strumento hardware o software mediante il quale sono raccolti e trattati i Dati Personali
                            degli Utenti.</p>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h4 style="font-size: 16px;">Servizio</h4>
                        </div>
                        <p>Il Servizio fornito da questa Applicazione cosi' come definito nei relativi termini (se
                            presenti) su questo sito/applicazione.</p>


                        <div class="title" style="padding-bottom: 10px;">
                            <h4 style="font-size: 18px;">Unione Europea (o UE)</h4>
                        </div>
                        <p>Salvo ove diversamente specificato, ogni riferimento all'Unione Europea contenuto in questo
                            documento si intende esteso a tutti gli attuali stati membri dell'Unione Europea e dello
                            Spazio Economico Europeo.</p>

                        <div class="title" style="text-align: justify; padding-bottom: 10px;">
                            <h4 style="font-size: 16px;">Riferimenti legali</h4>
                        </div>
                        <p>La presente informativa privacy e' redatta sulla base di molteplici ordinamenti legislativi,
                            inclusi gli art. 13 e 14 del Regolamento (UE) 2016/679.</p>
                        <p>Ove non diversamente specificato, questa informativa privacy riguarda esclusivamente questa
                            Applicazione.</p>
                        <p> Ultima modifica: 04 maggio 2021 </p>
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
                <a href="./PrivacyPolicy.jsp">Privacy Policy</a></p>
        </div>
    </div>
</footer>
<!-- FINE FOOTER -->

<!-- Javascript -->
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