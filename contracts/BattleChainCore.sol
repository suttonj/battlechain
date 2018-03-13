/**
 * @title BattleChainCoreBeta
 * @dev Core Contract of BattleChain.
 */
contract BattleChainCore is Destructible {

    /**
     * Initialize the BattleChain contract with all the required contract addresses.
     */
    function BattleChainCore(
        address _monsterFactoryAddress,
        address _characterFactoryAddress,
        address _battleEngineAddress,
    ) public {
        characterFactoryContract = CharacterFactory(_characterFactoryAddress);
        monsterFactoryContract = MonsterFactory(_monsterFactoryAddress);
        battleEngineContract = BattleEngine(_battleEngineAddress);
    }

    /**
     * @dev The external function to get all the relevant information about a specific character by its ID.
     * @param _id The ID of the character.
     */
    function getCharacterDetails(uint _id) external view returns (uint dna, uint32 level, uint32 readyTime, uint wins, uint32 loses) {
        require(_id < characterFactoryContract.characterCount());

        // be careful of Stack Too Deep error.
        (,dna, level, readyTime, wins, loses,,,,,,,,) = characterFactoryContract.getCharacter(_id);

        // Character is ready to be challenged.
        isReady = readyTime <= now;
    }

    /**
     * @param _id The ID of the monster.
     */
    function getMonsterDetails(uint _id) external view returns (uint floorNumber, uint floorCreationTime, uint rewards, uint seedGenes, uint floorGenes) {
        require(_id < monsterFactoryContract.totalSupply());

        (level,,, rewards,,,,) = monsterFactoryContract.getMonster(_id);
    }



}

