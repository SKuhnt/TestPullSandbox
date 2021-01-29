const { jestConfig } = require('@salesforce/sfdx-lwc-jest/config');
module.exports = {
    ...jestConfig,
    // add any custom configurations here
    coverageThreshold: {
        "global": {
          "lines": 80
        }
      }
};