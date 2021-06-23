const Sequelize = require('sequelize');
const sequelize = require('../utils/database');

const Comment = sequelize.define('Comment', {
    id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    publicationDate: {
        type: Sequelize.DATE,
        allowNull: false
    },
    body: {
        type: Sequelize.STRING,
        allowNull: false
    }
});

module.exports = Comment;