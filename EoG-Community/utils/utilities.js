const User = require('../models/user');

function timeSince(date) {

  var seconds = Math.floor((new Date() - date) / 1000);
  var interval = seconds / 31536000;
  interval = Math.floor(interval);

  // YEARS
  if (interval > 1) {
    return Math.floor(interval) + " anni fa";
  }
  else if (interval === 1) {
    return Math.floor(interval) + " anno fa";
  }

  // MONTHS
  interval = seconds / 2592000;
  interval = Math.floor(interval);
  if (interval > 1) {
    return Math.floor(interval) + " mesi fa";
  }
  else if (interval === 1) {
    return Math.floor(interval) + " mese fa";
  }

  // DAYS
  interval = seconds / 86400;
  interval = Math.floor(interval);
  if (interval > 1) {
    return Math.floor(interval) + " giorni fa";
  }
  else if (interval === 1) {
    return Math.floor(interval) + " giorno fa";
  }

  // HOURS
  interval = seconds / 3600;
  interval = Math.floor(interval);
  if (interval > 1) {
    return Math.floor(interval) + " ore fa";
  }
  else if (interval === 1) {
    return Math.floor(interval) + " ora fa";
  }

  // MINUTES
  interval = seconds / 60;
  interval = Math.floor(interval);
  if (interval > 1) {
    return Math.floor(interval) + " minuti fa";
  }
  else if (interval === 1) {
    return Math.floor(interval) + " minuto fa";
  }

  if (interval === 1) {
    return Math.floor(seconds) + " secondo fa";
  }

  if(interval === 0){
    return "Adesso";
  }

  return Math.floor(seconds) + " secondi fa";
}


module.exports = {
  timeSince: timeSince,
}