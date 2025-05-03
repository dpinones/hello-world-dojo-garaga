#[starknet::interface]
pub trait IGameSystem<T> {
    fn create_game(ref self: T, player_2: starknet::ContractAddress) -> u32;
    fn submit_wolf_commitment(ref self: T, game_id: u32, wolf_commitment: u256);
    fn wolf_kill_sheep(ref self: T, game_id: u32, proof: Span<felt252>, sheep_to_kill: u32, new_wolf_commitment: u256);
    fn shepherd_mark_suspicious(ref self: T, game_id: u32, sheep_to_mark: u32);
    fn check_is_wolf(ref self: T, game_id: u32, proof: Span<felt252>, sheep_to_check: u32);
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
        0x07cf4e898d91e2b094bee27d06d3a610e938aba2ddec143822c6eeccc1637d51;
    const IS_WOLF_VERIFIER_CLASSHASH: felt252 =
        0x009e699bc08c4e82bca81a1f111c9e2b47d09e237980a90bba1412fe59a497ae;

    const MAX_ROUNDS_PER_ROLE: u32 = 3; // 3 rondas como lobo, 3 rondas como pastor
    const TOTAL_ROUNDS: u32 = MAX_ROUNDS_PER_ROLE * 2; // 6 rondas en total por juego
    const SHEEP_COUNT: u32 = 16;

    pub fn DEFAULT_NS() -> ByteArray {
        "wolf_game_zk"
    }

    #[abi(embed_v0)]
    impl GameSystemImpl of IGameSystem<ContractState> {
        fn create_game(ref self: ContractState, player_2: ContractAddress) -> u32 {
            let mut world = self.world(@DEFAULT_NS());
            let mut store = StoreTrait::new(ref world);

            let player_1 = get_caller_address();

            // Input validation
            assert(player_2.is_non_zero() && player_2 != player_1, 'Invalid player_2 address');

            let game_id = world.dispatcher.uuid() + 1;

            // Inicialmente, player_1 es el lobo y player_2 es el pastor
            // Después de 3 rondas, intercambian roles

            // Create game
            store
                .set_game(
                    Game {
                        id: game_id,
                        round_count: 0,
                        state: GameState::NotStarted,
                        player_1: player_1,
                        player_2: player_2,
                        wolf: player_1, // Player 1 comienza como lobo
                        shepherd: player_2, // Player 2 comienza como pastor
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
                        sheep_count: SHEEP_COUNT,
                        surviving_sheep: SHEEP_COUNT,
                        state: RoundState::WaitingForWolfCommitment,
                        suspicious_sheep: 0,
                    },
                );

            // Initialize all sheep as alive and not marked
            let mut i: u32 = 1;
            while i <= SHEEP_COUNT {
                store.set_cell(Cell { id: i, is_alive: true });
                i += 1;
            };
            game_id
        }

        fn submit_wolf_commitment(ref self: ContractState, game_id: u32, wolf_commitment: u256) {
            let mut world = self.world(@DEFAULT_NS());
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
            game.state = GameState::InProgress;

            store.set_round(round);
            store.set_game(game);
        }

        fn wolf_kill_sheep(
            ref self: ContractState, game_id: u32, proof: Span<felt252>, sheep_to_kill: u32, new_wolf_commitment: u256,
        ) {
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
            assert(sheep_to_kill < SHEEP_COUNT, 'Invalid sheep number');
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

            // Incrementar puntuación del lobo actual
            if game.wolf == game.player_1 {
                game.player_1_score += 1;
            } else {
                game.player_2_score += 1;
            }

            store.set_round(round);
            store.set_game(game);
        }

        fn shepherd_mark_suspicious(ref self: ContractState, game_id: u32, sheep_to_mark: u32) {
            let mut world = self.world(@DEFAULT_NS());
            let mut store = StoreTrait::new(ref world);

            let caller = get_caller_address();

            // Get game
            let game = store.get_game(game_id);
            assert(caller == game.shepherd, 'Only shepherd can mark sheep');
            assert(game.state == GameState::InProgress, 'Game not in progress');

            // Get round
            let mut round = store.get_round(game_id);
            assert(round.state == RoundState::WaitingForSheepToKill, 'not in WaitingForSheepToKill');

            // Validate sheep number
            assert(sheep_to_mark < SHEEP_COUNT, 'Invalid sheep number');
            assert(store.get_cell(sheep_to_mark).is_alive, 'Sheep already dead');

            round.state = RoundState::WaitingForWolfResult;
            round.suspicious_sheep = sheep_to_mark;
            store.set_round(round);
        }

        fn check_is_wolf(ref self: ContractState, game_id: u32, proof: Span<felt252>, sheep_to_check: u32) {
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

            // Validate sheep number
            assert(sheep_to_check < SHEEP_COUNT, 'Invalid sheep number');
            assert(store.get_cell(sheep_to_check).is_alive, 'Sheep already dead');

            // Verificar que la oveja haya sido marcada como sospechosa previamente
            assert(round.suspicious_sheep == sheep_to_check, 'Sheep not marked as suspicious');

            // Create public inputs array [game_id, sheep_to_check, is_wolf]
            let mut res = syscalls::library_call_syscall(
                IS_WOLF_VERIFIER_CLASSHASH.try_into().unwrap(),
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

            // Incrementar puntuación del pastor actual
            if game.shepherd == game.player_1 {
                game.player_1_score += 1;
            } else {
                game.player_2_score += 1;
            }

            // Marcar oveja como muerta
            store.set_cell(Cell { id: sheep_to_check, is_alive: false });
            round.surviving_sheep -= 1;

            // Si mató al lobo, la ronda se completa
            if is_wolf_result == 1 {
                // Incrementar contador de ronda SOLO cuando el pastor encuentra al lobo
                game.round_count += 1;

                // Reiniciar el estado para la nueva ronda
                round.surviving_sheep = 16;
                round.wolf_commitment = 0;
                round.state = RoundState::WaitingForWolfCommitment;
                game.state = GameState::NotStarted;

                // Si se han completado 3 rondas, intercambiar roles
                if game.round_count == MAX_ROUNDS_PER_ROLE {
                    // Intercambiar roles después de 3 rondas
                    let temp = game.wolf;
                    game.wolf = game.shepherd;
                    game.shepherd = temp;
                }

                // Si se completaron todas las rondas (6), finalizar el juego
                if game.round_count == TOTAL_ROUNDS {
                    game.state = GameState::Finished;

                    // Determinar ganador
                    if game.player_1_score > game.player_2_score {
                        game.winner = game.player_1;
                    } else if game.player_2_score > game.player_1_score {
                        game.winner = game.player_2;
                    } else {
                        // Empate
                        game.winner = Zero::zero();
                    }
                }

                // Reset: Limpiar todas las marcas de oveja sospechosa para la nueva ronda
                let mut i: u32 = 1;
                while i <= SHEEP_COUNT {
                    store.set_cell(Cell { id: i, is_alive: true });
                    i += 1;
                };
            }

            store.set_game(game);
            store.set_round(round);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {}
}
