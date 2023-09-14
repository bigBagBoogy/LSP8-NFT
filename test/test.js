const { expect } = require("chai");
const { ethers } = require("hardhat"); // If you're using Hardhat
const { ContractFactory, utils } = ethers;

describe("LuksoCloneX", function () {
  let luksoCloneX;

  beforeEach(async function () {
    const LuksoCloneX = await ethers.getContractFactory("LuksoCloneX");
    luksoCloneX = await LuksoCloneX.deploy(/* constructor arguments here */);
    await luksoCloneX.deployed();
  });

  it("should deploy the contract", async function () {
    expect(luksoCloneX.address).to.not.equal(0);
  });

  // Write more test cases here
});
it("should allow public minting", async function () {
  const [alice] = await ethers.getSigners();
  const amountToMint = 1;

  await expect(() =>
    luksoCloneX.publicMint(alice.address, amountToMint, true)
  ).to.changeEtherBalance(alice, -PUBLIC_PRICE_PER_TOKEN * amountToMint);

  const balance = await luksoCloneX.balanceOf(alice.address);
  expect(balance).to.equal(amountToMint);
});
