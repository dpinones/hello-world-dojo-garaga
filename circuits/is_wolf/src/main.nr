// Circuit for validating when shepherd checks if a sheep is the wolf
// Verifies:
// 1. The sheep is alive
// 2. Whether the sheep is the wolf or not
// Outputs isWolf as 1 if the sheep is the wolf, 0 otherwise

use std::hash::poseidon;

// Main function for the shepherd_kill_sheep circuit
fn main(
    // Private inputs (only for the wolf)
    wolf_index: Field,  // Which sheep is the wolf
    wolf_salt: Field,         // Secret salt for the commitment
    sheep_alive: [bool; 16],  // Alive status of each sheep
    
    // Public inputs
    wolf_commitment: pub Field, // Commitment hash as private input
    sheep_to_check_index: pub Field, // Which sheep to check
    is_wolf_result: pub Field  // Result: 1 if sheep is wolf, 0 if not
) {
    // 1. Verify the wolf commitment is valid
    let computed_commitment = poseidon::bn254::hash_2([wolf_index, wolf_salt]);
    assert(computed_commitment == wolf_commitment);
    
    // 2. Verify the sheep to check is alive
    assert(sheep_alive[sheep_to_check_index as u64]);
    
    // 3. Determine if the sheep is the wolf and verify it matches the public input
    let is_wolf = if wolf_index == sheep_to_check_index { 1 } else { 0 };
    assert(is_wolf == is_wolf_result);
}
