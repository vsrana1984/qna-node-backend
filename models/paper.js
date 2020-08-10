//
// Creating our Paper model
//Set it as export because we will need it required on the server
module.exports = function(sequelize, DataTypes) {

    var Paper = sequelize.define('Paper', {
          id:{
              allowNull: false,
              autoIncrement: true,
              primaryKey: true,
              type: DataTypes.INTEGER
          },
          title: DataTypes.STRING,
          subject: DataTypes.STRING,
          description: DataTypes.STRING,
          created_by: {
              allowNull: true,
              type: DataTypes.INTEGER
          }
        }
    );

    Paper.associate = (models) => {
        // associations can be defined here
        Paper.hasOne(models.Result, { foreignKey: 'paper_id' });
    };

    return Paper;
  
  };