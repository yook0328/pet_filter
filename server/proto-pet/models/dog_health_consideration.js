var bcrypt = require('bcrypt');  //ver 0.8.7
var _ = require('underscore');

module.exports = function(sequelize, DataTypes){
    var health_consideration = sequelize.define('dog_health_consideration',{
        content_name: {
            type:DataTypes.STRING,
            allowNull : false,
            validate:{

            }
        }
    });

    
    return health_consideration;
}