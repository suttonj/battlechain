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
        uint8 dexterity,
        uint8 strength,
        uint8 vitality,
        uint8 luck,
    }

    Character[] public characters;
    //address[16] public owners;

    //mapping (uint => Character) public chars;
    mapping (uint => address) public charToOwner;
    mapping (address => uint) ownerCharCount;

    function _createCharacter(string _name, uint _dna) internal returns (uint) {
        Character memory char = Character(_name, _dna, 1, uint32(now + cooldownTime), 0, 0, 3,2,3,1);
        uint id = characters.push(char) - 1;
        //chars[id] = char;

        charToOwner[id] = msg.sender;
        //owners[id] = msg.sender;

        ownerCharCount[msg.sender]++;
        
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

    // Retrieving the all characters
    // function getCharacters() external view returns (string memory[]) {
    //     uint len = characters.length;
    //     string[] memory names = new string[];
    //     for (uint i = 0; i < len; i++) {
    //         names[i] = characters[i].name;
    //     }
    //     return names;
    // }

    function getOwners() public view returns (address[16]) {
        address[16] memory owners;
        for (uint i = 0; i < characters.length; i++) {
            owners[i] = charToOwner[i];
        }
        return owners;
    }

    function getOwner(uint id) public constant returns(address) {
        return charToOwner[id];
    }

    function getCharacterCount() public constant returns(uint) {
        return characters.length;
    }

    function getCharacter(uint index) public constant returns(string, uint, uint32, uint32) {
        return (characters[index].name, characters[index].dna, characters[index].level, characters[index].readyTime);
    }
}
