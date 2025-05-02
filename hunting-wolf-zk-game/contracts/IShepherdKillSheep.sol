// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title IShepherdKillSheep
 * @dev Interface for the Shepherd Kill Sheep ZK proof verifier
 */
interface IShepherdKillSheep {
    /**
     * @dev Verify a zk proof for when the shepherd checks if a sheep is the wolf
     * @param proof The zk proof
     * @param publicInputs The public inputs to the proof
     * @return True if the proof is valid
     */
    function verify(bytes memory proof, uint256[] memory publicInputs) external view returns (bool);
} 