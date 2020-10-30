# swap.pet-oracle
Price Oracle of Swap.Pet, support SwapPet/Uniswap/SushiSwap/ChainLink ...


# create workflow
## 
mkdir ~/defiApp
cd defiApp
npm init
npm install --save-dev hardhat
npm install --save-dev @nomiclabs/hardhat-truffle5 @nomiclabs/hardhat-web3 web3
vi hardhat.config.js
npm install --save-dev ethers 
npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai

add gas-reporter:`$ npx npm install -D eth-gas-reporter`
get gas report:`$ npx truffle test`
add coverage:`$ npx npm install -D @nomiclabs/buidler solidity-coverage`
get coverage:`$ npx truffle run coverage`
run ganache :`$ npx ganache-cli --deterministic`
compile:`$ npx hardhat compile`
test:`$ npx hardhat test`
accounts:`$ npx hardhat accounts`
account balance:`$ npx hardhat balance --account 0xFABB0ac...`

  