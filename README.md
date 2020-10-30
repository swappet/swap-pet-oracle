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
npm install --save-dev eth-gas-reporter solidity-coverage
`npx ganache-cli --deterministic`
compile:`npx hardhat compile`
test:`npx hardhat test`
coverage:`npx truffle run coverage`

