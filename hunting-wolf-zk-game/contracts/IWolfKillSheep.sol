// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title IWolfKillSheep
 * @dev Interface for the Wolf Kill Sheep ZK proof verifier
 */
interface IWolfKillSheep {
    /**
     * @dev Verify a zk proof for when the wolf kills a sheep
     * @param proof The zk proof
     * @param publicInputs The public inputs to the proof
     * @return True if the proof is valid
     */
    function verify(bytes memory proof, uint256[] memory publicInputs) external view returns (bool);
} 