var bcrypt = require('bcrypt');  //ver 0.8.7
var _ = require('underscore');

module.exports = function(sequelize, DataTypes){
    var g_analysis = sequelize.define('dog_guaranteed_analysis',{
        guaranteed_analysis_name: {
            type:DataTypes.STRING,
            allowNull : false,
            validate:{

            }
        },
        guaranteed_analysis_content: {
            type:DataTypes.STRING,
            allowNull : false,
            validate:{

            }
        },
        guaranteed_analysis_maxOrmin: {
            type:DataTypes.BOOLEAN,
            allowNull : false,
            validate:{

            }
        }
    });

    
    return g_analysis;
}