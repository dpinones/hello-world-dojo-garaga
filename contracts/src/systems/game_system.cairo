#[starknet::interface]
pub trait IGameSystem<T> {
    fn create_game(ref self: T) -> u32;
    fn join_game(ref self: T, game_id: u32);
    fn submit_wolf_commitment(ref self: T, game_id: u32, wolf_commitment: u256);
    fn wolf_kill_sheep(ref self: T, game_id: u32, sheep_to_kill_index: u32);
    // fn wolf_kill_sheep(ref self: T, game_id: u32, proof: Span<felt252>, sheep_to_kill_index: u32);
    fn shepherd_mark_suspicious(ref self: T, game_id: u32, sheep_to_mark_index: u32);
    fn check_is_wolf(ref self: T, game_id: u32);
    // fn check_is_wolf(ref self: T, game_id: u32, proof: Span<felt252>);
}

#[dojo::contract]
pub mod game_system {
    use dojo::event::EventStorage;
    use dojo::world::IWorldDispatcherTrait;
    use dojo_starter::models::{Cell, CreateGameEvent, Game, GameState, Round, RoundState};

    use dojo_starter::store::StoreTrait;
    use dojo_starter::utils::random;
    use dojo_starter::utils::shuffle;
    use starknet::get_caller_address;
    use starknet::{SyscallResultTrait, syscalls};
    use super::IGameSystem;
    const WOLF_KILL_SHEEP_VERIFIER_CLASSHASH: felt252 =
        0x04547e3540e6280c3df545cc1ae63c593900ec9e8232dff9a64f35a05330b189;
    const IS_WOLF_VERIFIER_CLASSHASH: felt252 = 0x0674595b48f3d6983187fa6a2f435d70420a05696723077474126d4d8bfb46eb;

    const MAX_ROUNDS_PER_ROLE: u32 = 3; // 3 rondas como lobo, 3 rondas como pastor
    const TOTAL_ROUNDS: u32 = MAX_ROUNDS_PER_ROLE * 2; // 6 rondas en total por juego
    const SHEEP_COUNT: u32 = 16;

    pub fn DEFAULT_NS() -> ByteArray {
        "dojo_starter"
    }

    #[abi(embed_v0)]
    impl GameSystemImpl of IGameSystem<ContractState> {
        fn create_game(ref self: ContractState) -> u32 {
            let mut world = self.world(@DEFAULT_NS());
            let mut store = StoreTrait::new(ref world);

            let player_1 = get_caller_address();
            // Initialize player_2 as zero address
            let player_2 = Zeroable::zero();

            let game_id = world.dispatcher.uuid() + 1;

            // Create game with WaitingForPlayer2 state
            store
                .set_game(
                    Game {
                        id: game_id,
                        round_count: 1,
                        state: GameState::WaitingForPlayer2,
                        player_1: player_1,
                        player_2: player_2,
                        wolf: player_1, // Player 1 comienza como lobo
                        shepherd: Zeroable::zero(), // Shepherd will be set when player 2 joins
                        player_1_score: 0,
                        player_2_score: 0,
                        winner: Zeroable::zero(),
                    },
                );

            // Create round
            store
                .set_round(
                    Round {
                        game_id: game_id,
                        wolf_commitment: 0,
                        surviving_sheep: SHEEP_COUNT,
                        state: RoundState::WaitingForWolfCommitment,
                        suspicious_sheep_index: 999,
                        current_turn: player_1 // Initial turn is wolf's (player_1)
                    },
                );

            // Initialize all sheep as alive and not marked
            let mut i: u32 = 0;
            while i < SHEEP_COUNT {
                store.set_cell(Cell { game_id: game_id, idx: i, value: i + 1, is_alive: true });
                i += 1;
            };

            world.emit_event(@CreateGameEvent { player: get_caller_address(), game_id });

            game_id
        }

        fn join_game(ref self: ContractState, game_id: u32) {
            let mut world = self.world(@DEFAULT_NS());
            let mut store = StoreTrait::new(ref world);

            let player_2 = get_caller_address();

            // Get game
            let mut game = store.get_game(game_id);

            // Validations
            assert(game.state == GameState::WaitingForPlayer2, 'Game not waiting for player 2');
            // assert(player_2 != game.player_1, 'Cannot join your own game');
            assert(!player_2.is_zero(), 'Invalid player_2 address');

            // Get round
            let mut round = store.get_round(game_id);

            // Update game
            game.player_2 = player_2;
            game.shepherd = player_2; // Player 2 starts as shepherd
            game.state = GameState::InProgress; // Game starts immediately in InProgress

            round.state = RoundState::WaitingForWolfCommitment;
            round.current_turn = game.wolf; // Set initial turn to Wolf player

            store.set_game(game);
            store.set_round(round);
        }

        fn submit_wolf_commitment(ref self: ContractState, game_id: u32, wolf_commitment: u256) {
            let mut world = self.world(@DEFAULT_NS());
            let mut store = StoreTrait::new(ref world);

            let caller = get_caller_address();

            // Get game
            let mut game = store.get_game(game_id);
            assert(caller == game.wolf, 'Only wolf can submit commitment');
            assert(game.state == GameState::InProgress, 'Game not ready for commitment');
            assert(wolf_commitment != 0, 'Invalid commitment');

            // Get round
            let mut round = store.get_round(game_id);
            assert(round.state == RoundState::WaitingForWolfCommitment, 'not in WaitingForWolfCommitment');

            // Update game
            round.wolf_commitment = wolf_commitment;
            round.state = RoundState::WaitingForSheepToKill;
            game.state = GameState::InProgress;

            store.set_round(round);
            store.set_game(game);
        }

        // fn wolf_kill_sheep(ref self: ContractState, game_id: u32, proof: Span<felt252>, sheep_to_kill_index: u32) {
        fn wolf_kill_sheep(ref self: ContractState, game_id: u32, sheep_to_kill_index: u32) {
            let mut world = self.world(@DEFAULT_NS());
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
            assert(sheep_to_kill_index < SHEEP_COUNT, 'Invalid sheep number');
            assert(store.get_cell(game_id, sheep_to_kill_index).is_alive, 'Sheep already dead');

            // Create public inputs array [game_id, wolf_commitment, sheep_to_kill]
            // let mut res = syscalls::library_call_syscall(
            //     WOLF_KILL_SHEEP_VERIFIER_CLASSHASH.try_into().unwrap(),
            //     selector!("verify_ultra_keccak_zk_honk_proof"),
            //     proof,
            // )
            //     .unwrap_syscall();
            // let public_inputs = Serde::<Option<Span<u256>>>::deserialize(ref res).unwrap().expect('Proof is
            // invalid');

            // let wolf_commitment = *public_inputs[0];
            // let sheep_to_kill_index: u32 = (*public_inputs[1]).try_into().unwrap();

            // TODO: remove this
            let wolf_commitment = round.wolf_commitment;
            let sheep_to_kill_index = sheep_to_kill_index;

            assert(wolf_commitment == round.wolf_commitment, 'Invalid wolf commitment');
            assert(sheep_to_kill_index == sheep_to_kill_index, 'Invalid sheep to kill');

            // Update game state
            let mut sheep_to_kill = store.get_cell(game_id, sheep_to_kill_index);
            sheep_to_kill.is_alive = false;
            store.set_cell(sheep_to_kill);
            round.surviving_sheep -= 1;

            // Incrementar puntuación del lobo actual
            if game.wolf == game.player_1 {
                game.player_1_score += 100;
            } else {
                game.player_2_score += 100;
            }

            // Change turn to Shepherd
            round.current_turn = game.shepherd;
            round.state = RoundState::WaitingForWolfSelection;

            store.set_round(round);
            store.set_game(game);
        }

        fn shepherd_mark_suspicious(ref self: ContractState, game_id: u32, sheep_to_mark_index: u32) {
            let mut world = self.world(@DEFAULT_NS());
            let mut store = StoreTrait::new(ref world);

            let caller = get_caller_address();

            // Get game
            let game = store.get_game(game_id);
            assert(caller == game.shepherd, 'Only shepherd can mark sheep');
            assert(game.state == GameState::InProgress, 'Game not in progress');

            // Get round
            let mut round = store.get_round(game_id);
            assert(round.state == RoundState::WaitingForWolfSelection, 'not in WaitingForWolfSelection');
            assert(round.current_turn == game.shepherd, 'Not shepherd turn');

            // Validate sheep number
            assert(sheep_to_mark_index < SHEEP_COUNT, 'Invalid sheep number');
            assert(store.get_cell(game_id, sheep_to_mark_index).is_alive, 'Sheep already dead');

            round.state = RoundState::WaitingForWolfResult;
            round.suspicious_sheep_index = sheep_to_mark_index;
            round.current_turn = game.wolf; // Set turn back to Wolf player for result

            store.set_round(round);
        }

        // fn check_is_wolf(ref self: ContractState, game_id: u32, proof: Span<felt252>) {
        fn check_is_wolf(ref self: ContractState, game_id: u32) {
            let mut world = self.world(@DEFAULT_NS());
            let mut store = StoreTrait::new(ref world);

            let caller = get_caller_address();

            // Get game
            let mut game = store.get_game(game_id);
            assert(caller == game.wolf, 'Only wolf can check if is wolf');
            assert(game.state == GameState::InProgress, 'Game not in progress');

            // Get round
            let mut round = store.get_round(game_id);
            assert(round.state == RoundState::WaitingForWolfResult, 'not in WaitingForWolfResult');
            assert(round.current_turn == game.wolf, 'Not wolf turn');

            // Verificar que la oveja haya sido marcada como sospechosa previamente
            assert(round.suspicious_sheep_index != 999, 'Sheep not marked as suspicious');

            // Validate sheep number
            assert(round.suspicious_sheep_index < SHEEP_COUNT, 'Invalid sheep number');
            assert(store.get_cell(game_id, round.suspicious_sheep_index).is_alive, 'Sheep already dead');

            // // Create public inputs array [game_id, sheep_to_check, is_wolf]
            // let mut res = syscalls::library_call_syscall(
            //     IS_WOLF_VERIFIER_CLASSHASH.try_into().unwrap(),
            //     selector!("verify_ultra_keccak_zk_honk_proof"),
            //     proof,
            // )
            //     .unwrap_syscall();
            // let public_inputs = Serde::<Option<Span<u256>>>::deserialize(ref res).unwrap().expect('Proof is
            // invalid');

            // We don't know if it's the wolf yet - the proof will tell us
            // The verifier verifies that is_wolf is calculated correctly
            // let wolf_commitment = *public_inputs[0];
            // let sheep_to_check_index: u32 = (*public_inputs[1]).try_into().unwrap();
            // let is_wolf_result: u32 = (*public_inputs[2]).try_into().unwrap();

            // TODO: remove this
            let wolf_commitment = round.wolf_commitment;
            let sheep_to_check_index = round.suspicious_sheep_index;
            let is_wolf_result = if sheep_to_check_index == 1 {
                1
            } else {
                0
            };

            assert(wolf_commitment == round.wolf_commitment, 'Invalid wolf commitment');
            assert(sheep_to_check_index == round.suspicious_sheep_index, 'Invalid sheep to check');

            // Si mató al lobo, la ronda se completa
            if is_wolf_result == 1 {
                // Incrementar contador de ronda SOLO cuando el pastor encuentra al lobo
                game.round_count += 1;

                // Reiniciar el estado para la nueva ronda
                round.surviving_sheep = SHEEP_COUNT;
                round.wolf_commitment = 0;
                round.state = RoundState::WaitingForWolfCommitment;
                round.current_turn = game.wolf; // Reset turn to Wolf

                // After 3 rounds, when roles swap, we need to wait for wolf commitment
                if game.round_count == MAX_ROUNDS_PER_ROLE + 1 {
                    // Intercambiar roles después de 3 rondas
                    let temp = game.wolf;
                    game.wolf = game.shepherd;
                    game.shepherd = temp;
                    // Update turn to the new wolf player
                    round.current_turn = game.wolf;
                }

                // Si se completaron todas las rondas (6), finalizar el juego
                if game.round_count == TOTAL_ROUNDS + 1 {
                    game.state = GameState::Finished;

                    // Determinar ganador
                    if game.player_1_score > game.player_2_score {
                        game.winner = game.player_1;
                    } else if game.player_2_score > game.player_1_score {
                        game.winner = game.player_2;
                    } else {
                        // Empate
                        game.winner = Zeroable::zero();
                    }
                }

                // Reset: Limpiar todas las marcas de oveja sospechosa para la nueva ronda
                let mut i: u32 = 0;
                while i < SHEEP_COUNT {
                    store.set_cell(Cell { game_id: game_id, idx: i, value: i + 1, is_alive: true });
                    i += 1;
                };
            } else {
                // Marcar oveja como muerta
                let mut sheep_to_check = store.get_cell(game_id, sheep_to_check_index);
                sheep_to_check.is_alive = false;
                store.set_cell(sheep_to_check);
                round.surviving_sheep -= 1;

                round.state = RoundState::WaitingForSheepToKill;

                let random_hash = random::get_random_hash();
                let seed = random::get_entropy(random_hash);

                let mut sheeps_indexes = array![];
                let mut sheeps_values = array![];
                let mut i: u32 = 0;
                while i < SHEEP_COUNT {
                    if store.get_cell(game_id, i).is_alive {
                        sheeps_indexes.append(i);
                        sheeps_values.append(store.get_cell(game_id, i).value);
                    }
                    i += 1;
                };

                let shuffled_sheep_indexes = shuffle::shuffle(seed, sheeps_indexes.span());
                let mut j: u32 = 0;
                while j < shuffled_sheep_indexes.len() {
                    store
                        .set_cell(
                            Cell {
                                game_id: game_id,
                                idx: *shuffled_sheep_indexes.at(j),
                                value: *sheeps_values.at(j),
                                is_alive: true,
                            },
                        );
                    j += 1;
                };
            }

            store.set_game(game);
            store.set_round(round);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {}
}
