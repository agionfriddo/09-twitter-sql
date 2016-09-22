var pg = require('pg');
var postgresUrl = 'postgres://localhost/twitterdb';

var client = new pg.Client(postgresUrl);


client.connect(function (err) {
  if (err) throw err;
//   client.query('SELECT * FROM Users', function(err, result) {
//     if(err) throw err;
//     // var tweets = result.rows;
//     // res.render('index', {title: 'Twitter.js', tweets: tweets, showForm: true});
//     });
  });

module.exports = client;
