// Requiring our models and passport as we've configured it
var db = require("../models");

var userController  = require('../controllers/userController');   
var paperController  = require('../controllers/paperController');
var questionController = require('../controllers/questionController');

const userMiddleware = require('../config/middleware/users.js');
//
module.exports = function(app) {
   // If the user has valid login credentials, send them to user array.
  // Otherwise the user will be sent an error
  
  app.post("/api/login",userController.doApiLogin);

  app.get('/api/secret-route', userMiddleware.isLoggedIn, (req, res, next) => {
    console.log(req.userData);
    res.send('This is the secret content. Only logged in users can see that!');
  });

  app.post("/api/getPaperList/:user_id",paperController.getPaperListAPI);

  app.get("/api/getPaperQuestion/:id",questionController.getPaperQuestionsAPI);

   //url for api to submit answer
  app.post('/api/saveAnswer',questionController.saveUserAnswerAPI);

  //api for fetching answer list for user

  app.post('/api/getAnswerWithQuestionList',questionController.getAnswerWithQuestionListAPI);


};