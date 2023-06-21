/* eslint valid-jsdoc: "off" */

'use strict';

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = exports = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1683612878772_6267';

  // add your middleware config here
  config.middleware = [];

  // add your user config here
  const userConfig = {
    // myAppName: 'egg',
  };

  config.security = {
    csrf: {
      enable: false,
      ignoreJSON: true,
    },
    domainWhiteList: [ '*' ],
  };

  // 跨域配置
  config.cors = {
    origin: '*',
    allowMethods: 'GET,HEAD,PUT,POST,DELETE,PATCH',
  };

  // swagger文档配置
  config.swaggerdoc = {
    dirScanner: './app/controller', // 插件扫描的文档路径
    apiInfo: {
      title: '卢鹏egg-login-swagger文档',
      description: '卢鹏egg-login-swagger文档',
      version: '1.0.0',
    },
    consumes: [ 'application/json', 'multipart/form-data' ], // 指定处理请求的提交内容类型（Content-Type），例如application/json, text/html
    produces: [ 'application/json', 'multipart/form-data' ], // 指定返回的内容类型，仅当request请求头中的(Accept)类型中包含该指定类型才返回
    schemes: [ 'http', 'https' ],
    securityDefinitions: {
      oauth2: {
        type: 'oauth2',
        tokenUrl: 'http://127.0.0.1:7001/api/user/token',
        flow: 'password',
        scopes: {
          'write:access_token': 'write access_token',
          'read:access_token': 'read access_token',
        },
      },
    },
    routerMap: false, // 是否自动生成route
    enable: true,
  };

  // 访问数据库
  config.sequelize = {
    dialect: 'mysql', // 数据库类型，支持 mysql，sqlite,mssql,pgsql,oracle。
    host: '127.0.0.1', // 数据库服务器地址。
    port: 3306, // 数据库连接端口号。
    database: 'chat_work', // 数据库名称。
    username: 'root', // 数据库登录用户名。
    password: 'lupeng0703', // 数据库登录密码。
    timezone: '+08:00', // 时区 东八区
    underscored: true, // 是否自动进行下划线转换（这里是因为DB默认的命名规则是下划线方式，而我们使用的大多数是驼峰方式）
    define: {
      freezeTableName: true, // Model 对应的表名将与model名相同。
      timestamps: false, // 默认情况下，Sequelize会将createdAt和updatedAt的属性添加到模型中，以便您可以知道数据库条目何时进入数据库以及何时被更新。
    },
  };

  // oauth2
  config.oAuth2Server = {
    grants: [ 'password', 'client_credentials', 'authorization_code', 'refresh_token' ],
  };

  config.view = {
    defaultViewEngine: 'nunjucks',
    mapping: { '.html': 'ejs' }, // 意思将 view 文件夹下的 .html 后缀的文件，识别为 .ejs
  };

  // 关于日志的问题
  config.logrotator = {
    filesRotateBySize: [],
    filesRotateByHour: [],
    maxFileSize: 50 * 1024 * 1024,
    maxDays: 15,
  };

  config.logger = {
    disableConsoleAfterReady: false,
    outputJSON: false,
    consoleLevel: 'DEBUG',
    buffer: true,
    allowDebugAtProd: false,
  };

  // egg自带的sercurity密钥，这里我们会自己写header来防止xss攻击和cxrf攻击，详情请看
  // https://eggjs.org/zh-cn/core/security.html#安全威胁csrf的防范
  // https://blog.csdn.net/weixin_43704471/article/details/90763103
  config.security = {
    xframe: {
      enable: false,
    },
    csrf: {
      enable: false,
      ignoreJSON: true,
    },
    domainWhiteList: [ '*' ],
  };

  config.multipart = {
    fileSize: '50mb',
    mode: 'stream',
    fileExtensions: [ '.pdf', '.txt' ], // 扩展几种上传的文件格式
  };

  return {
    ...config,
    ...userConfig,
  };
};
