# Game State Flow Diagram

This diagram shows the complete flow of the "Hunting the Wolf" game, including both frontend and blockchain interactions. The game progresses through several main states:

```mermaid
sequenceDiagram
    participant Player1(Wolf)
    participant Player2(Shepherd)
    participant Frontend
    participant Blockchain

    %% 1. Create game
    Player1(Wolf)->>Frontend: Start new game
    Frontend->>Blockchain: create_game()

    %% 2. Join game
    Player2(Shepherd)->>Frontend: Join game
    Frontend->>Blockchain: join_game(game_id)

    %% 3. Wolf commitment (Player 1)
    Player1(Wolf)->>Frontend: Select wolf sheep
    Frontend->>Frontend: Generate commitment
    Frontend->>Blockchain: submit_wolf_commitment(game_id, wolf_commitment)

    %% 4. Wolf's turn (Player 1)
    Player1(Wolf)->>Frontend: Select sheep to kill
    Frontend->>Frontend: Generate ZK proof (kill_sheep)
    Frontend->>Blockchain: wolf_kill_sheep(game_id, sheep_to_kill_index, proof)

    %% 5. Shepherd's turn (Player 2)
    Player2(Shepherd)->>Frontend: Mark suspicious sheep
    Frontend->>Blockchain: shepherd_mark_suspicious(game_id, sheep_to_mark_index)

    Note over Player1(Wolf): No action required from Player 1.

    %% 6. Wolf verification (Player 1)
    Player1(Wolf)->>Frontend: Generate ZK proof (is_wolf)
    Frontend->>Frontend: Generate ZK proof (is_wolf)
    Frontend->>Blockchain: check_is_wolf(game_id, proof)

    %% 7. End of round / shuffle / role change
    alt Wolf found
        Blockchain-->>Frontend: Event: GameOver or Role change
    else Wolf not found
        Blockchain-->>Frontend: Event: Shuffle sheep and next round
    end
```