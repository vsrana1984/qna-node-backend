//
// Creating our Question model
//Set it as export because we will need it required on the server
module.exports = function(sequelize, DataTypes) {

    var Question = sequelize.define('Question', {
          id:{
              allowNull: false,
              autoIncrement: true,
              primaryKey: true,
              type: DataTypes.INTEGER
          },
          title: DataTypes.TEXT,
          paper_id: {
            allowNull: true,
            type: DataTypes.INTEGER,
            references: {
              model: 'paper',
              key: 'paper_id'
            }
          },
          option1: DataTypes.STRING,
          option2: DataTypes.STRING,
          option3: DataTypes.STRING,
          option4: DataTypes.STRING,
          mark: DataTypes.DECIMAL(4,2),
          answer: DataTypes.STRING
    });

    Question.associate = (models) => {
      // associations can be defined here
      Question.hasOne(models.UserAnswer, { foreignKey: 'question_id' });
    };

    var Paper  = sequelize.define('Paper', {id:{
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER
    },
    title: DataTypes.STRING});


    Question.belongsTo(Paper, {foreignKey: 'paper_id'});
  
    return Question;
  
  };