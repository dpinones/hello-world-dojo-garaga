#[starknet::interface]
pub trait IUltraKeccakZKHonkVerifier<T> {
    fn verify_ultra_keccak_zk_honk_proof(self: @T, full_proof_with_hints: Span<felt252>) -> Option<Span<u256>>;
}
