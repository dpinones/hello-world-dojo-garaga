// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Verifier.sol"; // Importamos el verificador generado por Noir

contract ZKHunt {
    struct Player {
        bool spawned;
        bytes32 positionCommitment; // Compromiso de posición (hash)
        uint lastMoveBlock;         // Para tracking de cuando se movió
    }
    
    // Dimensión del mapa
    uint public constant MAP_WIDTH = 32;
    uint public constant MAP_HEIGHT = 32;
    
    // Lleno de árboles (en una implementación real, esto podría ser un merkle tree)
    bool public constant TREES_EVERYWHERE = true;
    
    // Mappeo de jugadores
    mapping(address => Player) public players;
    
    // Instancia del verificador
    UltraVerifier public verifier;
    
    event PlayerSpawned(address player, bytes32 commitment);
    event PlayerMoved(address player, bytes32 newCommitment);
    
    constructor(address _verifierAddress) {
        verifier = UltraVerifier(_verifierAddress);
    }
    
    // Función para hacer spawn en el mapa
    function spawn(bytes32 positionCommitment) external {
        require(!players[msg.sender].spawned, "Player already spawned");
        
        players[msg.sender] = Player({
            spawned: true,
            positionCommitment: positionCommitment,
            lastMoveBlock: block.number
        });
        
        emit PlayerSpawned(msg.sender, positionCommitment);
    }
    
    // Función para mover con prueba ZK
    function move(bytes calldata proof, bytes32 newPositionCommitment) external {
        require(players[msg.sender].spawned, "Player not spawned");
        
        // Verificar la prueba ZK
        bytes32 previousCommitment = players[msg.sender].positionCommitment;
        
        // Inputs públicos: commitment anterior y nuevo commitment
        bytes32[] memory publicInputs = new bytes32[](2);
        publicInputs[0] = previousCommitment;
        publicInputs[1] = newPositionCommitment;
        
        require(verifier.verify(proof, publicInputs), "Invalid ZK proof");
        
        // Actualizar posición
        players[msg.sender].positionCommitment = newPositionCommitment;
        players[msg.sender].lastMoveBlock = block.number;
        
        emit PlayerMoved(msg.sender, newPositionCommitment);
    }
    
    // Obtener información del jugador
    function getPlayerInfo(address playerAddress) external view returns (bool spawned, bytes32 commitment, uint lastMove) {
        Player memory player = players[playerAddress];
        return (player.spawned, player.positionCommitment, player.lastMoveBlock);
    }
}