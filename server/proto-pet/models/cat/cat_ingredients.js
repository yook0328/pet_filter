var bcrypt = require('bcrypt');  //ver 0.8.7
var _ = require('underscore');

module.exports = function(sequelize, DataTypes){
    var ingredient = sequelize.define('cat_ingredient',{
        content_name: {
            type:DataTypes.STRING,
            allowNull : false,
            validate:{

            }
        }
    });

    
    return ingredient;
}