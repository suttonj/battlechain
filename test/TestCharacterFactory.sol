pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CharacterFactory.sol";

contract TestCharacterFactory {
  	CharacterFactory charFactory = CharacterFactory(DeployedAddresses.CharacterFactory());

  	struct Character {
      string name;
      uint dna;
      uint32 level;
      uint32 readyTime;
      uint16 winCount;
      uint16 lossCount;
    }

  	// Testing the createCharacter() function
	function testUserCanCreateCharacter() public {
	  uint returnedId = charFactory.createRandomCharacter("Vagabond");

	  uint expected = 0;

	  Assert.equal(returnedId, expected, "CharacterFactory of char ID 0 should be recorded.");
	}

	// Testing retrieval of a single character's owner
	function testGetOwnerAddressByCharId() public {
	  // Expected owner is this contract
	  address expected = this;

	  address owner = charFactory.getOwner(0);

	  Assert.equal(owner, expected, "Owner of char ID 0 should be recorded.");
	}

	// Testing retrieval of all character owners
	function testGetOwnerAddressByCharIdInArray() public {
	  // Expected owner is this contract
	  address expected = this;

	  // Store adopters in memory rather than contract's storage
	  address[16] memory owners = charFactory.getOwners();

	  Assert.equal(owners[0], expected, "Owner of char ID 0 should be recorded.");
	}

	function testGetCharacterById() public {
		uint id = 0;
		uint dna;
		uint dnaExpected;

		(,dnaExpected,,,,) = charFactory.characters(id);
		(,dna,,) = charFactory.getCharacter(id);

		Assert.equal(dna, dnaExpected, "Character of char ID 0 should have the right name.");
	}
}