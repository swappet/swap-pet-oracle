require('@nomiclabs/hardhat-truffle5');

// in porting
require('solidity-coverage'); 
require('buidler-gas-reporter'); 

const fs = require('fs');
const path = require('path'); 
const infuraKey = fs.readFileSync(path.resolve(__dirname, '.infuraKey')).toString().trim(); 
// You have to export an object to set up your config
// This object can have the following optional entries:
// defaultNetwork, networks, solc, and paths.
// Go to https://buidler.dev/config/ to learn more 
module.exports = {
  defaultNetwork: 'hardhat',  
  networks: {
    hardhat: {},
    buidlerevm: {},
    coverage: {
      url: 'http://127.0.0.1:8555',
    },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${infuraKey}`,
      accounts: ['privateKey1', 'privateKey2']
    },
  },
  solc: {
    version: '0.7.0',
    settings: {
      optimizer: {
        enabled: true,
        runs: 20000
      }
    } 
  },
  gasReporter: {
    enabled: true,
  },
  paths: {
    sources: './contracts',
    tests: './test',
    cache: './cache',
    coverage: './coverage',
    coverageJson: './coverage.json',
    artifacts: './artifacts',
  },
};

