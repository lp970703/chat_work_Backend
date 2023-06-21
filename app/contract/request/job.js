'use strict';

module.exports = {
  UploadResumeReq: {
    upfile: { type: 'file', required: true, description: '上传的文件' },
    filename: { type: 'string', required: true, description: '文件名字' },
    userId: { type: 'string', required: true, description: '用户id' },
    workername: { type: 'string', required: true, description: '简历名字' },
  },
  analysisResumeReq: {
    userId: { type: 'string', required: true, description: '登录的userId' },
    workername: { type: 'string', required: true, description: '简历人的名字' },
    pageNum: { type: 'string', required: true, description: '每页的个数' },
    page: { type: 'string', required: true, description: '第几页' },
  },
};
