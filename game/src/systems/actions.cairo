#[starknet::interface]
pub trait IActions<T> {
    fn spawn(ref self: T, game_id: u32, position_commitment: felt252);
    fn move(ref self: T, game_id: u32, proof: Span<felt252>, new_position_commitment: felt252);
}

#[dojo::contract]
pub mod actions {
    use super::IActions;
    use dojo_starter_zk::models::{Game, Player};
    use starknet::{ContractAddress, get_caller_address};
    use dojo::model::{ModelStorage};
    use dojo_starter_zk::utils::constants::VERIFIER_ADDRESS_TESTNET;
    use dojo_starter_zk::interfaces::verifier::{IUltraKeccakZKHonkVerifierDispatcher, IUltraKeccakZKHonkVerifierDispatcherTrait};

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(ref self: ContractState, game_id: u32, position_commitment: felt252) {
            let mut world = self.world_default();
            let player_address = get_caller_address();

            let mut player: Player = world.read_model(player_address);
            assert(player.position_commitment == 0, 'Player already spawned');
            player.address = player_address;
            player.position_commitment = position_commitment;
            world.write_model(@player);
        }

        fn move(
            ref self: ContractState,
            game_id: u32,
            proof: Span<felt252>,
            new_position_commitment: felt252,
        ) {
            let mut world = self.world_default();
            let player = get_caller_address();

            let mut player: Player = world.read_model(player);
            assert(player.position_commitment != 0, 'Player not spawned');

            // Verificar la prueba ZK
            let verifier = IUltraKeccakZKHonkVerifierDispatcher { contract_address: VERIFIER_ADDRESS_TESTNET() };
            let proof_result = verifier.verify_ultra_keccak_zk_honk_proof(proof);

            player.position_commitment = new_position_commitment;
            world.write_model(@player);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage {
            self.world(@"dojo_starter_zk")
        }
    }
}
