'use strict';

const BaseService = require('./base.js');
const { v4: uuidv4 } = require('uuid');
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const awaitWriteStream = require('await-stream-ready').write;
const sendToWormhole = require('stream-wormhole');

const PDFParser = require('pdf2json');
const resumeRule = require('../utility/resumeRule.json');
const { once } = require('node:events');

// const uuidv4 = require('uuid/v4');
// const _ = require('lodash');
// const WXBizDataCrypt = require('../extend/WXBizDataCrypt');
// const moment = require('moment');
class jobService extends BaseService {
  constructor(...args) {
    super(...args);
    this.AppConfig = this.ctx.app.config.appConfig;

    this.apiGet = this.ctx.helper.ApiGet;

    this.CacheConfig = this.ctx.app.config.CacheConfig;

  }

  get uploadUtil() {
    return this.ctx.utility.upload;
  }

  /**
   * 上传简历接口
   * @param {*} uploadResumeInfo 上传简历需要的信息
   * @return
   */
  async uploadResume(uploadResumeInfo) {
    // 1、获取上传信息
    const file = uploadResumeInfo.files.upfile; // 得到文件upfile，我的vue传过来的file就叫做upfile，所以这里取出来也是通upfile
    const fields = uploadResumeInfo.fields;

    // 2、创建新的文件路径，并将该文件保存到该文件夹下（该文件的路径为'app/upload/workPDF/'拼接userId）
    const targetDir = path.join('app/upload/workPDF', fields.userId);// 目标路径
    await this.uploadUtil.mkdirSync(targetDir);

    // 3、将文件写入指定目录中
    const stream = fs.createReadStream(file._writeStream.path);// 创建文件读取流，从临时文件中读取
    const fileName = fields.filename;// 文件命名
    const target = `${targetDir}\\${fileName}`;
    const writeStream = fs.createWriteStream(target);// 将问价写入目标路径

    try {
      await awaitWriteStream(stream.pipe(writeStream));// 等待完成写入
      // 4.1 查询是否存在已有的简历，已经存在则直接增添新数据，并把原来的last_file改为N(确保每个登陆的，上传同一个人简历的话找到最后一次上传简历的那个人)
      await this.model.WorkFileInfo.update({ last_file: 'N' }, {
        where: {
          userId: fields.userId,
          workername: fields.workername,
          last_file: 'Y',
        },
      });
      // 4.2 增添一笔新上传的数据做备份
      const worker_id = await this.getNanoid(10);
      const file_id = await this.getNanoid(10);
      const fileSuffix = fileName.substring(fileName.lastIndexOf('.') + 1);
      const uploadInfo = {
        id: 0,
        userId: fields.userId,
        workername: fields.workername,
        worker_id,
        file_id,
        file_type: fileSuffix,
        file_name: fileName,
        file_router: target,
        last_file: 'Y',
        createAt: new Date(),
      };
      await this.model.WorkFileInfo.create(uploadInfo);
      return { uploadcode: 40100, Info: '上传文件成功', uploadInfo };
    } catch (err) {
      await sendToWormhole(stream);// 关闭临时文件
      return { uploadcode: 40101, Info: '上传文件失败' };
    }
  }

  /**
   * 简历分析的接口
   * @param {*} resumeInfo 本地保存的简历信息
   * @return
   */
  async analysisResume(resumeInfo) {
    // 1、导出PDF中得文本，并把特殊字符去掉
    const resumeTXT = await this.resumePDFtoTXT(resumeInfo);
    // 2、根据特殊字符以及匹配规则，找到关键字得匹配次数。
    const matchData = await this.matchResumeKeyWords(resumeTXT);
    // 3、查询正在招聘的岗位（按照发布时间倒叙排序），按照关键字出现的次数（即每个关键字在简历中出现的个数）、符合关键字的数量（即数据库查出来的每条数据共包含多少个关键字）
    const recommendJobData = await this.recommendJob(matchData);
    // 4、数据太多，根据前端传参进行分页
    const res = await this.pagingJob(recommendJobData, resumeInfo);

    return res;
  }

  async resumePDFtoTXT(resumeInfo) {
    // 1、查询具体的简历信息
    const resumeAllInfo = await this.model.WorkFileInfo.findOne({
      where: {
        userId: resumeInfo.userId,
        workername: resumeInfo.workername,
        last_file: 'Y',
      },
    });
    const resumeRouter = path.join(resumeAllInfo.file_router);
    let dataTXTs;
    // 2、根据查询简历的信息，将文本导出并根据resumeRule.json进行匹配
    const pdfParser = new PDFParser(this, 1); // 注意：要在函数内定义，不然会报错aync问题
    pdfParser.loadPDF(resumeRouter);
    pdfParser.on('pdfParser_dataError', errData => console.log(errData.parserError));

    // 3、加一个promise对象，将pdfParser.on方法写道这个promise对象中去，然后在analysisResume方法调用resumePDFtoTXT()fa
    const promise = new Promise((resolve, reject) => {
      pdfParser.on('pdfParser_dataReady', pdfData => {
        console.log(resumeRule);
        console.log('step 3');
        // 读取PDF，转换成TXT文本内容
        const dataTXT = pdfParser.getRawTextContent();
        // 正则：删除空白字符和.符号
        dataTXTs = dataTXT.replace(/(\s|\.)+/g, '');
        resolve(dataTXTs);
      });
    });
    return promise;
  }

  async matchResumeKeyWords(dataTXTs) {
    const res = [];
    // 1、遍历解析的规则（目前写死在一个json里面）
    for (const fields of resumeRule) {
      const resItem = {
        matchFields: fields.matchFields,
        fieldsItemArr: [],
      };
      // 2、一对一匹配，即规则json中出现的文字和简历文本进行一一对应
      if (fields.matchRuleByOne && fields.matchRuleByOne.length > 0) {
        await this.matchRuleByOneFun(fields, dataTXTs, resItem);
      }
      // 3、一对多匹配，即规则json中出现的文字，对应的简历可能出现很多相似词汇，统称到规则json中，例如规则中的阿里相当于简历中的Alibaba（英文不区分大小写），阿里，阿里巴巴都算阿里
      if (fields.matchRuleByMore && fields.matchRuleByMore.length > 0) {
        await this.matchRuleByMoreFun(fields, dataTXTs, resItem);
      }
      res.push(resItem);
    }
    return res;
  }

  async matchRuleByOneFun(fields, dataTXTs, resItem) {
    // 1、一一匹配：遍历所有，并将关键字用正则表达式写成一个字符串
    let regExpStr = '';
    for (let matchOnItem of fields.matchRuleByOne) {
      const reg = /\+/g;
      matchOnItem = matchOnItem.replace(reg, '\\+');
      regExpStr += `${matchOnItem}|`;
    }
    // 2、写正则表达式，并将关键字用match方法进行匹配
    regExpStr = regExpStr.substring(0, regExpStr.lastIndexOf('|'));
    const regExp = '(' + regExpStr + ')';
    const matchData = new RegExp(regExp, 'g');
    const target = dataTXTs.match(matchData);
    if (target) {
      // 3、将关键字按照关键字名字，次数进行累加
      resItem.fieldsItemArr = target.reduce((p, c) => {
        const fieldsItem = p.find(f => f.name === c);
        if (fieldsItem) {
          fieldsItem.num += 1;
        } else {
          const fieldsItem = {
            name: c,
            num: 1,
          };
          p.push(fieldsItem);
        }
        return p;
      }, []);
    }
  }

  async matchRuleByMoreFun(fields, dataTXTs, resItem) {
    // 1、一对多匹配
    for (const matchOnItemData of fields.matchRuleByMore) {
      // 1、遍历所有，并将关键字用正则表达式写成一个字符串
      let regExpStr = '';
      if (matchOnItemData.matchArr) {
        for (const matchOnItemSon of matchOnItemData.matchArr) {
          const reg = /\+/g;
          const matchOnItem = matchOnItemSon.replace(reg, '\\+');
          regExpStr += `${matchOnItem}|`;
        }
      }
      // 2、写正则表达式，并将关键字用match方法进行匹配
      regExpStr = regExpStr.substring(0, regExpStr.lastIndexOf('|'));
      const regExp = '(' + regExpStr + ')';
      const matchData = new RegExp(regExp, 'g');
      const target = dataTXTs.match(matchData);
      if (target) {
        // 3、将关键字直接导出，直接获取target的次数即可
        const fieldsItem = {
          name: matchOnItemData.FieldsRes,
          num: target.length,
        };
        resItem.fieldsItemArr.push(fieldsItem);
      }
    }
  }

  async recommendJob(matchData) {
    // 1、查询所有职位
    const jobAllDB = await this.model.InfoCompanyJob.findAll({
      order: [[ 'publish_time', 'desc' ]],
    });
    const targetJobArr = [];
    // 2、依次遍历简历中存在的关键字，并把查询的职位中出现关键字的职位过滤出来，放到targetJobArr数组中，同时根据出现的次数进行记录
    for (const item of matchData) {
      const matchField = item.matchFields;
      for (const fieldItem of item.fieldsItemArr) {
        const reg = /\+/g;
        const fieldName = fieldItem.name.replace(reg, '\\+');
        const targetJob = jobAllDB.filter(job => new RegExp(fieldName, 'g').test(job[matchField]) === true);
        const targetJobArrData = {
          num: fieldItem.num,
          name: fieldItem.name,
          data: [ ...targetJob ],
        };
        targetJobArr.push(targetJobArrData);
      }
    }
    // 3、将targetJobArr数组中的每一个data开始去重（按照id进行去重），若无重复，则把这个data、num、name放到新数组对象JobRes中，并增加type为1，type指的是匹配name的个数
    //  若重复，则不新增，num加上关键字的num值，name后边拼接重复的name，type做过累加。例如：id=10重复了，即'阿里'出现过，'本科'也出现过，那么name值就是'阿里+本科'，type变为2
    const JobRes = [];
    for (const targetJobItem of targetJobArr) {
      for (const dataItem of targetJobItem.data) {
        // 3.1 判断能不能在新数组对象中找到id
        const findData = JobRes.find(jobInfo => jobInfo?.job.id === dataItem.id);
        if (findData) {
          findData.num = findData.num + targetJobItem.num;
          findData.name = findData.name + '-' + targetJobItem.name;
          findData.type += 1;
        } else {
          const JobResItem = {
            job: dataItem,
            num: targetJobItem.num,
            name: targetJobItem.name,
            type: 1,
          };
          JobRes.push(JobResItem);
        }
      }
    }
    // 4、排序
    JobRes.sort(function(a, b) {
      if (a.type === b.type) {
        return b.num - a.num;
      }
      return b.type - a.type;
    });
    console.log(JobRes);
    return JobRes;
  }

  async pagingJob(recommendJobData, resumeInfo) {
    const res = [];
    const pageNum = resumeInfo.pageNum;
    const page = resumeInfo.page;
    const pageTotal = recommendJobData.length / pageNum;
    // 1、判断如果前端传来的page小于pageTotal，即提供指定页的数据，否在提供最后一页数据
    if (page < pageTotal) {
      const firstIndex = page * pageNum - pageNum;
      const lastIndex = firstIndex + pageNum - 1;
      for (let i = firstIndex; i <= lastIndex; i++) {
        res.push(recommendJobData[i]);
      }
    } else {
      const firstIndex = recommendJobData.length - 1 - pageNum;
      const lastIndex = recommendJobData.length - 1;
      for (let i = firstIndex; i <= lastIndex; i++) {
        res.push(recommendJobData[i]);
      }
    }
    return res;
  }
}

module.exports = jobService;

// function matchResumeKeyWords(dataTXTs) {
//   const res = [];
//   for (const fields of resumeRule) {
//     const resItem = {
//       matchFields: fields.matchFields,
//       fieldsItemArr: [],
//     };
//     if (fields.matchRuleByOne.length > 0) {
//       matchRuleByOneFun(fields, dataTXTs, resItem);
//     }
//     // if (fields.matchRuleByMore.length > 0) {
//     //   await this.matchRuleByMoreFun(fields, dataTXTs, resItem);
//     // }
//     res.push(resItem);
//   }
//   return res;
// }

// function matchRuleByOneFun(fields, dataTXTs, resItem) {
//   for (const matchOne of fields.matchRuleByOne) {
//     const matchData = new RegExp(matchOne, 'g');
//     const target = dataTXTs.match(matchData);
//     if (target) {
//       const fieldsItem = {
//         name: matchData,
//         num: target.length,
//       };
//       resItem.fieldsItemArr.push(fieldsItem);
//     }
//   }
// }
