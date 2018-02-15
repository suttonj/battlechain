pragma solidity ^0.4.19;

import "./CharacterFactory.sol";

contract CharacterHelper is CharacterFactory {

  uint levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _charId) {
    require(characters[_charId].level >= _level);
    _;
  }

  modifier ownerOf(uint _charId) {
    require(msg.sender == charToOwner[_charId]);
    _;
  }

  function withdraw() external onlyOwner {
    owner.transfer(this.balance);
  }

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function changeName(uint _charId, string _newName) external aboveLevel(2, _charId) ownerOf(_charId) {
    characters[_charId].name = _newName;
  }

  function changeDna(uint _charId, uint _newDna) external aboveLevel(20, _charId) ownerOf(_charId) {
    characters[_charId].dna = _newDna;
  }

  function getCharsByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerCharCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < characters.length; i++) {
      if (charToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}