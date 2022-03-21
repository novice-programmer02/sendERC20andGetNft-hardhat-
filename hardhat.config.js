require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",

  defaultNetwork: "local",
  networks: {
    // ropsten: {
    //   url:`https://eth-ropsten.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
    //   accounts:[`${ROPSTEN_PRIVATE_KEY}`]
    // },

    hardhat: {
    },

    local: {
      url: "HTTP://127.0.0.1:7545",
      // accounts: [privateKey1, privateKey2],
    }
  },
};
