const express = require('express');
const { body } = require('express-validator/check');
const bcrypt = require('bcryptjs');


const User = require('../models/user');

const isAuth = require('../middlewares/isAuth');
const profileCompletition = require('../middlewares/hasCompletedProfile');
const socialController = require('../controllers/social');

const router = express.Router();

router.get('/', isAuth, profileCompletition, socialController.getIndex);

router.get('/privacy-policy', isAuth, profileCompletition, socialController.getPrivacyPolicy);

router.get('/chi-siamo', isAuth, profileCompletition, socialController.getAboutUs);

router.get('/u/:userId', isAuth, profileCompletition, socialController.getUserProfile);

router.get('/u/:userId/feed', isAuth, profileCompletition, socialController.getUserProfile);

router.get('/u/:userId/amici', isAuth, profileCompletition, socialController.getUserProfile);

router.get('/u/:userId/gruppi', isAuth, profileCompletition, socialController.getUserProfile);

router.get('/u/:userId/stream', isAuth, profileCompletition, socialController.getUserProfile);

router.get('/u/:userId/blog', isAuth, profileCompletition, socialController.getUserProfile);

router.get('/u/:userId/forum', isAuth, profileCompletition, socialController.getUserProfile);

module.exports = router;