require('@nomiclabs/hardhat-waffle');

module.exports = {
  solidity: "0.8.0",
  networks: {
    localhost: {
      url: "http://localhost:8545" // Update with your local development network URL
    }
  }
  
};

