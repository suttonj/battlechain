pragma solidity ^0.4.19;

import "./characterhelper.sol";
//import "./commitreveal.sol";

contract Battle is CharacterHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;

  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
  }

  function attack(uint _charId, uint _targetId) external ownerOf(_charId) {
    Character storage myCharacter = characters[_charId];
    Character storage enemyCharacter = characters[_targetId];
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability) {
      myCharacter.winCount++;
      myCharacter.level++;
      enemyCharacter.lossCount++;
    } else {
      myCharacter.lossCount++;
      enemyCharacter.winCount++;
    }
  }
}
