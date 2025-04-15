use std::hash::poseidon2::Poseidon2::hash;

fn main(
    current_x: Field,
    current_y: Field,
    salt: Field,
) {
    let prev_hash = hash([current_x, current_y, salt], 3);
    std::println("Public leaf:");
    std::println(prev_hash);
}
