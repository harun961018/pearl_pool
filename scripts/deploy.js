// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const _feeStrate =     "0x25590E925E429894729b90e394Ee2D28496e4bD7";
  const _WETH =          "0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9";
  const _swapRouter =    "0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9";
  const _pairFactory =   "0x909a147253aed297048bE490fAe75087e8feAE65";
  const _ledger =        "0xF3a1B24afbC6D3587cF777019D152817Ea08e017";
  const _router =        "0xa71DD3813E1495C7D6fABbe17Ff230a36e443827";
  const _reward =        "0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9";
  // const LCPoolAVv3Ledger = await hre.ethers.deployContract("LCPoolAVv3Ledger", [_feeStrate]);
  const test = await hre.ethers.deployContract("test", [_reward, _pairFactory, _router]);
}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

