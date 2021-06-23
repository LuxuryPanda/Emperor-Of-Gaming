const Sequelize = require('sequelize');
const sequelize = require('../utils/database');


// I like possono essere di tipo:
// 0 - Mi piace
// 1 - Non mi piace
// 2 - Love
// 3 - Felice
// 4 - Risata
// 5 - Wow
// 6 - Arrabbiato
// 7 - Triste
const Like = sequelize.define('Like', {
    id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    type: {
        type: Sequelize.INTEGER,
        allowNull: false,
        defaultValue: 0,
        validate: {
            min: 0,
            max: 7
        }
    }
});

module.exports = Like;