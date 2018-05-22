var Sequelize = require('sequelize');// sequelize ver 3.23.4
var sequelize = new Sequelize('pet_item_db', 'root', 'root', 
{
	'host': 'localhost',
	'dialect': 'mysql',
	'dialectOptions': {
        socketPath: '/Applications/MAMP/tmp/mysql/mysql.sock'
    },
  'logging' : function(str){
      //console.log(str);
    },

});
// var sequelize = new Sequelize('pet_item_db', 'root', 'fEstuspewUq6', 
// {
// 	'host': 'localhost',
// 	'dialect': 'mysql',

//   'logging' : function(str){
//       //console.log(str);
//     },

// });

sequelize
.authenticate()
.then(function(err) {
console.log('Connection has been established successfully.');
})
.catch(function (err) {
console.log('Unable to connect to the database:', err);
});

var db = {};

db.dog_food = sequelize.import(__dirname + '/models/dog_food.js');
db.dog_health_consideration = sequelize.import(__dirname + '/models/dog_health_consideration.js');
db.dog_ingredients = sequelize.import(__dirname + '/models/dog_ingredients.js');
db.dog_nutritional_option = sequelize.import(__dirname + '/models/dog_nutritional_option.js');
db.dog_guaranteed_analysis = sequelize.import(__dirname + '/models/dog_g_Analysis.js');


db.dog_health_consideration.belongsTo(db.dog_food);
db.dog_food.hasMany(db.dog_health_consideration);
db.dog_ingredients.belongsTo(db.dog_food);
db.dog_food.hasMany(db.dog_ingredients);
db.dog_nutritional_option.belongsTo(db.dog_food);
db.dog_food.hasMany(db.dog_nutritional_option);
db.dog_guaranteed_analysis.belongsTo(db.dog_food);
db.dog_food.hasMany(db.dog_guaranteed_analysis);

db.cat_food = sequelize.import(__dirname + '/models/cat/cat_food.js');
db.cat_health_consideration = sequelize.import(__dirname + '/models/cat/cat_health_consideration.js');
db.cat_ingredients = sequelize.import(__dirname + '/models/cat/cat_ingredients.js');
db.cat_nutritional_option = sequelize.import(__dirname + '/models/cat/cat_nutritional_option.js');
db.cat_guaranteed_analysis = sequelize.import(__dirname + '/models/cat/cat_g_Analysis.js');


db.cat_health_consideration.belongsTo(db.cat_food);
db.cat_food.hasMany(db.cat_health_consideration);
db.cat_ingredients.belongsTo(db.cat_food);
db.cat_food.hasMany(db.cat_ingredients);
db.cat_nutritional_option.belongsTo(db.cat_food);
db.cat_food.hasMany(db.cat_nutritional_option);
db.cat_guaranteed_analysis.belongsTo(db.cat_food);
db.cat_food.hasMany(db.cat_guaranteed_analysis);

db.dog_treats = sequelize.import(__dirname + '/models/treats/dog/dog_treats.js');
db.dog_treats_ingredients = sequelize.import(__dirname + '/models/treats/dog/dog_treats_ingredients.js');
db.dog_treats_guaranteed_analysis = sequelize.import(__dirname + '/models/treats/dog/dog_treats_g_Analysis.js');

db.dog_treats_ingredients.belongsTo(db.dog_treats);
db.dog_treats.hasMany(db.dog_treats_ingredients);
db.dog_treats_guaranteed_analysis.belongsTo(db.dog_treats);
db.dog_treats.hasMany(db.dog_treats_guaranteed_analysis);

db.cat_treats = sequelize.import(__dirname + '/models/treats/cat/cat_treats.js');
db.cat_treats_ingredients = sequelize.import(__dirname + '/models/treats/cat/cat_treats_ingredients.js');
db.cat_treats_guaranteed_analysis = sequelize.import(__dirname + '/models/treats/cat/cat_treats_g_Analysis.js');

db.cat_treats_ingredients.belongsTo(db.cat_treats);
db.cat_treats.hasMany(db.cat_treats_ingredients);
db.cat_treats_guaranteed_analysis.belongsTo(db.cat_treats);
db.cat_treats.hasMany(db.cat_treats_guaranteed_analysis);

db.Sequelize = Sequelize;
db.sequelize = sequelize;
module.exports = db;