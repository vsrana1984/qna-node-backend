// Requiring path to so we can use relative routes to our HTML files
//const datatable = require(`sequelize-datatable`);
//const  db = require("../models");

var paperController  = require('../controllers/paperController');
//
// Requiring our custom middleware for checking if a user is logged in
var isAuthenticated = require("../config/middleware/isAuthenticated");
//


module.exports = function(app) {
  //root url for site
  app.get("/papers", isAuthenticated, paperController.listPapers);

  app.get("/paper/add", isAuthenticated, paperController.addPaper); 

  app.post("/paper/add", paperController.savePaper); 

  app.get("/paper/edit/:id", isAuthenticated, paperController.editPaper); 

  app.post('/paper/update',paperController.updatePaper); 

};