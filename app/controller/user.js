// {app_root}/app/controller/user.js
'use strict';

// const Controller = require('egg').Controller;
const BaseController = require('./base.js');

/**
 * @controller user 用户接口
 */
class UserController extends BaseController {

  get userService() {
    return this.ctx.service.user;
  }

  // 渲染登录页面
  async authorize() {
    const query = this.ctx.querystring;
    await this.ctx.render('login', {
      title: 'OAuth 账户登录',
      query,
    });
  }

  /**
  * @summary 注册接口
  * @router post /api/v1/user/register
  * @Request body registerReq
  * @response 200 registerRes
  */
  async registerUser() {
    const memberInfo = this.ctx.request.body;
    const res = await this.userService.registerUser(memberInfo);
    this.setRes(res);
  }

  /**
  * @summary 查询userId
  * @router post /api/v1/user/selectUserId
  * @Request body selectUserIdReq
  * @response 200 selectUserIdRes
  */
  async selectUserId() {
    const userInfo = this.ctx.request.body;
    const res = await this.userService.selectUserId(userInfo);
    this.setRes(res);
  }
}

module.exports = UserController;
