require("@nomicfoundation/hardhat-toolbox");

const INFURA_API_KEY = "40ae0f52bbd04bfa858b67bebe0b8e42";

// Replace this private key with your Sepolia account private key
// To export your private key from Coinbase Wallet, go to
// Settings > Developer Settings > Show private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Beware: NEVER put real Ether into testing accounts
const SEPOLIA_PRIVATE_KEY = "744d18411d6b342fba92515574da5593b6385755de290e8bd5e27f6b141bea0d";

module.exports = {
  // ...rest of your config...
  solidity: {
    version: "0.8.19",
    settings: {
      viaIR: true,
      optimizer: {
        enabled: true,
        runs: 1000,
        details: {
          yulDetails: {
            optimizerSteps: "u",
          },
        },
      },
    },
  },
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY],
    },
    // hardhat: {
    //   forking: {
    //     url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}npx hardhat node --fork `,
    //   }
    // }
  },
  etherscan: {
    apiKey: "3TXXGES3FMQEPY77CGJK9UN9H7BBDMTFNY"
  },
  defaultNetwork: "sepolia",
  viaIR: true,
  optimize: true
};
