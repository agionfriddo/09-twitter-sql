'use strict';
var express = require('express');
var router = express.Router();
var tweetBank = require('../tweetBank');
var client = require('../db');

module.exports = function makeRouterWithSockets (io) {

  // a reusable function
  function respondWithAllTweets (req, res, next){
    client.query("SELECT tweets.content, tweets.id, users.name, users.pictureurl FROM Tweets JOIN Users ON Tweets.userId = Users.id", function(err, result) {
      var tweets = result.rows;
      res.render('index', {
      title: 'Twitter.js',
      tweets: tweets,
      showForm: true
    });
    });

  }

  // here we basically treet the root view and tweets view as identical
  router.get('/', respondWithAllTweets);
  router.get('/tweets', respondWithAllTweets);

  // single-user page
  router.get('/users/:username', function(req, res, next){
    var query = "SELECT tweets.content, tweets.id, users.name, users.pictureurl FROM Tweets JOIN Users ON Tweets.userId = Users.id WHERE Users.name ='" + req.params.username + "'";
    client.query(query,
      function(err, result) {
        var tweetsForName = result.rows;
        res.render('index', {
        title: 'Twitter.js',
        tweets: tweetsForName,
        showForm: true,
        username: req.params.username
      });
    });
  });

  // single-tweet page
  router.get('/tweets/:id', function(req, res, next){
    var query = "SELECT tweets.content, tweets.id, users.name, users.pictureurl FROM Tweets JOIN Users ON Tweets.userId = Users.id WHERE Tweets.id ='" + req.params.id + "'";
    client.query(query,
      function(err, result) {
        var tweetsWithThatId = result.rows;
        res.render('index', {
          title: 'Twitter.js',
          tweets: tweetsWithThatId // an array of only one element ;-)
      });
  });
});

  // create a new tweet
  router.post('/tweets', function(req, res, next){
    var countQuery = "SELECT COUNT(*) FROM Users WHERE name = '" + req.body.name + "'";

    client.query(countQuery, function(err, result) {
      if(result.rows[0].count < 1) {
        client.query("INSERT INTO Users (name, pictureUrl) VALUES ($1, $2)",
          [req.body.name, "none"],
          function(err, result){
            if (err) throw err;
          client.query("INSERT INTO Tweets (userId, content) VALUES ((SELECT id from Users Where name =$1),$2)",
            [req.body.name, req.body.content],
            function(err, result) {
              var newTweet = result.rows[0];
              io.sockets.emit('new_tweet', newTweet);
              res.redirect('/');
            });
        });
      } else {
        client.query("INSERT INTO Tweets (userId, content) VALUES ((SELECT id from Users Where name =$1),$2)",
          [req.body.name, req.body.content],
          function(err, result) {
            var newTweet = result.rows[0];
            io.sockets.emit('new_tweet', newTweet);
            res.redirect('/');
          });
      }
    });


  });

  // // replaced this hard-coded route with general static routing in app.js
  // router.get('/stylesheets/style.css', function(req, res, next){
  //   res.sendFile('/stylesheets/style.css', { root: __dirname + '/../public/' });
  // });

  return router;
}
