const datatable = require(`sequelize-datatable`);
const  db = require("../models");

const bcrypt = require("bcryptjs");

const jwt = require('jsonwebtoken');

var userController = {  
    showLogin(req,res){

        // If the user already has an account send them to the members page
        if (req.user) {
            res.redirect("/dashboard");
        }
        //res.sendFile(path.join(__dirname, "../public/login.html"));
        res.render('users/login',{message:req.flash('loginMessage')})
        
    }, 
    doLogin(req,res){
        // Since we're doing a POST with javascript, we can't actually redirect that post into a GET request
        // So we're sending the user back the route to the members page because the redirect will happen on the front end
        // They won't get this or even be able to access this page if they aren't authed
        res.redirect("/dashboard");
    },
    showSignup(req,res){
         // If the user already has an account send them to the members page
        if (req.user) {
            res.redirect("/dashboard");
        }
        //res.sendFile(path.join(__dirname, "../public/signup.html"));
        res.render('users/signup',{message:req.flash('signupMessage')})
    },
    doSignup(req,res){
        console.log(req.body);
        db.User.create({
        email: req.body.email,
        username: req.body.username,
        password: req.body.password,
        type: req.body.type
        }).then(function() {
        req.flash('loginMessage', 'Sucessfully Signup')
        res.redirect("/login");
        }).catch(function(err) {
        req.flash('signupMessage', err.errors[0].message)
        res.redirect("/signup");
        // res.status(422).json(err.errors[0].message);
        });
    },
    showDashboard(req,res){  
        //console.log(req)
      //,{ layout: 'layouts/main' }
      //res.sendFile(path.join(__dirname, "../public/members.html"));
      res.render('dashboard/index',{ layout: 'layouts/main',title : 'Dashboard',message:req.flash('loginMessage') })
    },
    doLogout(req,res){
        req.flash('signupMessage', 'Sucessfully Logout')
    
        req.logout();
        
        res.redirect("/");
    },
    showUsers(req,res){
        //console.log('I am in paper routes');
        let limit = 10   // number of records per page
        let offset = 0
        db.User.findAndCountAll()
        .then((data) => {
        let page = req.query.page || 1      // page number
        let pages = Math.ceil(data.count / limit)
        let pageStart = page
        let lastPage = 10 + pageStart
        offset = limit * (page - 1);
        db.User.findAll(
        {
            limit: limit,
            offset: offset,
            order: [['createdAt', 'DESC']]
        })
        .then((users) => {
            console.log(users);
            res.render('users/list', {
                    layout: 'layouts/main',
                    pageStart: pageStart,
                    lastPage : lastPage,
                    pages : pages,
                    currentPage : page,
                    users: users,
                    title : 'User List'
            });
        });
        })
        .catch(function (error) {
        res.status(500).send('Internal Server Error');
        });
    },
    addUser(req,res){
        res.render('users/add', {
            layout: 'layouts/main',
            title : 'Add User'
        });
    },
    saveUser(req,res){
        return db.User.create({
            firstname: req.body.firstname,
            lastname: req.body.lastname,
            email: req.body.email,
            username: req.body.username,
            password: req.body.password,
            type: req.body.type
          }).then(function (user) {
            req.flash('sucessMessage', 'Sucessfully added')
            res.redirect("/users");
        });
    },
    editUser(req,res){

        db.User.findOne({
            where: {
                id: req.params.id
            }
        }).then((user)=>{
            res.render('users/edit', {
                layout: 'layouts/main',
                user:user,
                title : 'Edit User'
            });
        });
    },
    updateUser(req,res){
        const query={    
            firstname: req.body.firstname,
            lastname: req.body.lastname,
            email: req.body.email,
            username: req.body.username,
            type: req.body.type
        }
        
        if(req.body.password != '') 
            query.push(query,{password: req.body.password})
        
        db.User.update(query,{where:{id:req.body.id}})    
        .then(function(data){    
            req.flash('sucessMessage', 'Sucessfully updated')
            res.redirect("/users");    
        })    
        .catch(function(error){    
            console.log('error occured',error)    
        }); 
    },
    doApiLogin(req , res, next){        
        var email = req.body.email;
        var password = req.body.password;
        db.User.findOne({
            where: {
            email: email,
            type: "user"
            }
        }).then(function(dbUser) {
            // If there's no user with the given email
            if (!dbUser) {
            return res.status(401).send({
                msg: 'Incorrect email!'
            });
            }
            // If there is a user with the given email, but the password the user gives us is incorrect
            else if (!dbUser.validPassword(password)) {
            return res.status(401).send({
                msg: 'Incorrect password!'
            });
            }
            const token = jwt.sign({
                email: dbUser.email,
                userId: dbUser.id
            },
            'SECRETKEY', {
                expiresIn: '7d'
            }
            );

            return res.status(200).send({
                msg: 'Logged in!',
                token,
                user: dbUser
            });

        });


    }
}    
    
module.exports = userController; 