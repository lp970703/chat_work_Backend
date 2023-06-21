'use strict';

module.exports = {
  baseResponse: {
    errorMessage: { type: 'string', required: false },
    status: { type: 'string', enum: [ 'validateParamsError', 'error', 'ok' ], required: true },
    success: { type: 'boolean', required: true },
    data: { type: 'object', required: false },
  },
};
