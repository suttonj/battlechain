var CharacterHelper = artifacts.require("./CharacterHelper.sol");

module.exports = function(deployer) {
  deployer.deploy(CharacterHelper);
};
