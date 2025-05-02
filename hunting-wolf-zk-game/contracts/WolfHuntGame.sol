// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IWolfKillSheep.sol";
import "./IShepherdKillSheep.sol";

/**
 * @title WolfHuntGame
 * @dev A ZK game where a wolf hides among sheep and the shepherd tries to find it
 */
contract WolfHuntGame {
    // Game states
    enum GameState {
        NotStarted,
        InProgress,
        Finished
    }

    // Structure to represent the game board and state
    struct Game {
        uint256 id;
        uint256 matrixSizeX;
        uint256 matrixSizeY;
        uint256 sheepCount;
        mapping(uint256 => bool) aliveSheep;
        mapping(uint256 => uint256) sheepPositions; // Maps sheep number to position
        bytes32 wolfCommitment; // H(wolfSheepNumber, wolfSalt)
        uint256 round;
        address shepherd;
        address wolf;
        GameState state;
        uint256 survivingSheep;
    }

    // Verifier contracts
    IWolfKillSheep public wolfKillSheepVerifier;
    IShepherdKillSheep public shepherdKillSheepVerifier;

    // Game storage
    mapping(uint256 => Game) public games;
    uint256 public nextGameId;

    // Events
    event GameCreated(uint256 indexed gameId, address indexed wolf, address indexed shepherd, uint256 matrixSizeX, uint256 matrixSizeY, uint256 sheepCount);
    event WolfCommitmentSubmitted(uint256 indexed gameId, bytes32 commitment);
    event SheepKilled(uint256 indexed gameId, uint256 sheepNumber, address killer);
    event WolfFound(uint256 indexed gameId, uint256 sheepNumber);
    event GameFinished(uint256 indexed gameId, uint256 survivingSheep, address winner);
    event SheepShuffled(uint256 indexed gameId);

    /**
     * @dev Constructor that initializes the verifier contracts
     * @param _wolfKillSheepVerifier Address of the wolfKillSheep verifier
     * @param _shepherdKillSheepVerifier Address of the shepherdKillSheep verifier
     */
    constructor(address _wolfKillSheepVerifier, address _shepherdKillSheepVerifier) {
        wolfKillSheepVerifier = IWolfKillSheep(_wolfKillSheepVerifier);
        shepherdKillSheepVerifier = IShepherdKillSheep(_shepherdKillSheepVerifier);
    }

    /**
     * @dev Creates a new game
     * @param _matrixSizeX X dimension of the game board
     * @param _matrixSizeY Y dimension of the game board
     * @param _sheepCount Number of sheep in the game
     * @param _shepherd Address of the shepherd player
     */
    function createGame(
        uint256 _matrixSizeX,
        uint256 _matrixSizeY,
        uint256 _sheepCount,
        address _shepherd
    ) external {
        require(_matrixSizeX > 0 && _matrixSizeY > 0, "Invalid matrix dimensions");
        require(_sheepCount > 0 && _sheepCount <= _matrixSizeX * _matrixSizeY, "Invalid sheep count");
        require(_shepherd != address(0) && _shepherd != msg.sender, "Invalid shepherd address");

        uint256 gameId = nextGameId++;
        Game storage game = games[gameId];
        game.id = gameId;
        game.matrixSizeX = _matrixSizeX;
        game.matrixSizeY = _matrixSizeY;
        game.sheepCount = _sheepCount;
        game.shepherd = _shepherd;
        game.wolf = msg.sender;
        game.state = GameState.NotStarted;
        game.round = 0;

        // Initialize all sheep as alive
        for (uint256 i = 1; i <= _sheepCount; i++) {
            game.aliveSheep[i] = true;
            // Initial positions will be set during initialization
        }

        emit GameCreated(gameId, msg.sender, _shepherd, _matrixSizeX, _matrixSizeY, _sheepCount);
    }

    /**
     * @dev Submit the wolf commitment (which sheep is the wolf)
     * @param _gameId ID of the game
     * @param _wolfCommitment Commitment to which sheep is the wolf H(wolfSheepNumber, wolfSalt)
     */
    function submitWolfCommitment(uint256 _gameId, bytes32 _wolfCommitment) external {
        Game storage game = games[_gameId];
        require(msg.sender == game.wolf, "Only wolf can submit commitment");
        require(game.state == GameState.NotStarted, "Game already started");
        require(_wolfCommitment != bytes32(0), "Invalid commitment");

        game.wolfCommitment = _wolfCommitment;
        game.state = GameState.InProgress;
        game.survivingSheep = game.sheepCount;

        // Initialize random sheep positions
        initializeRandomPositions(_gameId);

        emit WolfCommitmentSubmitted(_gameId, _wolfCommitment);
    }

    /**
     * @dev Initialize random positions for all sheep
     * @param _gameId ID of the game
     */
    function initializeRandomPositions(uint256 _gameId) internal {
        Game storage game = games[_gameId];
        
        // Use a simple deterministic but unpredictable scheme for initial positions
        // In a production game, you'd use a more sophisticated randomness source
        uint256 randomSeed = uint256(keccak256(abi.encodePacked(block.timestamp, blockhash(block.number - 1), game.id)));
        
        for (uint256 i = 1; i <= game.sheepCount; i++) {
            // Assign a unique position to each sheep
            uint256 position = uint256(keccak256(abi.encodePacked(randomSeed, i))) % (game.matrixSizeX * game.matrixSizeY);
            game.sheepPositions[i] = position;
        }
    }

    /**
     * @dev Wolf kills a sheep - verifies proof that the kill is valid
     * @param _gameId ID of the game
     * @param _proof ZK proof from the wolfKillSheep circuit
     * @param _publicInputs Public inputs for the ZK proof
     */
    function wolfKillSheep(
        uint256 _gameId,
        bytes memory _proof,
        uint256[] memory _publicInputs
    ) external {
        Game storage game = games[_gameId];
        require(msg.sender == game.wolf, "Only wolf can kill as wolf");
        require(game.state == GameState.InProgress, "Game not in progress");

        // Verify that the public inputs match the expected format
        // [0]: game ID
        // [1]: wolfCommitment
        // [2]: sheep to kill
        require(_publicInputs.length == 3, "Invalid public inputs length");
        require(_publicInputs[0] == _gameId, "Game ID mismatch");
        require(bytes32(_publicInputs[1]) == game.wolfCommitment, "Wolf commitment mismatch");
        
        uint256 sheepToKill = _publicInputs[2];
        require(sheepToKill > 0 && sheepToKill <= game.sheepCount, "Invalid sheep number");
        require(game.aliveSheep[sheepToKill], "Sheep already dead");

        // Verify the ZK proof
        require(wolfKillSheepVerifier.verify(_proof, _publicInputs), "Invalid proof");

        // Kill the sheep
        game.aliveSheep[sheepToKill] = false;
        game.survivingSheep--;

        emit SheepKilled(_gameId, sheepToKill, msg.sender);
        
        // After wolf's turn, shuffle the sheep
        shuffleSheep(_gameId);
    }

    /**
     * @dev Shepherd checks if a sheep is the wolf - verifies proof
     * @param _gameId ID of the game
     * @param _proof ZK proof from the shepherdKillSheep circuit
     * @param _publicInputs Public inputs for the ZK proof
     */
    function shepherdKillSheep(
        uint256 _gameId,
        bytes memory _proof,
        uint256[] memory _publicInputs
    ) external {
        Game storage game = games[_gameId];
        require(msg.sender == game.shepherd, "Only shepherd can kill as shepherd");
        require(game.state == GameState.InProgress, "Game not in progress");

        // Verify that the public inputs match the expected format
        // [0]: game ID
        // [1]: sheep to check
        // [2]: is wolf (0 = not wolf, 1 = is wolf)
        require(_publicInputs.length == 3, "Invalid public inputs length");
        require(_publicInputs[0] == _gameId, "Game ID mismatch");
        
        uint256 sheepToCheck = _publicInputs[1];
        uint256 isWolf = _publicInputs[2];
        
        require(sheepToCheck > 0 && sheepToCheck <= game.sheepCount, "Invalid sheep number");
        require(game.aliveSheep[sheepToCheck], "Sheep already dead");
        require(isWolf == 0 || isWolf == 1, "isWolf must be 0 or 1");

        // Verify the ZK proof
        require(shepherdKillSheepVerifier.verify(_proof, _publicInputs), "Invalid proof");

        // Kill the sheep
        game.aliveSheep[sheepToCheck] = false;
        game.survivingSheep--;

        emit SheepKilled(_gameId, sheepToCheck, msg.sender);

        // If the sheep was the wolf, end the game
        if (isWolf == 1) {
            game.state = GameState.Finished;
            emit WolfFound(_gameId, sheepToCheck);
            emit GameFinished(_gameId, game.survivingSheep, game.shepherd);
        } else {
            // After shepherd's turn, shuffle the sheep
            shuffleSheep(_gameId);
        }
    }

    /**
     * @dev Shuffle the sheep positions
     * @param _gameId ID of the game
     */
    function shuffleSheep(uint256 _gameId) internal {
        Game storage game = games[_gameId];
        
        // Use a simple deterministic but unpredictable scheme for shuffling
        // In a production game, you'd use a more sophisticated randomness source
        uint256 randomSeed = uint256(keccak256(abi.encodePacked(block.timestamp, blockhash(block.number - 1), game.round)));
        
        // Only shuffle alive sheep
        for (uint256 i = 1; i <= game.sheepCount; i++) {
            if (game.aliveSheep[i]) {
                // Assign a new position to each alive sheep
                uint256 position = uint256(keccak256(abi.encodePacked(randomSeed, i))) % (game.matrixSizeX * game.matrixSizeY);
                game.sheepPositions[i] = position;
            }
        }
        
        game.round++;
        emit SheepShuffled(_gameId);
    }

    /**
     * @dev Get alive sheep for a game
     * @param _gameId ID of the game
     * @return An array of sheep numbers that are still alive
     */
    function getAliveSheep(uint256 _gameId) external view returns (uint256[] memory) {
        Game storage game = games[_gameId];
        uint256[] memory aliveSheepArray = new uint256[](game.survivingSheep);
        
        uint256 index = 0;
        for (uint256 i = 1; i <= game.sheepCount; i++) {
            if (game.aliveSheep[i]) {
                aliveSheepArray[index] = i;
                index++;
            }
        }
        
        return aliveSheepArray;
    }

    /**
     * @dev Get the position of a sheep
     * @param _gameId ID of the game
     * @param _sheepNumber Number of the sheep
     * @return Position of the sheep (row * matrixSizeX + column)
     */
    function getSheepPosition(uint256 _gameId, uint256 _sheepNumber) external view returns (uint256) {
        Game storage game = games[_gameId];
        require(_sheepNumber > 0 && _sheepNumber <= game.sheepCount, "Invalid sheep number");
        
        return game.sheepPositions[_sheepNumber];
    }

    /**
     * @dev Check if a position is adjacent to another
     * @param _pos1 First position
     * @param _pos2 Second position
     * @param _matrixSizeX Width of the matrix
     * @return True if positions are adjacent
     */
    function isAdjacent(uint256 _pos1, uint256 _pos2, uint256 _matrixSizeX) public pure returns (bool) {
        uint256 row1 = _pos1 / _matrixSizeX;
        uint256 col1 = _pos1 % _matrixSizeX;
        uint256 row2 = _pos2 / _matrixSizeX;
        uint256 col2 = _pos2 % _matrixSizeX;
        
        // Check if positions are adjacent (horizontally, vertically, or diagonally)
        int256 rowDiff = int256(row1) - int256(row2);
        int256 colDiff = int256(col1) - int256(col2);
        
        // Manhattan distance == 1 means adjacent horizontally or vertically
        if ((rowDiff == 0 && (colDiff == 1 || colDiff == -1)) || 
            (colDiff == 0 && (rowDiff == 1 || rowDiff == -1))) {
            return true;
        }
        
        return false;
    }

    /**
     * @dev Get the current state of a game
     * @param _gameId ID of the game
     * @return The current game state
     */
    function getGameState(uint256 _gameId) external view returns (
        address wolf,
        address shepherd,
        uint256 matrixSizeX,
        uint256 matrixSizeY,
        uint256 sheepCount,
        uint256 survivingSheep,
        uint256 round,
        GameState state
    ) {
        Game storage game = games[_gameId];
        return (
            game.wolf,
            game.shepherd,
            game.matrixSizeX,
            game.matrixSizeY,
            game.sheepCount,
            game.survivingSheep,
            game.round,
            game.state
        );
    }
} 