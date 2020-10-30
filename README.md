# swap.pet-oracle
Price Oracle of Swap.Pet, support SwapPet/Uniswap/SushiSwap/ChainLink ...

# Summary
Price Oracle of Swap.Pet include price refer and swap. 

the swapper is for swap the target base token to quote token at realtime.

on Swap.Pet, default quote token is pUSDT(pegging USDT).

# Design Goals
Goals of this new architecture are:
1. swap more than refer.
1. Scalability.
1. Reduce costs by minimizing number of ethereum transactions and operations performed on-chain.
1. Increase reliability during periods of network congestion
1. Reduce latency to react to price changes 

# Architecture
Currently two main modules:
1. [refer]:refer price of market.
2. [swapper]:the price which can swap on at realtime.

# network
## Mainnet
## Kovan
## ropsten

# Query Oracle Contracts

# Installation Instructions
in app dir:`$ npx npm i swap-pet-price-oracle`

in sol file:`import "swap-pet-price-oracle/contracts/SwapPetOracle.sol";`

# create workflow
```
mkdir ~/defiApp
cd defiApp
npm init
npm install --save-dev hardhat
npm install --save-dev @nomiclabs/hardhat-truffle5 @nomiclabs/hardhat-web3 web3
```
edit config:`$ vi hardhat.config.js`  

add gas-reporter:`$ npx npm install -D eth-gas-reporter`
get gas report:`$ npx truffle test`
add coverage:`$ npx npm install -D @nomiclabs/buidler solidity-coverage`
get coverage:`$ npx truffle run coverage`
run ganache :`$ npx ganache-cli --deterministic`
compile:`$ npx hardhat compile`
test:`$ npx hardhat test`
accounts:`$ npx hardhat accounts`
account balance:`$ npx hardhat balance --account 0xFABB0ac...`