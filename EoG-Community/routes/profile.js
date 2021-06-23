const express = require('express');
const { body } = require('express-validator/check');
const bcrypt = require('bcryptjs');

const User = require('../models/user');

const isAuth = require('../middlewares/isAuth');
const profileCompletition = require('../middlewares/hasCompletedProfile');
const profileController = require('../controllers/profile');

const router = express.Router();

router.get('/info-account', isAuth, profileController.getAccountInfo);


router.post('/update-account', isAuth,
    [
        body(),
        body('personalEmail').isEmail().normalizeEmail()
    ], profileController.postUpdateAccountInfo);
router.post('/update-security', isAuth, profileController.postUpdateSecurityInfo);


router.get('/cambia-password', isAuth, profileController.getChangePassword);
router.post('/cambia-password', isAuth,
    [
        body('newPassword')
            .isString().isLength({ min: 8 }).trim(),
        body('confirmNewPassword').trim().custom((value, { req }) => {
            if (value !== req.body.newPassword) {
                throw Error('Le Password non corrispondono!');
            }

            return true;
        })
    ], profileController.postChangePassword);


router.get('/impostazioni', isAuth, profileController.getAccountSettings);
router.post('/impostazioni', isAuth, profileController.postAccountSettings);

router.get('/inviti-gruppi', isAuth, profileController.getGroupInvitations)
router.post('/accetta-invito', isAuth, profileController.postAcceptInvite);
router.post('/rifiuta-invito', isAuth, profileController.postRefuseInvite);

router.get('/gruppi', isAuth, profileController.getGroupsManagement);

router.get('/richieste-amicizia', isAuth, profileController.getFriendRequests);

router.get('/social', isAuth, profileController.getSocials);

router.get('/info-profilo', isAuth, profileController.getProfileInfo);
router.post('/update-profile', isAuth, profileController.postUpdateProfile);



module.exports = router;