// We require the Buidler Runtime Environment explicitly here. This is optional 
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `buidler run <script>` you'll find the Buidler
// Runtime Environment's members available in the global scope.
const bre = require("@nomiclabs/buidler");

async function main() {
  // Buidler always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile 
  // manually to make sure everything is compiled
  // await bre.run('compile');

  // We get the contract to deploy
  const SwapPetOracle = await bre.ethers.getContract("SwapPetOracle");
  // pass constructor arguments into deploy()
  const swapPetOracle = await SwapPetOracle.deploy("Hello, Buidler!");
  console.log("SwapPetOracle deployed to:", swapPetOracle.address);
  console.log("SwapPetOracle deploy hash:", contract.deployTransaction.hash);

  // The contract is NOT deployed yet; we must wait until it is mined
  await swapPetOracle.deployed();

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
// $ npx buidler run --network rinkeby scripts/deploy.js 
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
