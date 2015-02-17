require('coffee-script/register');
var http = require('http');

var express = require('express');
  config = require('./config/config'),
  glob = require('glob'),
  mongoose = require('mongoose');
  bodyParser = require('body-parser');

mongoose.connect(config.db);
var db = mongoose.connection;
db.on('error', function () {
  throw new Error('unable to connect to database at ' + config.db);
});
db.once('open', function callback () {
  console.log("h");
});


var models = glob.sync(config.root + '/app/models/*.coffee');
models.forEach(function (model) {
  require(model);
});

var newNotis = require('./app/controllers/notifications.coffee');
var app = express();
var router = express.Router();

require('./config/express')(app, config);

//Everything above is all housekeeping stuffs
//Now we get to the real magic

//Parses the input data for easy usage later
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
//app.use(express.cookieParser());

app.post('/api', newNotis.create);
app.get('/api', newNotis.retrieve);
app.get('/api/:id', newNotis.retrieve);
app.put('/api/:id', newNotis.update);
app.delete('/api/:id', newNotis.delete);

//Start the magic
app.listen(3000);
console.log('Server is loaded and working!');
