'use strict';

const BaseService = require('./base.js');
const { v4: uuidv4 } = require('uuid');
// const uuidv4 = require('uuid/v4');
// const _ = require('lodash');
// const WXBizDataCrypt = require('../extend/WXBizDataCrypt');
// const moment = require('moment');
class userService extends BaseService {
  constructor(...args) {
    super(...args);
    this.AppConfig = this.ctx.app.config.appConfig;

    this.apiGet = this.ctx.helper.ApiGet;

    this.CacheConfig = this.ctx.app.config.CacheConfig;

  }

  /**
   * 注册用户
   * @param {*} memberInfo
   * @return
   */
  async registerUser(memberInfo) {
    this.ctx.logger.info('memberInfo => memberInfo: %j', memberInfo);
    // console.log(memberInfo);
    // 1、验证clientid是否被授权（即数据库是否有前端传来的clientid和对应的clientSecret，没有的话返回40004，说明该前端项目（客户端id）没有授权注册访问
    // 注意：一般clientId和clientSecret是前端和后端约定好的，clientSecret通常用来进行一层加密，这样做的目的是为了防止非授权的clientId进行无限制刷注册接口）
    const clientIdRes = await this.model.Client.findOne({
      where: {
        clientId: memberInfo.clientId,
      },
    });
    if (!clientIdRes) {
      return { registerCode: '40004', registerInfo: '该客户端id并未授权' };
    }
    // 2、查询手机号看是否被注册过
    const UserRes = await this.model.User.findAll({
      where: {
        phone: memberInfo.phone,
      },
    });
    if (UserRes.length > 0) {
      if (UserRes.some(s => s.username === memberInfo.username)) {
        return { registerCode: '40003', registerInfo: '账号已注册' };
      }
      return { registerCode: '40002', registerInfo: '该手机号已注册,请更换手机' };
    }
    // 3、查询username是否存在，若已存在提示该用户名已存在
    const UserResByName = await this.model.User.findAll({
      where: {
        username: memberInfo.username,
      },
    });
    if (UserResByName.length > 0) {
      return { registerCode: '40005', registerInfo: '用户名已注册，请更换用户名' };
    }
    // 4、未被注册，根据前端传回的clientInfo生成clentId（clientInfo字符串-凭借随机数生成8位），并随机生成userId（根据uuid生成），并将注册的账号密码分别存到client表和user表中
    // const clientSecret = await this.getNanoid(8);
    const userId = uuidv4().split('-').join('');
    await this.model.Client.create({
      id: 0,
      clientId: memberInfo.clientId,
      userId,
      clientSecret: memberInfo.clientSecret,
      redirectUri: 'http://127.0.0.1:7001/ouath2',
      grants: memberInfo.grants ? memberInfo.grants : 'password',
    });
    await this.model.User.create({
      id: 0,
      userId,
      username: memberInfo.username,
      password: memberInfo.password,
      createAt: new Date(),
      phone: memberInfo.phone,
      email: memberInfo.email,
    });
    // 整理返回的数据
    return { registerCode: '40001', registerInfo: '注册成功', userId };
  }

  /**
   * 查询用户id
   * @param {*} userInfo 
   * @returns 
   */
  async selectUserId(userInfo) {
    const userData = await this.model.User.findAll({
      where: {
        username: userInfo.username,
        password: userInfo.password,
      },
    });
    if (userData.length > 0) {
      return { userId: userData[0].userId };
    }
  }

}

module.exports = userService;
