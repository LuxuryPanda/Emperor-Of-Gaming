// seleziono il pulsante desktop del il cambio del tema
const btn = document.querySelector("#btn-darkmode");

// seleziono il puslante mobile
const btnMobile = document.querySelector("#btn-darkmode-mobile");

// seleziono il css caricato sul sito
const theme = document.querySelector("#theme-link");

// carico la variabile salvata nel registro locale del browser
const currentTheme = localStorage.getItem("theme");


// se la variabile salvata è uguale a "dark" si imposta il tema scuro altrimenti chiaro
if (currentTheme === "dark") {
    if (theme.getAttribute("href").includes("light.css")) {
        theme.href = theme.href.replace("light", "dark");
    }
} else {
    if (theme.getAttribute("href").includes("dark.css")) {
        theme.href = theme.href.replace("dark", "light");
    }
}

const onClick = function () {
    // se l'href del tema contiene "light.css" allora il tema passerà a dark e viceversa
    if (theme.getAttribute("href").includes("light.css")) {
        // si imposta il tema scuro e si salva la scelta
        theme.href = theme.href.replace("light", "dark");
        localStorage.setItem("theme", "dark");
    } else {
        // si imposta il tema chiaro e si salva la scelta
        theme.href = theme.href.replace("dark", "light");
        localStorage.setItem("theme", "light");
    }
}

// aggiungo il cambio del tema all'evento del click sui pulsanti
btn.addEventListener("click", onClick);
btnMobile.addEventListener("click", onClick);