// Creating our UserAnswer model
//Set it as export because we will need it required on the server
module.exports = function(sequelize, DataTypes) {
  var UserAnswer = sequelize.define("UserAnswer", {
    // The email cannot be null, and must be a proper email before creation
    id:{
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
      type: DataTypes.INTEGER
    },
    paper_id: {
      allowNull: true,
      type: DataTypes.INTEGER
    },
    question_id: {
      allowNull: true,
      type: DataTypes.INTEGER
    },
    user_id: {
      allowNull: true,
      type: DataTypes.INTEGER
    },
    answer: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    mark: DataTypes.DECIMAL(4,2)
  });

  var Question  = sequelize.define('Question', {id:{
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER
  },
title: DataTypes.STRING});

UserAnswer.belongsTo(Question, {foreignKey: 'question_id'});

  var Paper  = sequelize.define('Paper', {id:{
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
      type: DataTypes.INTEGER
  },
  title: DataTypes.STRING});

  UserAnswer.belongsTo(Paper, {foreignKey: 'paper_id'});

  var User  = sequelize.define('User', {id:{
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER
  },
  username: DataTypes.STRING});


  UserAnswer.belongsTo(User, {foreignKey: 'user_id'});
  
  return UserAnswer;
};

