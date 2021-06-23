const Sequelize = require('sequelize');

const sequelize = new Sequelize(`${process.env.SQL_SCHEMA}`, `${process.env.SQL_USER}`, `${process.env.SQL_PASSWORD}`, {
    host: 'HOST',
    port: 1234,
    dialect: 'mysql'
});

module.exports = sequelize;
