# Hunting the Wolf - ZK Game

A deduction game where a wolf hides among sheep and a shepherd tries to find it, using zero-knowledge proofs (ZK) to keep the wolf's identity hidden.

## Game Concept

Hunting the Wolf is a game where one player (the wolf) disguises as a sheep and another player (the shepherd) tries to find it among the other sheep. The game implements zero-knowledge proofs to keep the wolf's identity private, adding a layer of cryptographic security to the game.

### Game Mechanics

1. **Game Start**:
   - A board with 16 sheep is generated, each with an assigned number.
   - The wolf chooses a sheep to hide its identity and sends a cryptographic commitment that keeps its choice secret.

2. **Rounds**:
   - In each round, the wolf must select an adjacent sheep to kill, verified through ZK proofs.
   - The sheep appears dead on the board.
   - The shepherd marks a sheep as suspicious.
   - The wolf generates a ZK proof that verifies whether the marked sheep is the wolf or not, without revealing its identity.
   - If the marked sheep is the wolf, the round ends. If not, the sheep dies and the game continues.

3. **End**:
   - After 3 rounds, players swap roles (the shepherd becomes the wolf and vice versa).
   - The game ends after 6 total rounds (3 for each role).
   - The score is based on the number of sheep each player managed to eliminate.
   - The player with the highest score wins.

## Privacy System

The game implements two main ZK circuits:

1. **kill_sheep**: Verifies that:
   - The wolf is who it claims to be (matches the commitment)
   - The sheep to be killed is adjacent to the wolf (horizontally, vertically, or diagonally)
   - The sheep to be killed is alive

2. **is_wolf**: Verifies that:
   - The wolf's commitment is valid
   - The marked sheep is alive
   - Whether the marked sheep is the wolf or not

### Privacy Flow

1. **Wolf's initial commitment**:
   - The wolf chooses a sheep and generates a random value (salt) that is saved in localStorage
   - Creates a commitment using the Poseidon function: `poseidon([wolf_sheep_number, wolf_salt])`
   - Only this hash is published on the blockchain, keeping the wolf's identity secret

2. **Sheep's death**:
   - The wolf selects an adjacent sheep to kill
   - Generates a ZK proof with the `kill_sheep` circuit
   - The sheep dies and is saved in the contract

3. **Shepherd's selection of the suspicious sheep**:
   - The shepherd selects a suspicious sheep
   - This selection is saved in the contract

4. **The wolf generates a ZK proof to verify if the marked sheep is the wolf**:
   - The wolf's frontend is waiting for the shepherd to mark a sheep as suspicious
   - Generates a ZK proof with the `is_wolf` circuit
   - The ZK proof is sent to the contract

5. **Wolf verification**:
   - The contract verifies the ZK proof and determines the result
   - The result (1=is wolf, 0=is not wolf) is obtained without revealing the wolf's identity
   - Only if the wolf is found (result=1), the round ends
   - If the wolf is not found, the game is saved for the next round
