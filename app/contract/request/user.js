'use strict';

module.exports = {
  registerReq: {
    clientId: { type: 'string', required: true, description: '客户端Id' },
    clientSecret: { type: 'string', required: true, description: '客户端Secret' },
    username: { type: 'string', required: true, description: '用户名账号' },
    password: { type: 'string', required: true, description: '用户名密码' },
    phone: { type: 'string', required: true, format: /^1[34578]\d{9}$/, description: '用户手机' },
    email: { type: 'string', required: true, example: '1277838445@qq.com', format: /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/, description: '邮箱' },
  },
  selectUserIdReq: {
    clientId: { type: 'string', required: true, description: '客户端Id' },
    clientSecret: { type: 'string', required: true, description: '客户端Secret' },
    username: { type: 'string', required: true, description: '用户名账号' },
    password: { type: 'string', required: true, description: '用户名密码' },
    phone: { type: 'string', required: true, format: /^1[34578]\d{9}$/, description: '用户手机' },
    email: { type: 'string', required: true, example: '1277838445@qq.com', format: /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/, description: '邮箱' },
  },
};
