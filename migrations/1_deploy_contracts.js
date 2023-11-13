const BlackList = artifacts.require("BlackList");
const Token = artifacts.require("Token", BlackList.artifacts);

module.exports = async (deployer, network, accounts) => {
  await deployer.deploy(BlackList);
  const blackList = await BlackList.deployed();
  console.log("BlackList deployed @: " + blackList.address);

  await deployer.deploy(Token, "MasterZ Dev Token", "MDT", blackList.address);
  const token = await Token.deployed();
  console.log("Token deployed @: " + token.address);
};
