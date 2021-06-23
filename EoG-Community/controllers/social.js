const crypto = require('crypto');

const bcrypt = require('bcryptjs');
const { validationResult } = require('express-validator/check');
const { Op } = require('sequelize');

const utilities = require('../utils/utilities');

const User = require('../models/user');
const Post = require('../models/post');

// Get request per l'index con registrazione e login
exports.getIndex = (req, res, next) => {
    if (!req.session.isLoggedIn) {
        return next();
    }

    let message = req.flash('error');
    if (message.length > 0) {
        message = message[0];
    }
    else {
        message = null;
    }

    let publishedPosts;
    req.user.countPosts({ where: { UserUsername: req.user.username } })
        .then(count => publishedPosts = count)
        .then(result => {
            Post.findAll().then(posts => {
                User.findAll().then(users => {
                    res.render('social/feed', {
                        pageTitle: 'Home',
                        path: '/',
                        posts: posts,
                        users: users,
                        utilities: utilities,
                        errorMessage: message,
                        user: req.user,
                        username: req.user.username,
                        publishedPosts: publishedPosts,
                        validationErrors: []
                    });
                })

            });
        })
        .catch(err => {
            const error = new Error(err);
            error.httpStatusCode = 500;
            next(error);
        });
};

exports.getPrivacyPolicy = (req, res, next) => {
    if (!req.session.isLoggedIn) {
        return next();
    }

    res.render('general/privacy-policy', {
        pageTitle: 'Privacy Policy',
        path: '/privacy-policy',
        username: req.user.username,
        validationErrors: []
    });

};

exports.getAboutUs = (req, res, next) => {
    if (!req.session.isLoggedIn) {
        return next();
    }

    res.render('general/about-us', {
        pageTitle: 'Chi Siamo',
        path: '/chi-siamo',
        username: req.user.username,
        validationErrors: []
    });

};

exports.getUserProfile = (req, res, next) => {
    const username = req.params.userId;

    var user;
    User.findOne({ where: { username: username } })
        .then(user => {
            if (!user) {
                res.redirect('/');
            }

            user = user;
            let publishedPosts;
            req.user.countPosts({ where: { UserUsername: username } })
                .then(count => publishedPosts = count)
                .then(result => {
                    user.getPersonalInfo()
                        .then(personalInfo => {
                            return res.render('profile/profile', {
                                pageTitle: 'Profile',
                                path: '/',
                                errorMessage: '',
                                personalInfo: personalInfo,
                                user: user,
                                loggedUser: req.user,
                                username: username,
                                email: user.email,
                                validationErrors: []
                            });
                        })
                        .catch(err => console.log(err));
                });
        })
        .catch(err => console.log(err));
};