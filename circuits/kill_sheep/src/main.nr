// Circuit for validating wolf kills a sheep
// Verifies:
// 1. The wolf identity is valid (matches the commitment)
// 2. The sheep to kill is adjacent to the wolf
// 3. The sheep to kill is alive

use std::hash::poseidon;

fn main(
    wolf_value: Field, // 5
    wolf_index: Field, // 4
    wolf_salt: Field, // 0
    sheep_positions: [Field; 16],
    sheep_alive: [bool; 16],

    wolf_commitment: pub Field,
    sheep_to_kill_index: pub Field, // 0
) {
    // Verify that the wolf commitment is valid
    assert(poseidon::bn254::hash_2([wolf_value, wolf_salt]) == wolf_commitment);

    // Verify that the wolf is in the correct position
    assert(sheep_positions[wolf_index as u64] == wolf_value);

    // Verify that the sheep to kill is alive
    assert(sheep_alive[sheep_to_kill_index as u64] == true);

    // Calculate row and column for wolf and sheep
    let wolf_position_as_u64 = wolf_index as u64;
    let wolf_row = wolf_position_as_u64 / 4;
    let wolf_col = wolf_position_as_u64 % 4;
    
    let sheep_position_as_u64 = sheep_to_kill_index as u64;
    let sheep_row = sheep_position_as_u64 / 4;
    let sheep_col = sheep_position_as_u64 % 4;
    
    // Calculate absolute differences for adjacency check
    let row_diff: u64 = if wolf_row > sheep_row { 
        wolf_row - sheep_row 
    } else { 
        sheep_row - wolf_row 
    };
    
    let col_diff: u64 = if wolf_col > sheep_col { 
        wolf_col - sheep_col 
    } else { 
        sheep_col - wolf_col 
    };
    
    // Check if positions are adjacent (horizontally, vertically, or diagonally)
    // Allow movement in 8 directions (horizontal, vertical, and diagonal)
    // Maximum row and column difference should be 1, and they can't both be 0
    assert(row_diff <= 1);
    assert(col_diff <= 1);
    assert(row_diff + col_diff > 0); // Ensure they're not the same position
} 
