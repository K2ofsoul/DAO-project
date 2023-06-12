const { ethers } = require("hardhat");

async function main() {
  // Deploying the smart contract
  const Token = await ethers.getContractFactory("GiveIsBlessed");
  const token = await Token.deploy();
  await token.deployed();
  console.log("Token contract deployed to:", token.address);
}

// Running the deployment script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
