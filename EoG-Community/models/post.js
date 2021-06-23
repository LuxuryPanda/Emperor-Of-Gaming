const Sequelize = require('sequelize');
const sequelize = require('../utils/database');

const Post = sequelize.define('Post', {
    id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    publicationDate: {
        type: Sequelize.DATE
    },
    body: {
        type: Sequelize.STRING
    }
});

module.exports = Post;