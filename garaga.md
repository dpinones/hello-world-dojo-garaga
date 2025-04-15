# TUTORIAL - Crear prueba y poder chequearla con bb

nargo check: crea el archivo Prover.toml, donde se especifican los valores de los parametros.

nargo execute: Compila y ejecuta el programa. Genera el `witness` (?) (código que necesitamos para alimentar a nuestro backend de pruebas)

bb prove -b ./target/hello_world.json -w ./target/hello_world.gz -o ./target : Genera la proof(?)

La prueba ya se genera en la target carpeta. Para verificarla, primero debemos calcular la clave de verificación del circuito compilado y usarla para verificar:

## Generate the verification key and save to ./target/vk
bb write_vk -b ./target/hello_world.json -o ./target

## Verify the proof
bb verify -k ./target/vk -p ./target/proof

--------------------------------------------------------------------------------------------------

# TUTORIAL - Crear prueba y poder chequearla en cairo

source venv/bin/activate

nargo build

bb write_vk --scheme ultra_honk --oracle_hash keccak -b target/move.json -o target

garaga gen --system ultra_keccak_zk_honk --vk target/vk

nargo execute witness

bb prove -s ultra_honk --oracle_hash keccak --zk -b target/move.json -w target/witness.gz -o target/

Al usar garaga calldatacon [insertar código], --format array se puede pegar esta matriz en el código Cairo para pruebas unitarias mediante la ejecución de `let proof:Array<felt252> = [ ... ] ;`. --format starkli Tiene un formato que se puede componer con Starkli en la línea de comandos y también antepone la longitud de la matriz para que Starknet pueda deserializarla.

garaga calldata --system ultra_keccak_zk_honk --proof target/proof --vk target/vk --format starkli > archivo.txt

