require('coffee-script/register');

var express = require('express'),
  config = require('./config/config'),
  glob = require('glob'),
  mongoose = require('mongoose');
  bodyParser = require('body-parser');

mongoose.connect(config.db);
var db = mongoose.connection;
db.on('error', function () {
  throw new Error('unable to connect to database at ' + config.db);
});

var models = glob.sync(config.root + '/app/models/*.coffee');
models.forEach(function (model) {
  require(model);
});
var app = express();

require('./config/express')(app, config);

//Everything above is all housekeeping stuffs
//Now we get to the real magic

//Parses the input data for easy usage later
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

//Routes defined in home.coffee

//Start the magic
app.listen(config.port);
console.log('Server is loaded and working!');
