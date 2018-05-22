var express = require('express');  //express version 4.14.0
var mysql = require('mysql');			//mysql 2.11.1
var bcrypt = require('bcrypt'); //ver 0.8.7
var bodyParser = require('body-parser'); // ver 1.15.2
var path = require('path');
var _ = require('underscore'); //ver 1.8.3
var nodemailer = require('nodemailer'); // ver 2.5.0
var multiparty = require('multiparty'); // ver 4.1.2
var fs = require('fs');
var app = express();
var PORT = process.env.PORT || 3000;

var db = require('./db.js');


// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// parse application/json
app.use(bodyParser.json());


app.use(function(req,res,next){
	res.header('Access-Control-Allow-Origin', '*');
	res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
	res.header('Access-Control-Allow-Headers', 'Content-Type');
	next();
});

//////////////
var add_dog_food = require('./routes/add_dog_food.js');
var dog_food = require('./routes/dog_food.js');
var update_dog_food = require('./routes/update_dog_food.js');

var add_cat_food = require('./routes/cat/add_cat_food.js');
var cat_food = require('./routes/cat/cat_food.js');
var update_cat_food = require('./routes/cat/update_cat_food.js');

var add_dog_treats = require('./routes/treats/dog/add_dog_treats.js');
var dog_treats = require('./routes/treats/dog/dog_treats.js')
var update_dog_treats = require('./routes/treats/dog/update_dog_treats.js');

var add_cat_treats = require('./routes/treats/cat/add_cat_treats.js');
var cat_treats = require('./routes/treats/cat/cat_treats.js');
var update_cat_treats = require('./routes/treats/cat/update_cat_treats.js');
////////////////



app.use('/updateDogFood',update_dog_food);
app.use('/addDogFood',add_dog_food);
app.use('/DogFood',dog_food);

app.use('/updateCatFood',update_cat_food);
app.use('/addCatFood',add_cat_food);
app.use('/CatFood',cat_food);

app.use('/addDogTreats',add_dog_treats);
app.use('/DogTreats',dog_treats);
app.use('/updateDogTreats',update_dog_treats);

app.use('/addCatTreats',add_cat_treats);
app.use('/CatTreats',cat_treats);
app.use('/updateCatTreats',update_cat_treats);

// view engine setup
// app.set('views', __dirname + '/admin/src');
// app.set('view engine', 'ejs');
// app.engine('html', require('ejs').renderFile);
//app.use(express.static(path.join(__dirname, 'admin')));



// Point static path to dist
app.use(express.static(path.join(__dirname, 'dist')));
// Catch all other routes and return the index file
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist/index.html'));
});
//sync({force: true}) 이면 서버 켤때마다 데이터 리셋됨.
db.sequelize.sync({force:false}).then( function () {
	app.listen(PORT, function () {
		console.log('Express listening on port ' + PORT + '!');
	})
});

