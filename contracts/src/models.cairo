use starknet::{ContractAddress};

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Game {
    #[key]
    pub id: u32,
    pub round_count: u32,
    pub state: GameState,
    pub player_1: ContractAddress,
    pub player_2: ContractAddress,
    pub shepherd: ContractAddress,
    pub wolf: ContractAddress,
    pub player_1_score: u32,
    pub player_2_score: u32,
    pub winner: ContractAddress,
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Round {
    #[key]
    pub game_id: u32,
    pub wolf_commitment: u256,
    pub surviving_sheep: u32,
    pub state: RoundState,
    pub suspicious_sheep_index: u32,
    pub current_turn: ContractAddress,
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Cell {
    #[key]
    pub id: u32,
    pub value: u32,
    pub is_alive: bool,
}

#[derive(Serde, Copy, Drop, IntrospectPacked, PartialEq)]
pub enum GameState {
    WaitingForPlayer2,
    NotStarted,
    InProgress,
    Finished,
}

impl GameStateIntoFelt252 of Into<GameState, felt252> {
    fn into(self: GameState) -> felt252 {
        match self {
            GameState::WaitingForPlayer2 => 0,
            GameState::NotStarted => 1,
            GameState::InProgress => 2,
            GameState::Finished => 3,
        }
    }
}

#[derive(Serde, Copy, Drop, IntrospectPacked, PartialEq)]
pub enum RoundState {
    WaitingForWolfCommitment,
    WaitingForSheepToKill,
    WaitingForWolfSelection,
    WaitingForWolfResult,
}

impl RoundStateIntoFelt252 of Into<RoundState, felt252> {
    fn into(self: RoundState) -> felt252 {
        match self {
            RoundState::WaitingForWolfCommitment => 1,
            RoundState::WaitingForSheepToKill => 2,
            RoundState::WaitingForWolfSelection => 3,
            RoundState::WaitingForWolfResult => 4,
        }
    }
}

#[derive(Copy, Drop, Serde)]
#[dojo::event]
pub struct CreateGameEvent {
    #[key]
    pub player: ContractAddress,
    pub game_id: u32,
}
