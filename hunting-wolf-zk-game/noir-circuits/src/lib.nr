// Wolf Hunt ZK Circuits Library
// Contains the main circuits for the Wolf Hunt ZK game

mod wolf_kill_sheep;
mod shepherd_kill_sheep;

// Re-export the circuits for external use
pub use wolf_kill_sheep::main as wolf_kill_sheep;
pub use shepherd_kill_sheep::main as shepherd_kill_sheep; 