//
// Creating our Result model
//Set it as export because we will need it required on the server
module.exports = function(sequelize, DataTypes) {

    var Result = sequelize.define('Result', {
          id:{
              allowNull: false,
              autoIncrement: true,
              primaryKey: true,
              type: DataTypes.INTEGER
          },
          user_id: {
              allowNull: true,
              type: DataTypes.INTEGER
          },
          paper_id: {
            allowNull: true,
            type: DataTypes.INTEGER,
            references: {
              model: 'paper',
              key: 'paper_id'
            }
          },
          total_paper_mark: DataTypes.DECIMAL(4,2),
          total_user_mark: DataTypes.DECIMAL(4,2)
        }        
    );

    Result.associate = (models) => {
        // associations can be defined here
        Result.belongsTo(models.Paper, { foreignKey: 'paper_id', });
    };

    return Result;
  
  };