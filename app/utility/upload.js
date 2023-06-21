'use strict';
const formidable = require('formidable');
const fs = require('fs');

class UploadUntil {
  // 使用formidable解析formdata
  async parse(req) { // 使用formidable解析formdata
    const form = new formidable.IncomingForm();
    return new Promise((resolve, reject) => {
      form.parse(req, (err, fields, files) => {
        resolve({ fields, files });
        // eslint-disable-next-line prefer-promise-reject-errors
        reject(res => { console.log(res); });
      });
    });
  }

  /**
 * 创建要转换mp4的文件夹
 * @param {*} targetPath
 * @return
 */
  async mkdirSync(targetPath) {
    try {
      if (!fs.existsSync(targetPath)) {
        fs.mkdirSync(targetPath);
      }
    } catch (error) {
      console.log(error);
    }
  }
}
module.exports = UploadUntil;
