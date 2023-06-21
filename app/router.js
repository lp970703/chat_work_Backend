'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  // 重定向到swagger-ui.html
  app.router.redirect('/', '/swagger-ui.html', 302);

  // 该路径为重定向url的路径，当获取验证码后，根据redirect_uri重定向到这里，然后该方法实现的是获取token
  router.get('/ouath2', controller.home.index);

  // OAuth 服务的前端登录页面（第一步）
  router.get('/authorize', controller.user.authorize);

  // 通过authorization_code（授权码）获取 accessToken，也可以通过refresh_token（刷新的token）获取accessToken，根据grant_type来判断
  // 获取授权码
  // authorize 是用来获取授权码的路由
  // 生命周期：getClient --> getUser --> saveAuthorizationCode（第二步）
  router.all('/api/user/authorize', app.oAuth2Server.authorize());

  // ouath2中password登录获取token，也可以通过授权码获取token(这里通过body里面的grant_type来判断是哪种登录方式：password——密码登录，authorization_code——授权码登录，refresh_token——刷新token登录)
  // token 是用来发放访问令牌的路由
  // 生命周期：getClient --> getAuthorizationCode --> saveToken --> revokeAuthorizationCode（第三步）
  router.all('/api/user/token', app.oAuth2Server.token());

  // 通过 accessToken 获取用户信息
  // authenticate 是登录之后可以访问的路由
  // 生命周期：getAccessToken
  router.post('/api/user/authenticate', app.oAuth2Server.authenticate(), ctx => {
    ctx.body = ctx.state.oauth;
  });

  // user
  router.post('/api/v1/user/register', controller.user.registerUser);
  router.post('/api/v1/user/selectUserId', app.oAuth2Server.authenticate(), controller.user.selectUserId);
  // job
  router.post('/api/v1/job/upload/resume', app.oAuth2Server.authenticate(), controller.job.uploadResume);
  router.post('/api/v1/job/analysis/resume', app.oAuth2Server.authenticate(), controller.job.analysisResume);
};
