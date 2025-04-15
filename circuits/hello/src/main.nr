use std::hash::poseidon2::Poseidon2::hash;

fn check_valid_move(current_x: Field, current_y: Field, new_x: Field, new_y: Field) -> bool {
    let x_diff = new_x - current_x;
    let y_diff = new_y - current_y;
    
    // Verificar que el movimiento sea de maximo 1 unidad en cualquier direccion
    // usando solo restas, comparaciones y logica booleana.
    let one = 1 as Field;
    let neg_one = 0 - one;

    let x_diff_is_valid = (x_diff == 0) | (x_diff == one) | (x_diff == neg_one);
    let y_diff_is_valid = (y_diff == 0) | (y_diff == one) | (y_diff == neg_one);
    
    x_diff_is_valid & y_diff_is_valid
}

fn main(
    current_x: Field,
    current_y: Field,
    new_x: Field,
    new_y: Field,
    salt: Field,
    previous_commitment: pub Field
) {
    assert(check_valid_move(current_x, current_y, new_x, new_y));

    let prev_hash = hash([current_x, current_y, salt], 3);
    assert(prev_hash == previous_commitment);
}
