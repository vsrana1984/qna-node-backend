const datatable = require(`sequelize-datatable`);
const  db = require("../models");

var questionController = {  
      //show list of questions in list
    listQuestions(req,res){
        //console.log('I am in paper routes');
        let limit = 10   // number of records per page
        let offset = 0
        db.Question.findAndCountAll()
        .then((data) => {
        let page = req.query.page || 1      // page number
        let pages = Math.ceil(data.count / limit) //total number of pages
        let pageStart = page //page start from
        let lastPage = 10 + pageStart
        offset = limit * (page - 1);
        //find all question 10 at a time
        db.Question.findAll(
        {
            //join paper and gets its details
            include: [{
                model: db.Paper,
                required: false
               }],
            limit: limit,
            offset: offset,
            order: [['createdAt', 'DESC']]
        })
        .then((questions) => {
            //console.log(questions);
            res.render('questions/index', {
                    layout: 'layouts/main',
                    pageStart: pageStart,
                    lastPage : lastPage,
                    pages : pages,
                    currentPage : page,
                    questions: questions,
                    title : 'Question'
            });
        });
        })
        .catch(function (error) {
            res.status(500).send('Internal Server Error');
        });
    }, 
    //call for showing add question form
    addQuestion(req,res){
        
        db.Paper.findAll({
            order: [['title', 'DESC']]
        }).then((papers)=>{
            res.render('questions/add', {
                layout: 'layouts/main',
                papers: papers,
                title : 'Add Question'
            });
        });
        
    },
    //save new question and its option
    saveQuestion(req,res){
        return db.Question.create({
            title: req.body.title,
            paper_id: req.body.paper_id, 
            option1: req.body.option1,
            option2: req.body.option2,
            option3: req.body.option3,
            option4: req.body.option4,
            answer: req.body.answer,
            mark: req.body.mark
          }).then(function (papers) {
            req.flash('sucessMessage', 'Sucessfully added')
            res.redirect("/questions");
        });
    },
    //fetch question details and show in edit form
    editQuestion(req,res){
        //console.log('id',req.params.id)
        db.Question.findOne({
            where: {
                id: req.params.id
            }
            }).then((question)=>{
                //console.log(question);
                db.Paper.findAll({
                    order: [['title', 'DESC']]
                }).then((papers)=>{
                    res.render('questions/edit', {
                        layout: 'layouts/main',
                        question: question,
                        papers: papers,
                        title : 'Edit Question'
                    });
                });
                
        }); 
    },
    //update question and its option....
    updateQuestion(req,res){    
        //console.log(req.body)    
        const query={    
            title: req.body.title,
            paper_id: req.body.paper_id, 
            option1: req.body.option1,
            option2: req.body.option2,
            option3: req.body.option3,
            option4: req.body.option4,
            answer: req.body.answer,
            mark: req.body.mark
        }    
        db.Question.update(query,{where:{id:req.body.id}})    
        .then(function(data){    
            req.flash('sucessMessage', 'Sucessfully updated')
            res.redirect("/questions");    
        })    
        .catch(function(error){    
            console.log('error occured',error)    
        });      
    },
    //call from API
    //fetch all list of paper call from API
    getPaperQuestionsAPI(req , res){

        db.Question.findAll({
            where: {
                paper_id: req.params.id
            }
            }).then((questions)=>{
               
                return res.status(200).send({
                    msg: 'List of questions!',
                    questions: questions
                });
                
            }).catch(function (error) {
            
                return res.status(401).send({
                    msg: 'Error while fetching questions!'
                });
    
        }); 

    },
    //call from API
    //save user answer info for paper
    saveUserAnswerAPI(req , res){
        
       // console.log(req.body.paperInfo);  

        var userAnsData = req.body.answersInfo; 
        var userResult = req.body.paperInfo;

        try {     
            //save result for user
            const result =  db.Result.create(userResult);
            //save all question answer data
            const ansData = db.UserAnswer.bulkCreate(userAnsData);
            
            return res.status(200).send({
                msg: 'Sucessfully Saved'
            });
        } catch (error) {
            return res.status(401).send({
                //msg: 'Error while saving user answer!'
                msg: error
            });   
        }
  

    },
    // API call from VUE
    // get list of question and it's answer for logged in user
    getAnswerWithQuestionListAPI(req,res){
        //console.log(req);
        db.Question.findAll({
            include: [
                {
                    model: db.UserAnswer,
                    required: true,
                    where:{ user_id: req.body.user_id }
                }
            ],
            where: {
                paper_id: req.body.paper_id
            }
            }).then((questions)=>{
               console.log(questions);
                return res.status(200).send({
                    msg: 'List of questions!',
                    questions: questions
                });
                
            }).catch(function (error) {
                console.log(error);
                return res.status(401).send({
                    msg: 'Error while fetching questions!'
                });
    
        }); 
    }

}    
    
module.exports = questionController; 