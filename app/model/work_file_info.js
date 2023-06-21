/* indent size: 2 */
const sequelize = require('sequelize');
module.exports = app => {
  const DataTypes = app.Sequelize;

  const Model = app.model.define('work_file_info', {
    id: {
      type: DataTypes.BIGINT,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    userId: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    workername: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    worker_id: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    file_id: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    file_type: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    file_name: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    file_router: {
      type: DataTypes.STRING(50),
      allowNull: true,
    },
    last_file: {
      type: DataTypes.STRING(2),
      allowNull: true,
    },
    createAt: {
      type: DataTypes.TIME,
      allowNull: true,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP'),
    },
  }, {
    tableName: 'work_file_info',
  });

  Model.associate = function() {

  };

  return Model;
};
