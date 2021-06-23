const Sequelize = require('sequelize');
const sequelize = require('../utils/database');

const AccountInfo = sequelize.define('AccountInfo', {
    fullName: {
        type: Sequelize.STRING,
        allowNull: true
    },
    country: {
        type: Sequelize.INTEGER,
        allowNull: true
    },
    language: {
        type: Sequelize.INTEGER,
        allowNull: true
    }
});


module.exports = AccountInfo;