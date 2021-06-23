const crypto = require('crypto');

const bcrypt = require('bcryptjs');
const nodemailer = require('nodemailer');
const { validationResult } = require('express-validator/check');
const { Op } = require('sequelize');

exports.getAccountInfo = (req, res, next) => {
    let fullName = '';
    let country = '';
    let recoverEmail = '';

    req.user.getAccountInfo()
        .then(accountInfo => {
            if (accountInfo) {
                fullName = accountInfo.fullName;
                country = accountInfo.country;
            }

            return req.user.getSecurityInfo();
        })
        .then(securityInfo => {
            if (securityInfo) {
                recoverEmail = securityInfo.recoveryEmail;
            }

            res.render('profile/account-info', {
                pageTitle: 'Informazioni Account',
                path: '/info-account',
                username: req.user.username,
                oldInput: {
                    fullName: fullName,
                    personalEmail: req.user.email,
                    country: country,
                    language: '',
                    recoverEmail: recoverEmail,
                    Q1: '',
                    A1: '',
                    Q2: '',
                    A2: '',
                    Q3: '',
                    A3: ''
                },
            });
        })
        .catch(err => console.log(err));
};

exports.postUpdateAccountInfo = (req, res, next) => {
    const email = req.body.personalEmail;
    const country = req.body.country;
    const language = req.body.language;

    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).render('profile/account-info', {
            pageTitle: 'Informazioni Account',
            path: '/info-account',
            username: req.user.username,
            personalError: errors.array()[0].msg,
            securityError: '',
            oldInput: {
                personalEmail: email,
                country: country,
                language: language,
                Q1: '',
                A1: '',
                Q2: '',
                A2: '',
                Q3: '',
                A3: ''
            },
            validationErrors: errors.array()
        });
    }

    req.user.getAccountInfo()
        .then(accountInfo => {
            if (!accountInfo) {
                return res.redirect('/profilo/info-profilo');
            }

            req.user.email = email;
            accountInfo.country = country;
            req.user.save();
            accountInfo.save();
            res.redirect('/profilo/info-account');
        })
        .catch(err => {
            const error = new Error(err);
            error.httpStatusCode = 500;
            next(error);
        });
};



exports.postUpdateSecurityInfo = (req, res, next) => {
    const recoveryEmail = req.body.recoveryEmail;
    const Q1 = req.body.recoveryQ1;
    const Q2 = req.body.recoveryQ2;
    const Q3 = req.body.recoveryQ3;
    const A1 = req.body.recoveryA1;
    const A2 = req.body.recoveryA2;
    const A3 = req.body.recoveryA3;


    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).render('profile/account-info', {
            pageTitle: 'Informazioni Account',
            path: '/info-account',
            personalError: errors.array()[0].msg,
            securityError: '',
            oldInput: {
                fullName: req.user.fullName,
                personalEmail: req.user.email,
                country: '',
                language: '',
                Q1: Q1,
                A1: A1,
                Q2: Q2,
                A2: A2,
                Q3: Q3,
                A3: A3
            },
            validationErrors: errors.array()
        });
    }

    req.user.getSecurityInfo()
        .then(securityInfo => {
            if (!securityInfo) {
                return res.redirect('/profilo/info-profilo');
            }

            securityInfo.recoveryEmail = recoveryEmail;
            securityInfo.Question1 = Q1;
            securityInfo.Answer1 = A1;
            securityInfo.Question2 = Q2;
            securityInfo.Answer2 = A2;
            securityInfo.Question3 = Q3;
            securityInfo.Answer3 = A3;

            securityInfo.save();
            res.redirect('/profilo/info-account');
        })
        .catch(err => {
            const error = new Error(err);
            error.httpStatusCode = 500;
            next(error);
        });
};


exports.getChangePassword = (req, res, next) => {

    res.render('profile/change-password', {
        pageTitle: 'Cambia Password',
        path: '/cambia-password',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.postChangePassword = (req, res, next) => {
    const currentPassword = req.body.currentPassword;
    const newPassword = req.body.newPassword;
    const confirmNewPassword = req.body.confirmNewPassword;

    bcrypt.compare(currentPassword, req.user.password)
        .then(doMatch => {
            if (doMatch) {
                if (newPassword === confirmNewPassword) {
                    bcrypt.hash(newPassword, 12)
                        .then(hashedPW => {
                            req.user.password = hashedPW;

                            return req.user.save()
                                .then(result => {
                                    return res.render('profile/change-password', {
                                        pageTitle: 'Cambia Password',
                                        path: '/cambia-password',
                                        username: req.user.username,
                                        error: '',
                                        oldInput: {
                                        },
                                    });
                                });
                        })
                }
                else {
                    return res.render('profile/change-password', {
                        pageTitle: 'Cambia Password',
                        path: '/cambia-password',
                        username: req.user.username,
                        error: 'Le password non corrispondono!',
                        oldInput: {
                        },
                    });
                }
            }
            else {
                return res.render('profile/change-password', {
                    pageTitle: 'Cambia Password',
                    path: '/cambia-password',
                    username: req.user.username,
                    error: 'La password attuale è errata!',
                    oldInput: {
                    },
                });
            }
        }).catch(err => {
            const error = new Error(err);
            error.httpStatusCode = 500;
            next(error);
        });
};


exports.getAccountSettings = (req, res, next) => {

    res.render('profile/account-settings', {
        pageTitle: 'Impostazioni Account',
        path: '/impostazioni',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.postAccountSettings = (req, res, next) => {

    res.render('profile/account-settings', {
        pageTitle: 'Impostazioni Account',
        path: '/impostazioni',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.getGroupInvitations = (req, res, next) => {

    res.render('profile/group-invitations', {
        pageTitle: 'Inviti Gruppi',
        path: '/inviti-gruppi',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.postAcceptInvite = (req, res, next) => {

    res.render('profile/group-invitations', {
        pageTitle: 'Inviti Gruppi',
        path: '/inviti-gruppi',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.postRefuseInvite = (req, res, next) => {

    res.render('profile/group-invitations', {
        pageTitle: 'Inviti Gruppi',
        path: '/inviti-gruppi',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.getGroupsManagement = (req, res, next) => {

    res.render('profile/groups-management', {
        pageTitle: 'Gestisci Gruppi',
        path: '/gruppi',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.getFriendRequests = (req, res, next) => {

    res.render('profile/friend-requests', {
        pageTitle: 'Richiesta D\'Amicizia',
        path: '/richieste-amicizia',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.getSocials = (req, res, next) => {
    res.render('profile/socials', {
        pageTitle: 'Socials e Stream',
        path: '/socials',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.getProfileInfo = (req, res, next) => {
    res.render('profile/profile-info', {
        pageTitle: 'Informazioni Profilo',
        path: '/info-profilo',
        username: req.user.username,
        error: '',
        oldInput: {
        },
    });
};

exports.postUpdateProfile = (req, res, next) => {
    const name = req.body.name;
    const surname = req.body.surname;

    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).render('profile/profile-info', {
            pageTitle: 'Informazioni Profilo',
            path: '/info-profilo',
            username: req.user.username,
            profileErrors: errors.array()[0].msg,
            oldInput: {
                personalEmail: email,
            },
            validationErrors: errors.array()
        });
    }

    req.user.name = name;
    req.user.surname = surname;
    req.user.save();
    res.redirect('/profilo/info-profilo');
};