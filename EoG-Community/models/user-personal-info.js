const Sequelize = require('sequelize');
const sequelize = require('../utils/database');

const PersonalInfo = sequelize.define('PersonalInfo', {
    profileName: {
        type: Sequelize.STRING,
        allowNull: true
    },
    bio: {
        type: Sequelize.TEXT,
        allowNull: true
    },
    birthday: {
        type: Sequelize.DATE,
        allowNull: true
    },
    city: {
        type: Sequelize.STRING,
        allowNull: true
    },
    country: {
        type: Sequelize.STRING,
        allowNull: true
    },
    occupation: {
        type: Sequelize.STRING,
        allowNull: true
    },
    relation: {
        type: Sequelize.STRING,
        allowNull: true
    }
});


module.exports = PersonalInfo;