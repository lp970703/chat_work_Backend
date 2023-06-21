'use strict';

exports.static = true;

// 跨域
exports.cors = {
  enable: true,
  package: 'egg-cors',
};

// swagger文档
exports.swaggerdoc = {
  enable: true,
  package: 'egg-swagger-doc',
};

// sequelize ORM
exports.sequelize = {
  enable: true,
  package: 'egg-sequelize',
};


exports.nunjucks = {
  enable: true,
  package: 'egg-view-nunjucks',
};

exports.ejs = {
  enable: true,
  package: 'egg-view-ejs',
};


// oauth2
exports.oAuth2Server = {
  enable: true,
  package: 'egg-oauth2-server',
};
