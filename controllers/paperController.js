const datatable = require(`sequelize-datatable`);
const  db = require("../models");

var paperController = {  
    listPapers(req,res){
        //console.log('I am in paper routes');
        let limit = 10   // number of records per page
        let offset = 0
        db.Paper.findAndCountAll()
        .then((data) => {
        let page = req.query.page || 1      // page number
        let pages = Math.ceil(data.count / limit)
        let pageStart = page
        let lastPage = 10 + pageStart
        offset = limit * (page - 1);
        db.Paper.findAll(
        {
            limit: limit,
            offset: offset,
            order: [['createdAt', 'DESC']]
        })
        .then((papers) => {
            console.log(papers);
            res.render('papers/index', {
                    layout: 'layouts/main',
                    pageStart: pageStart,
                    lastPage : lastPage,
                    pages : pages,
                    currentPage : page,
                    papers: papers,
                    title : 'Paper List'
            });
        });
        })
        .catch(function (error) {
        res.status(500).send('Internal Server Error');
        });
    }, 
    addPaper(req,res){
        
        res.render('papers/add', {
            layout: 'layouts/main',
            title : 'Add Paper'
        });
        
    },
    savePaper(req,res){
        return db.Paper.create({
            title: req.body.title,
            subject: req.body.subject,
            description: req.body.description,
            created_by: req.user.id
          }).then(function (papers) {
            req.flash('sucessMessage', 'Sucessfully added')
            res.redirect("/papers");
        });
    },
    editPaper(req,res){
        console.log('id',req.params.id)
        db.Paper.findOne({
            where: {
                id: req.params.id
            }
            }).then((paper)=>{
               
                res.render('papers/edit', {
                    layout: 'layouts/main',
                    paper: paper,
                    title : 'Edit Paper'
                });
                
        }); 
    },
    updatePaper(req,res){    
        console.log(req.body)    
        const query={    
            title: req.body.title,
            subject: req.body.subject,
            description: req.body.description,
            created_by: req.user.id
        }    
        db.Paper.update(query,{where:{id:req.body.id}})    
        .then(function(data){    
            req.flash('sucessMessage', 'Sucessfully updated')
            res.redirect("/papers");    
        })    
        .catch(function(error){    
            console.log('error occured',error)    
        });      
    },
    //get list of paper and result for logged in user if paper's been given
    getPaperListAPI(req , res){
       
        db.Paper.findAll({
            //join result and gets its details
            include: [
                {
                    model: db.Result,
                    required: false,
                    where:{ user_id: req.params.user_id }
                }
            ],
            order: [['createdAt', 'DESC']]
        }).then((papers) => {
            console.log(papers);
            return res.status(200).send({
                msg: 'List of papers!',
                papers: papers
            });

        }).catch(function (error) {
            console.log(error);
            return res.status(401).send({
                msg: 'Error while fetching papers!'
            });

        });
    }
}    
    
module.exports = paperController; 