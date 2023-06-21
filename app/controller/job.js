// {app_root}/app/controller/job.js
'use strict';

// const Controller = require('egg').Controller;
const BaseController = require('./base.js');

/**
 * @controller job 简历工作相关接口
 */
class JobController extends BaseController {

  get jobService() {
    return this.ctx.service.job;
  }

  get uploadUtil() {
    return this.ctx.utility.upload;
  }

  /**
  * @summary 接口详情
  * @router post /api/v1/job/upload/resume
  * @Request formData file upfile 上传的文件
  * @Request formData string filename 文件名字
  * @Request formData string userId 用户id
  * @Request formData string workername 简历名字
  * @response 200 UploadResumeRes
  */
  async uploadResume() {
    // 上传文件，对文件进行解析的操作，返回文件和文件大小等详情
    const extraParams = await this.uploadUtil.parse(this.ctx.req);
    const res = await this.jobService.uploadResume(extraParams);
    this.setRes(res);
  }

  /**
  * @summary 接口详情
  * @router post /api/v1/job/analysis/resume
  * @Request body analysisResumeReq
  * @response 200 analysisResumeRes
  */
  async analysisResume() {
    const resumeInfo = this.ctx.request.body;
    const res = await this.jobService.analysisResume(resumeInfo);
    this.setRes(res);
  }
}

module.exports = JobController;
