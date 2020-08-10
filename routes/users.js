// Requiring path to so we can use relative routes to our HTML files
var path = require("path");
// Requiring our models and passport as we've configured it
var db = require("../models");
var passport = require("../config/passport");

var userController  = require('../controllers/userController');   
//
// Requiring our custom middleware for checking if a user is logged in
var isAuthenticated = require("../config/middleware/isAuthenticated");
//
module.exports = function(app) {
  //root url for site
  app.get('/', (req, res) => {
       // If the user already has an account send them to the members page
      if (req.user) {
        res.redirect("/dashboard");
      }else{
        res.redirect("/login");
      }

  })

  //
  app.get("/login",userController.showLogin);

  app.post("/login",passport.authenticate('local', {
    successRedirect: '/dashboard',
    failureRedirect: '/login',
    failureFlash: true
   }), userController.doLogin);

  //
  app.get("/signup", userController.showSignup);

   // Route for signing up a user. The user's password is automatically hashed and stored securely thanks to
  // how we configured our Sequelize User Model. If the user is created successfully, proceed to log the user in,
  // otherwise send back an error
  app.post("/signup", userController.doSignup);

//
  // Here we've add our isAuthenticated middleware to this route.
  // If a user who is not logged in tries to access this route they will be 
  //redirected to the signup page
  app.get("/dashboard", isAuthenticated, userController.showDashboard);

  // Route for logging user out
  app.get("/logout", userController.doLogout);

  //show list of all type of users
  //isAuthenticated middleware to checked login user
  app.get("/users", isAuthenticated, userController.showUsers);

  //show add user form interface
  //isAuthenticated middleware to checked login user
  app.get("/user/add", isAuthenticated, userController.addUser);

  //save new user

  app.post('/user/add',userController.saveUser);

  //show edit user form
  app.get('/user/edit/:id', isAuthenticated, userController.editUser);

  //update user data form
  app.post('/user/update',userController.updateUser);


};