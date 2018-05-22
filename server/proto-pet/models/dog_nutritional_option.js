var bcrypt = require('bcrypt');  //ver 0.8.7
var _ = require('underscore');

module.exports = function(sequelize, DataTypes){
    var nutritional_option = sequelize.define('dog_nutritional_option',{
        content_name: {
            type:DataTypes.STRING,
            allowNull : false,
            validate:{

            }
        }
    });

    
    return nutritional_option;
}