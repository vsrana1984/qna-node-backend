// Requiring path to so we can use relative routes to our HTML files
//const datatable = require(`sequelize-datatable`);
//const  db = require("../models");

var questionController  = require('../controllers/questionController');   
//
// Requiring our custom middleware for checking if a user is logged in
var isAuthenticated = require("../config/middleware/isAuthenticated");
//


module.exports = function(app) {
  //root url for site
  app.get("/questions", isAuthenticated, questionController.listQuestions);

  app.get("/question/add",isAuthenticated, questionController.addQuestion); 

  app.post("/question/add", isAuthenticated, questionController.saveQuestion); 

  app.get('/question/edit/:id',isAuthenticated, questionController.editQuestion);  

  app.post('/question/update',questionController.updateQuestion); 

 



};