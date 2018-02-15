var CharacterFactory = artifacts.require("./CharacterFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(CharacterFactory);
};
