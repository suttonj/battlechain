var CharacterFactory = artifacts.require("CharacterFactory");

contract('CharacterFactory', function(accounts) {
  var factory;
  it('sets the first account as the contract creator', async function() {
    // This give a truffle abstraction which allow us to interact with our contracts.
    const contract = await  CharacterFactory.deployed();

    // Once we have the "contract" we can make calls or transations and then assert.
    // The following is making a call to get the creator.
    const creator = await contract.getCreator();

    assert.equal(creator, accounts[0], 'main account is the creator');
  });

  it("creates a character", async function(done) {
    const characterFactory = await  CharacterFactory.deployed();
    const newCharId = await characterFactory.createRandomCharacter.call('testChar');

    console.log("id = " + newCharId.valueOf());

    const char = await characterFactory.chars.call(newCharId);
    console.log(char.valueOf());
    assert.equal(char.valueOf().name, "testChar", "The new character should be created with the name 'testChar'");

    
  });
});