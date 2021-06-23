const Sequelize = require('sequelize');
const sequelize = require('../utils/database');

const SecurityInfo = sequelize.define('SecurityInfo', {
    recoveryEmail: {
        type: Sequelize.STRING,
        allowNull: true
    },
    Question1: {
        type: Sequelize.INTEGER,
        allowNull: true
    },
    Answer1: {
        type: Sequelize.STRING,
        allowNull: true
    },
    Question2: {
        type: Sequelize.INTEGER,
        allowNull: true
    },
    Answer2: {
        type: Sequelize.STRING,
        allowNull: true
    },
    Question3: {
        type: Sequelize.INTEGER,
        allowNull: true
    },
    Answer3: {
        type: Sequelize.STRING,
        allowNull: true
    }
});


module.exports = SecurityInfo;