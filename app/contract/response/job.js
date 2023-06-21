'use strict';

module.exports = {
  registerRes: {
    registerCode: { type: 'string', enum: [ '40001', '40002', '40003', '40004' ], description: '40001: 注册成功; 40002: 该手机号已注册,请更换手机; 40003: 账号已注册; 40004: 该客户端id验证失败,联系后端增加客户端id,否则该客户端不能访问数据' },
    registerInfo: { type: 'string', description: '注册信息返回' },
    userId: { type: 'string', description: 'userId' },
  },
  analysisResumeRes: {
    data: { type: 'array', itemType: 'string', description: '职位的数据' },
  },
};
