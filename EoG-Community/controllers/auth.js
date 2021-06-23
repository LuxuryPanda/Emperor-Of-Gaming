const crypto = require('crypto');

const bcrypt = require('bcryptjs');
const nodemailer = require('nodemailer');
const { validationResult } = require('express-validator/check');
const { Op } = require('sequelize');

var smtpConfig = {
  host: 'smtp.gmail.com',
  port: 465,
  secure: true, // use SSL
  auth: {
    user: 'myemail',
    pass: 'mypassword'
  }
};
const transporter = nodemailer.createTransport(smtpConfig);

const User = require('../models/user');

// Get request per l'index con registrazione e login
exports.getIndex = (req, res, next) => {
  let message = req.flash('error');
  if (message.length > 0) {
    message = message[0];
  }
  else {
    message = null;
  }

  let messageLogin = req.flash('errorLogin');
  if (messageLogin.length > 0) {
    messageLogin = messageLogin[0];
  }
  else {
    messageLogin = null;
  }

  res.render('auth/index', {
    pageTitle: 'Home',
    path: '/',
    errorMessage: message,
    loginErrorMessage: messageLogin,
    validationErrors: [],
    authenticating: false,
    oldInput: {
      loginUsername: '',
      loginPassword: '',
      registerUsername: '',
      registerEmail: '',
      registerPassword: '',
      registerConfirmPassword: ''
    }
  });
};


// Post request per la Registrazione
exports.postRegister = (req, res, next) => {
  const username = req.body.registerUsername;
  const email = req.body.registerEmail;
  const password = req.body.registerPassword;
  const confirmPassword = req.body.registerConfirmPassword;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    console.log(errors.array())
    return res.status(422).render('auth/index', {
      pageTitle: 'Home',
      errorMessage: errors.array()[0].msg,
      loginErrorMessage: '',
      authenticating: false,
      oldInput: {
        loginUsername: '',
        loginPassword: '',
        registerUsername: username,
        registerEmail: email,
        registerPassword: password,
        registerConfirmPassword: confirmPassword
      },
      validationErrors: errors.array()
    });
  }


  User.findOne({ where: { [Op.or]: [{ username: username }, { email: email }] } })
    .then(user => {
      if (user) {

        var errorMsg = '';
        if (user.username === username && user.email === email) {
          errorMsg = 'Nome Utente e Email sono già registrate!';
        }
        else if (user.username === username) {
          errorMsg = 'Nome Utente già registrato!';
        }
        else {
          errorMsg = 'Email già registrata!';
        }

        return res.status(422).render('auth/index', {
          pageTitle: 'Home',
          errorMessage: errorMsg,
          loginErrorMessage: '',
          authenticating: false,
          oldInput: {
            loginUsername: '',
            loginPassword: '',
            registerUsername: username,
            registerEmail: email,
            registerPassword: password,
            registerConfirmPassword: confirmPassword
          },
          validationErrors: errors.array()
        });
      }
    })
    .catch(err => {
      const error = new Error(err);
      error.httpStatusCode = 500;
      next(error);
    });

  var token = '';
  crypto.randomBytes(32, (err, buffer) => {
    if (err) {
      console.log(err);
      return res.redirect('/reset');
    }

    token = buffer.toString('hex');
  });

  bcrypt.hash(password, 12)
    .then(hashedPW => {
      const newUser = new User({
        username: username,
        email: email,
        password: hashedPW,
        isActivated: false,
        isBanned: false,
        activationToken: token,
        activationTokenExpiration: Date.now() + 1800000,
        joinDate: Date.now()
      })

      return newUser.save()
        .then(result => {
          return newUser.createPersonalInfo()
        })
        .then(result => {
          return newUser.createSecurityInfo()
        })
        .then(result => {
          return newUser.createAccountInfo();
        });
    })
    .then(result => {
      res.redirect('/login');
      return transporter.sendMail({
        to: email,
        from: 'myemail',
        subject: 'Registrazione effettuata! | EoG Community',
        html: `
        <h1>Grazie per la tua registrazione!</h1>
        <p>Per attivare il tuo account clicca sul 
        <a href="${process.env.URL_WEBSITE}/attivazione/${token}">link</a>.</p>
        <p>Il link scadrà fra 30 minuti.</p>
        `
      })
        .catch(err => console.log(err));
    })
    .catch(err => {
      const error = new Error(err);
      error.httpStatusCode = 500;
      next(error);
    });
};

// Post request per il Login
exports.postLogin = (req, res, next) => {
  const email = req.body.loginEmail;
  const password = req.body.loginPassword;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(422).render('auth/index', {
      pageTitle: 'Benvenuto',
      errorMessage: '',
      loginErrorMessage: errors.array()[0].msg,
      authenticating: false,
      oldInput: {
        loginEmail: email,
        loginPassword: password,
        registerUsername: '',
        registerEmail: '',
        registerPassword: '',
        registerConfirmPassword: ''
      },
      validationErrors: errors.array()
    });
  }

  User.findOne({ where: { email: email } })
    .then(user => {
      let loggingUser = user;
      if (!user) {
        req.session.isLoggedIn = false;
        return res.status(422).render('auth/index', {
          pageTitle: 'Home',
          errorMessage: '',
          loginErrorMessage: 'L\'Email inserita non è registrata!',
          authenticating: false,
          oldInput: {
            loginEmail: email,
            loginPassword: password,
            registerUsername: '',
            registerEmail: '',
            registerPassword: '',
            registerConfirmPassword: ''
          },
          validationErrors: [{ param: 'email' }]
        });
      }

      // se l'account non è stato attivato allora riinvio l'email di attivazione 
      // con un nuovo token
      if (!user.isActivated) {

        var token = '';
        return crypto.randomBytes(32, (err, buffer) => {
          if (err) {
            console.log(err);
            return res.redirect('/');
          }

          if (user.activationTokenExpiration < Date.now()) {
            console.log('Sending email');
            token = buffer.toString('hex');
            user.activationToken = token;
            user.activationTokenExpiration = Date.now() + 1800000;
            user.save();
            // invio una nuova email di attivazione e mando l'utente
            transporter.sendMail({
              to: email,
              from: 'myemail',
              subject: 'Attivazione account! | EoG Community',
              html: `
              <h1>Attiva il tuo account!</h1>
              <p>Prima di poter accedere al tuo account devi attivarlo cliccando sul 
              <a href="${process.env.URL_WEBSITE}/attivazione/${token}">link</a>.</p>
              <p>Il link scadrà fra 30 minuti.</p>
              `
            });
          }

          req.session.isLoggedIn = false;
          res.status(422).render('auth/index', {
            pageTitle: 'Home',
            errorMessage: '',
            loginErrorMessage: 'Prima di poter accedere devi attivare il tuo account!',
            authenticating: false,
            oldInput: {
              loginEmail: email,
              loginPassword: password,
              registerUsername: '',
              registerEmail: '',
              registerPassword: '',
              registerConfirmPassword: ''
            },
            validationErrors: [{ param: 'email' }]
          });
        });
      }

      // vedo se la password inserita corrisponde alla password nel DB
      bcrypt.compare(password, user.password)
        .then(doMatch => {
          if (doMatch) {
            // invia codice A2F
            var code2fa = Math.floor(100000 + Math.random() * 900000);

            if (user.code2fa) {
              if (user.code2faExpiration < Date.now()) {
                user.code2fa = code2fa;
                user.code2faExpiration = Date.now() + 300000; // scade in 5 minuti
                user.save();

                // invio una nuova email di attivazione e mando l'utente
                transporter.sendMail({
                  to: email,
                  from: 'myemail',
                  subject: 'Il tuo codice d\'accesso a due fattori! | EoG Community',
                  html: `
                  <h2>Il tuo codice d'accesso a due fattori:</h2>
                  <h1>${code2fa}</h1>
                  <p>Il codice scadrà fra 5 minuti.</p>
                  <br><br><p>Ciao,</p>
                  <br><p>Abbiamo notato che hai effettuato l'accesso da un nuovo dispositivo, 
                  con un browser differente o da una posizione diversa. Utilizza il codice qui sopra 
                  per effettuare l'accesso.</p>
                  <br><p>Grazie,<br>
                  Il team di BorysProductions</p>
                  `
                });
              }
            }
            else {
              user.code2fa = code2fa;
              user.code2faExpiration = Date.now() + 300000; // scade in 5 minuti
              user.save();

              // invio una nuova email di attivazione e mando l'utente
              transporter.sendMail({
                to: email,
                from: 'myemail',
                subject: 'Il tuo codice d\'accesso a due fattori! | EoG Community',
                html: `
                <h2>Il tuo codice d'accesso a due fattori:</h2>
                <h1>${code2fa}</h1>
                <p>Il codice scadrà fra 5 minuti.</p>
                <br><br><p>Ciao,</p>
                <br><p>Abbiamo notato che hai effettuato l'accesso da un nuovo dispositivo, 
                con un browser differente o da una posizione diversa. Utilizza il codice qui sopra 
                per effettuare l'accesso.</p>
                <br><p>Grazie,<br>
                Il team di BorysProductions</p>
                `
              });
            }

            return res.status(422).render('auth/index', {
              pageTitle: 'Home',
              errorMessage: '',
              loginErrorMessage: '',
              authenticating: true,
              oldInput: {
                email: email,
                password: password
              },
              validationErrors: [{ param: 'password' }]
            });
          }
        })
        .catch(err => {
          const error = new Error(err);
          error.httpStatusCode = 500;
          next(error);
        });
    })
    .catch(err => console.log(err));
};

exports.post2FA = (req, res, next) => {
  const code = req.body.code2fa;

  User.findOne({ where: { code2fa: code } })
    .then(user => {
      if (!user) {
        return res.redirect('/');
      }

      req.session.isLoggedIn = true;
      req.session.user = user;
      user.code2fa = null;
      user.code2faExpiration = null;
      user.save();

      return req.session.save(err => {
        console.log(err);

        user.getSecurityInfo()
          .then(info => {
            if (!info | info.recoveryEmail === null) {
              return res.redirect('/profilo/info-account');
            }
            res.redirect('/');
          })
          .catch(err => {
            const error = new Error(err);
            error.httpStatusCode = 500;
            next(error);
          });

      });
    })
};

// Get request per l'attivazione dell'account
exports.getActivation = (req, res, next) => {
  const token = req.params.token;
  console.log(token);
  User.findOne({ where: { activationToken: token, activationTokenExpiration: { [Op.gte]: Date.now() } } })
    .then(user => {
      // se non è stato trovato un utente con quei requisiti allora renderizzo un errore
      if (!user) {
        return res.render('auth/activation', {
          pageTitle: 'Attivazione Account',
          errorMessage: '',
          activated: false,
          activationMessage: 'Attivazione fallita, a quanto pare l\'utente non esiste o il link di attivazione è stato disintegrato nel continuum spazio-temporale.'
        });
      }

      let message = req.flash('error');
      if (message.length > 0) {
        message = message[0];
      }
      else {
        message = null;
      }

      user.isActivated = true;
      user.activationToken = null;
      user.activationTokenExpiration = null;
      user.save();
      res.render('auth/activation', {
        pageTitle: 'Attivazione Account',
        errorMessage: message,
        activated: true,
        activationMessage: 'Account attivato con successo, ora puoi effettuare l\'accesso'

      });
    })
    .catch(err => {
      const error = new Error(err);
      error.httpStatusCode = 500;
      next(error);
    });
};

// Get request per la richiesta di attivazione
exports.getRequestActivation = (req, res, next) => {
  let message = req.flash('errorActivation');
  if (message.length > 0) {
    message = message[0];
  }
  else {
    message = null;
  }

  res.render('auth/request-activation', {
    pageTitle: 'Richiesta Attivazione',
    path: '/',
    errorMessage: message,
    validationErrors: [],
    oldInput: {
      email: '',
    }
  });
};


// Get request per il recupero password
exports.getRecoverPassword = (req, res, next) => {
  let message = req.flash('error');
  if (message.length > 0) {
    message = message[0];
  }
  else {
    message = null;
  }

  let messageLogin = req.flash('errorLogin');
  if (messageLogin.length > 0) {
    messageLogin = messageLogin[0];
  }
  else {
    messageLogin = null;
  }

  res.render('auth/recover-password', {
    pageTitle: 'Recupero Password',
    path: '/',
    errorMessage: message,
    validationErrors: [],
    oldInput: {
      recoverEmail: ''
    }
  });
};

// Post request per richiedere il recupero della password
exports.postRecoverPassword = (req, res, next) => {
  crypto.randomBytes(32, (err, buffer) => {
    if (err) {
      console.log(err);
      return res.redirect('/reset');
    }

    const token = buffer.toString('hex');
    User.findOne({ where: { email: req.body.recoverEmail } })
      .then(user => {
        if (!user) {
          req.flash('error', 'Non è stato trovato alcun account con questa email.');
          return res.redirect('/recupera-password');
        }
        user.resetToken = token;
        user.resetTokenExpiration = Date.now() + 3600000; // scadenza dopo 30 minuti
        return user.save();
      })
      .then(result => {
        res.redirect('/');
        transporter.sendMail({
          to: req.body.recoverEmail,
          from: 'myemail',
          subject: 'Recupero Password | EoG Community',
          html: `
            <p>Gentile utente, hai richiesto il recupero della password.</p>
            <p>Clicca su questo <a href="${process.env.URL_WEBSITE}/recupera-password/${token}">link</a> per impostare una nuova password.</p>
          `
        });
      })
      .catch(err => {
        const error = new Error(err);
        error.httpStatusCode = 500;
        next(error);
      });
  });

};


// Get request per il cambio della password
exports.getNewPassword = (req, res, next) => {
  const token = req.params.token;

  User.findOne({ where: { resetToken: token, resetTokenExpiration: { [Op.gt]: Date.now() } } })
    .then(user => {
      if (!user) {
        return res.redirect('/');
      }

      let message = req.flash('error');
      if (message.length > 0) {
        message = message[0];
      }
      else {
        message = null;
      }
      res.render('auth/new-password', {
        pageTitle: 'Nuova Password',
        errorMessage: message,
        userEmail: user.email,
        passwordToken: token,
        oldInput: {
          newPassword: '',
          confirmNewPassword: ''
        }
      });
    })
    .catch(err => {
      const error = new Error(err);
      error.httpStatusCode = 500;
      next(error);
    });
};

// Post request per caricare la nuova password dell'utente
exports.postNewPassword = (req, res, next) => {
  const newPassword = req.body.newPassword;
  const userEmail = req.body.userEmail;
  const token = req.body.passwordToken;
  let resetUser;

  User.findOne({ where: { email: userEmail, resetToken: token, resetTokenExpiration: { [Op.gt]: Date.now() } } })
    .then(user => {

      if (!user) {
        res.redirect('/error');
      }

      resetUser = user;
      return bcrypt.hash(newPassword, 12);

    })
    .then(hashedPW => {
      resetUser.password = hashedPW;
      resetUser.resetToken = null;
      resetUser.resetTokenExpiration = undefined;
      return resetUser.save();
    })
    .then(result => {
      res.redirect('/');
    })
    .catch(err => {
      console.log(err);
      const error = new Error(err);
      error.httpStatusCode = 500;
      next(error);
    });
};


// Post request per effettuare il Logout
exports.postLogout = (req, res, next) => {
  req.session.destroy(err => {
    console.log(err);
    res.redirect('/');
  });
};