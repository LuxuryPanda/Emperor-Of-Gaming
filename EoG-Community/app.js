//#region ## IMPORTS ##
const path = require('path');
const fs = require('fs');

const express = require('express');
const bodyParser = require('body-parser');
const sequelize = require('./utils/database');
const session = require('express-session');
const csrf = require('csurf');
const flash = require('connect-flash');
const helmet = require('helmet');
const compression = require('compression');
const morgan = require('morgan');


//#endregion

// Inizializzazione dello store di sessioni di Sequelize
var SequelizeStore = require("connect-session-sequelize")(session.Store);

//#region ## Models ##

const User = require('./models/user');
const AccountInfo = require('./models/user-account-info');
const SecurityInfo = require('./models/user-security-info');
const PersonalInfo = require('./models/user-personal-info');

const Post = require('./models/post');
const Like = require('./models/like');
const Comment = require('./models/comment');

//#endregion


//#region ## Routes ##

const apiRoutes = require('./routes/api/api');
const socialRoutes = require('./routes/social');
const authRoutes = require('./routes/auth');
const profileRoutes = require('./routes/profile');
const errorController = require('./controllers/error');


//#endregion


const app = express();
const store = new SequelizeStore({ db: sequelize });

const csrfProtection = csrf();
app.set('view engine', 'ejs');
app.set('views', 'views');

const accessLogStream = fs.createWriteStream(
    path.join(__dirname, 'access.log'), 
    { flags: 'a' }
);

app.use(helmet({ contentSecurityPolicy: false }));
app.use(compression());
app.use(morgan('combined', { stream: accessLogStream }));


app.use(bodyParser.urlencoded({ extended: false }));
//app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({
    secret: 'LF50R$XoXLRqpU&RuhXF*83YdYqk!aMS',
    store: store,
    resave: false,
    saveUninitialized: false

}));

store.sync();

app.use(csrfProtection);
app.use(flash());

app.use((req, res, next) => {
    res.locals.isAuthenticated = req.session.isLoggedIn;
    res.locals.csrfToken = req.csrfToken();
    next();
});

app.use((req, res, next) => {
    if (!req.session.user) {
        return next();
    }
    
    User.findByPk(req.session.user.username)
        .then(user => {
            if (!user) {
                return next();
            }
            req.user = user;
            next();
        })
        .catch(err => {
            next(new Error(err));
        });
});

app.use(apiRoutes);
app.use(socialRoutes);
app.use(authRoutes);
app.use('/profilo', profileRoutes);

app.get('500', errorController.get500);

app.use(errorController.get404);


app.use((error, req, res, next) => {
    res.status(500).render('500', {
        pageTitle: 'Errore!',
        path: '/500'
    });
});

//#region ## SQL RELATIONS

// Relazioni dati utente
User.hasOne(AccountInfo);
AccountInfo.belongsTo(User);
User.hasOne(SecurityInfo);
SecurityInfo.belongsTo(User);
User.hasOne(PersonalInfo);
PersonalInfo.belongsTo(User);


// Relazioni Post
Post.belongsTo(User);
User.hasMany(Post);

Like.belongsTo(User);
Like.belongsTo(Post);
Post.hasMany(Like);

Comment.belongsTo(Post);
Comment.belongsTo(User);
Post.hasMany(Comment);

//#endregion



sequelize
    //.sync({force: true})
    .sync()
    .then(result => {
        app.listen(process.env.PORT || 3001);
    })
    .catch(err => console.log(err));