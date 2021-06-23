const express = require('express');
const { body } = require('express-validator/check');
const bcrypt = require('bcryptjs');

const User = require('../models/user');

const authController = require('../controllers/auth');

const router = express.Router();


router.get('/', authController.getIndex);

router.get('/login', authController.getIndex);

router.get('/registrazione', authController.getIndex);

router.post('/registrazione',
  [
    body('registerUsername', 'Il nome utente deve essere alfnumerico di minimo 4 e massimo 16 caratteri!')
      .isAlphanumeric()
      .isLength({ min: 4, max: 16 }),
    body('registerEmail', 'Inserisci un\'email valida')
      .isEmail().normalizeEmail(),
    body('registerPassword')
      .isString().isLength({ min: 8 }).trim(),
    body('registerConfirmPassword').trim().custom((value, { req }) => {
      if (value !== req.body.registerPassword) {
        throw Error('Le Password non corrispondono!');
      }

      return true;
    })
  ], authController.postRegister);

router.post('/login',
  [
    body('loginEmail', 'Inserisci un\'email valida!')
      .isEmail().normalizeEmail(),
    body('loginPassword', 'Inserisci una Password valida!')
      .isLength({ min: 5 }).isAlphanumeric().trim()

  ], authController.postLogin);

router.post('/2fa', authController.post2FA);

router.get('/attivazione/:token', authController.getActivation);

router.get('/attivazione', authController.getRequestActivation);


router.get('/recupera-password', authController.getRecoverPassword);

router.post('/recupera-password',
  [
    body('recoverEmail', 'Inserisci un\'email valida!')
      .isEmail().normalizeEmail()
  ], authController.postRecoverPassword);

router.post('/logout', authController.postLogout);


router.get('/recupera-password/:token', authController.getNewPassword);

router.post('/nuova-password',
  [
    body('newPassword', 'Inserisci una password alfanumerica di almeno 8 caratteri!')
      .isString().isLength({ min: 8}).trim(),
    body('confirmNewPassword').trim()
    .custom((value, { req }) => {
      if (value !== req.body.confirmNewPassword) {
        throw Error('Le Password non corrispondono!')
      }

      return true;
    })

  ], authController.postNewPassword);


module.exports = router;