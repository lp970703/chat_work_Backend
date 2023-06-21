'use strict';

class RoleUntil {
  async roleFunction(rule) {
    // ResumeRule为简历匹配关键字的规则
    if (rule === 'ResumeRule') {
      const ResumeRule = [
        {
          matchFields: 'company_name',
          matchRule: {
            '字节跳动': [ '字节', '字节跳动' ],
          },
        },
      ];
      return ResumeRule;
    }
  }
}
module.exports = RoleUntil;
