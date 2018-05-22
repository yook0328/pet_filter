var bcrypt = require('bcrypt');  //ver 0.8.7
var _ = require('underscore');

module.exports = function(sequelize, DataTypes){
    var cat_treats = sequelize.define('cat_treats',{
        food_name: {
            type:DataTypes.STRING,
            allowNull : false,
            validate:{

            }
        },
        brand: {
            type:DataTypes.STRING,
            allowNull : false,
            validate:{

            }
        },
        food_type: {
            type:DataTypes.STRING,
            allowNull : false,
            validate: {

            }
        },
        description:{
            type:DataTypes.TEXT,
            validate:{

            }
        },
        food_picture_name:{
            type:DataTypes.STRING,
            allowNull : false,
            validate:{
                
            }
        },
        ingredients: {
            type:DataTypes.STRING,
            allowNull : false,
            validate:{

            }
        }
    });

    return cat_treats;
}