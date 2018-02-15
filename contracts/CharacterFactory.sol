pragma solidity ^0.4.19;

import "./Ownable.sol";

contract CharacterFactory is Ownable {

    event NewCharacter(uint charId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Character {
      string name;
      uint dna;
      uint32 level;
      uint32 readyTime;
      uint16 winCount;
      uint16 lossCount;
    }

    Character[] public characters;

    mapping (uint => Character) public chars;
    mapping (uint => address) public charToOwner;
    mapping (address => uint) ownerCharCount;

    function _createCharacter(string _name, uint _dna) internal returns (uint) {
        Character memory char = Character(_name, _dna, 1, uint32(now + cooldownTime), 0, 0);
        uint id = characters.push(char) - 1;
        charToOwner[id] = msg.sender;
        ownerCharCount[msg.sender]++;
        chars[id] = char;
        NewCharacter(id, _name, _dna);

        return id;
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomCharacter(string _name) public returns (uint) {
        //require(ownerCharCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        return uint(_createCharacter(_name, randDna));
    }

    function getCharacter(uint _id) public view returns (string) {

        return chars[_id].name;
    }

}
