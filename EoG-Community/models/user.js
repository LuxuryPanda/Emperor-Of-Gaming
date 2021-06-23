const Sequelize = require('sequelize');
const sequelize = require('../utils/database');

const User = sequelize.define('User', {
    username: {
        type: Sequelize.STRING,
        allowNull: false,
        primaryKey: true,
        unique: true
    },
    email: {
        type: Sequelize.STRING,
        allowNull: false,
        primaryKey: true,
        unique: true
    },
    password: {
        type: Sequelize.STRING,
        allowNull: false
    },
    name: {
        type: Sequelize.STRING,
        allowNull: true
    },
    surname: {
        type: Sequelize.STRING,
        allowNull: true
    },
    isActivated: {
        type: Sequelize.BOOLEAN,
        allowNull: false
    },
    activationToken: {
        type: Sequelize.STRING,
        allowNull: true
    },
    activationTokenExpiration: {
        type: Sequelize.DATE,
        allowNull: true
    },
    code2fa: {
        type: Sequelize.INTEGER,
        allowNull: true
    },
    code2faExpiration: {
        type: Sequelize.DATE,
        allowNull: true
    },
    isBanned: {
        type: Sequelize.BOOLEAN,
        allowNull: false
    },
    joinDate: {
        type: Sequelize.DATE,
        allowNull: false
    },
    resetToken: {
        type: Sequelize.STRING
    },
    resetTokenExpiration: {
        type: Sequelize.DATE
    },
    lastSeen: {
        type: Sequelize.DATE
    }
});


module.exports = User;