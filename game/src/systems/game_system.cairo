#[starknet::interface]
pub trait IGameSystem<T> {
    fn create_game(
        ref self: T, matrix_size_x: u32, matrix_size_y: u32, sheep_count: u32, shepherd: starknet::ContractAddress,
    ) -> u32;
    fn submit_wolf_commitment(ref self: T, game_id: u32, wolf_commitment: u256);
    fn wolf_kill_sheep(ref self: T, game_id: u32, proof: Span<felt252>, sheep_to_kill: u32, new_wolf_commitment: u256);
    fn shepherd_kill_sheep(ref self: T, game_id: u32, proof: Span<felt252>, sheep_to_check: u32);
}

#[dojo::contract]
pub mod game_system {
    use core::num::traits::Zero;
    use dojo::world::IWorldDispatcherTrait;
    use dojo_starter::models::{Cell, Game, GameState, Round, RoundState};

    use dojo_starter::store::StoreTrait;
    use starknet::{ContractAddress, get_caller_address};
    use starknet::{SyscallResultTrait, syscalls};
    use super::IGameSystem;


    const WOLF_KILL_SHEEP_VERIFIER_CLASSHASH: felt252 =
        0x00bb20462f9741231dca2052a0d4b15d1c7c91b3ba0df91cb264e4f9fd5e80cc;
    const SHEPHERD_KILL_SHEEP_VERIFIER_CLASSHASH: felt252 =
        0x00d3aeae1b8937e168ff479f4446608db686e1e8d7597aaaa8d9917f3fdda0c8;

    #[abi(embed_v0)]
    impl GameSystemImpl of IGameSystem<ContractState> {
        fn create_game(
            ref self: ContractState,
            matrix_size_x: u32,
            matrix_size_y: u32,
            sheep_count: u32,
            shepherd: ContractAddress,
        ) -> u32 {
            let mut world = self.world(@"dojo_starter");
            let mut store = StoreTrait::new(ref world);

            let caller = get_caller_address();

            // Input validation
            assert(matrix_size_x > 0 && matrix_size_y > 0, 'Invalid matrix dimensions');
            assert(shepherd.is_non_zero() && shepherd != caller, 'Invalid shepherd address');

            let game_id = world.dispatcher.uuid() + 1;

            // Create game
            store
                .set_game(
                    Game {
                        id: game_id,
                        matrix_size_x: matrix_size_x,
                        matrix_size_y: matrix_size_y,
                        round_count: 0,
                        state: GameState::NotStarted,
                        player_1: caller,
                        player_2: shepherd,
                        shepherd: shepherd,
                        wolf: caller,
                        player_1_score: 0,
                        player_2_score: 0,
                        winner: Zero::zero(),
                    },
                );

            // Create round
            store
                .set_round(
                    Round {
                        game_id: game_id,
                        wolf_commitment: 0,
                        sheep_count: sheep_count,
                        surviving_sheep: sheep_count,
                        state: RoundState::WaitingForWolfCommitment,
                    },
                );

            // Initialize all sheep as alive
            let mut i: u32 = 1;
            while i <= sheep_count {
                store.set_cell(Cell { id: i, is_alive: true });
                i += 1;
            };
            game_id
        }

        fn submit_wolf_commitment(ref self: ContractState, game_id: u32, wolf_commitment: u256) {
            let mut world = self.world(@"dojo_starter");
            let mut store = StoreTrait::new(ref world);

            let caller = get_caller_address();

            // Get game
            let mut game = store.get_game(game_id);
            assert(caller == game.wolf, 'Only wolf can submit commitment');
            assert(game.state == GameState::NotStarted, 'Game already started');
            assert(wolf_commitment != 0, 'Invalid commitment');

            // Get round
            let mut round = store.get_round(game_id);
            assert(round.state == RoundState::WaitingForWolfCommitment, 'not in WaitingForWolfCommitment');

            // Update game
            round.wolf_commitment = wolf_commitment;
            round.state = RoundState::WaitingForSheepToKill;

            store.set_round(round);
        }

        fn wolf_kill_sheep(
            ref self: ContractState, game_id: u32, proof: Span<felt252>, sheep_to_kill: u32, new_wolf_commitment: u256,
        ) {
            let mut world = self.world(@"dojo_starter");
            let mut store = StoreTrait::new(ref world);

            let caller = get_caller_address();

            // Get game
            let mut game = store.get_game(game_id);
            assert(caller == game.wolf, 'Only wolf can kill as wolf');
            assert(game.state == GameState::InProgress, 'Game not in progress');

            // Get round
            let mut round = store.get_round(game_id);
            assert(round.state == RoundState::WaitingForSheepToKill, 'not in WaitingForSheepToKill');

            // Validate sheep number
            assert(sheep_to_kill < 16, 'Invalid sheep number');
            assert(store.get_cell(sheep_to_kill).is_alive, 'Sheep already dead');

            // Create public inputs array [game_id, wolf_commitment, sheep_to_kill]
            let mut res = syscalls::library_call_syscall(
                WOLF_KILL_SHEEP_VERIFIER_CLASSHASH.try_into().unwrap(),
                selector!("verify_ultra_keccak_zk_honk_proof"),
                proof,
            )
                .unwrap_syscall();
            let public_inputs = Serde::<Option<Span<u256>>>::deserialize(ref res).unwrap().expect('Proof is invalid');

            let wolf_commitment = *public_inputs[0];
            let sheep_to_kill_index: u32 = (*public_inputs[1]).try_into().unwrap();

            assert(wolf_commitment == round.wolf_commitment, 'Invalid wolf commitment');
            assert(sheep_to_kill_index == sheep_to_kill, 'Invalid sheep to kill');

            // Update game state
            store.set_cell(Cell { id: sheep_to_kill, is_alive: false });
            round.surviving_sheep -= 1;
            round.wolf_commitment = new_wolf_commitment; // Update wolf commitment

            store.set_round(round);
        }

        fn shepherd_kill_sheep(ref self: ContractState, game_id: u32, proof: Span<felt252>, sheep_to_check: u32) {
            let mut world = self.world(@"dojo_starter");
            let mut store = StoreTrait::new(ref world);

            let caller = get_caller_address();

            // Get game
            let mut game = store.get_game(game_id);
            assert(caller == game.shepherd, 'Only shepherd can kill');
            assert(game.state == GameState::InProgress, 'Game not in progress');

            // Get round
            let mut round = store.get_round(game_id);
            assert(round.state == RoundState::WaitingForSheepToKill, 'not in WaitingForSheepToKill');

            // Validate sheep number
            assert(sheep_to_check < 16, 'Invalid sheep number');
            assert(store.get_cell(sheep_to_check).is_alive, 'Sheep already dead');

            // Create public inputs array [game_id, sheep_to_check, is_wolf]
            let mut res = syscalls::library_call_syscall(
                SHEPHERD_KILL_SHEEP_VERIFIER_CLASSHASH.try_into().unwrap(),
                selector!("verify_ultra_keccak_zk_honk_proof"),
                proof,
            )
                .unwrap_syscall();
            let public_inputs = Serde::<Option<Span<u256>>>::deserialize(ref res).unwrap().expect('Proof is invalid');

            // We don't know if it's the wolf yet - the proof will tell us
            // The verifier verifies that is_wolf is calculated correctly
            let sheep_to_check_index: u32 = (*public_inputs[0]).try_into().unwrap();
            let is_wolf_result: u32 = (*public_inputs[1]).try_into().unwrap();

            assert(sheep_to_check_index == sheep_to_check, 'Invalid sheep to check');

            round.surviving_sheep -= 1;

            // If the sheep was the wolf, end the game
            if is_wolf_result == 1 {
                // Wolf found, game over
                game.state = GameState::Finished;
            } else {
                // Shuffle sheep
                store.set_cell(Cell { id: sheep_to_check, is_alive: false });
                round.surviving_sheep -= 1;
            }
            store.set_game(game);
            store.set_round(round);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {}
}
