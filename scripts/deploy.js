const { ethers } = require("hardhat");

async function main() {
  const args = {
    gasPrice: "0xB2D05E00", // 3 Gwei
  };

  const owner = "0xEC5DBFed2e8A5E88De2AC7a9E5884B0bD4F6Ca7f"; // bigBagBoogy

  console.log("deploying LuksoCloneX...");
  const LuksoCloneX = await ethers.getContractFactory("LuksoCloneX");
  const luksoCloneX = await LuksoCloneX.deploy(owner, args);
  await luksoCloneX.deployed();
  console.log("LuksoCloneX deployed to:", luksoCloneX.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
