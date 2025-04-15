# Circuits

## Hash
Vamos a usar el hash de poseidon para generar el commitment de la posición.

1. Primera vez `nargo check`. Es para generar el archivo `Prover.toml`.
2. Después para ejecutar `nargo execute` completar los valores en `Prover.toml`.


## Move
Nuestro jugador va estar oculto y va a hacer movimientos validos, gracias a la prueba ZK.

# 1. Activar el entorno virtual
source venv/bin/activate

# 2. Compilar el circuito
nargo build

# 3. Generar la clave de verificación
bb write_vk --scheme ultra_honk --oracle_hash keccak -b target/hello.json -o target

# 4. Generar el circuito con Garaga
garaga gen --system ultra_keccak_zk_honk --vk target/vk

# 5. Generar el archivo Prover.toml
nargo check

# 6. Ejecutar la prueba ZK
nargo execute witness

# 7. Generar la prueba ZK
bb prove -s ultra_honk --oracle_hash keccak --zk -b target/hello.json -w target/witness.gz -o target/

# 8. Generar el archivo de prueba para Starkli
garaga calldata --system ultra_keccak_zk_honk --proof target/proof --vk target/vk --format starkli > archivo.txt


## Game

// fn spawn(ref self: T, game_id: u32, position_commitment: felt252);

sozo -P sepolia execute actions spawn 1 0x2a5de47ed300af27b706aaa14762fc468f5cfc16cd8116eb6b09b0f2643ca2b9 --wait --world 0x07311515dfd55106a39f79671bde8e0420127ea95e5866dd548f981be0f07fda

//fn move(ref self: T, game_id: u32, proof: Span<felt252>, new_position_commitment: felt252);

sozo -P sepolia execute actions move 1 span new-position-commitment --wait --world 0x07311515dfd55106a39f79671bde8e0420127ea95e5866dd548f981be0f07fda

Deuda
* Por cada commiment generar un salt nuevo