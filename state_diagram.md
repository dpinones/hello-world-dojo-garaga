# Game State Flow Diagram

This diagram shows the complete flow of the "Hunting the Wolf" game, including both frontend and blockchain interactions. The game progresses through several main states:

```mermaid
sequenceDiagram
    participant Jugador1(Lobo)
    participant Jugador2(Pastor)
    participant Frontend
    participant Blockchain

    %% 1. Crear partida
    Jugador1(Lobo)->>Frontend: Iniciar nueva partida
    Frontend->>Blockchain: create_game()

    %% 2. Unirse a la partida
    Jugador2(Pastor)->>Frontend: Unirse a la partida
    Frontend->>Blockchain: join_game(game_id)

    %% 3. Compromiso del lobo (Jugador 1)
    Jugador1(Lobo)->>Frontend: Seleccionar oveja lobo
    Frontend->>Frontend: Generar salt y commitment
    Frontend->>Blockchain: submit_wolf_commitment(game_id, wolf_commitment)

    %% 4. Turno del lobo (Jugador 1)
    Jugador1(Lobo)->>Frontend: Seleccionar oveja a matar
    Frontend->>Frontend: Generar prueba ZK (kill_sheep)
    Frontend->>Blockchain: wolf_kill_sheep(game_id, proof_kill, sheep_to_kill_index)

    %% 5. Turno del pastor (Jugador 2)
    Jugador2(Pastor)->>Frontend: Marcar oveja sospechosa
    Frontend->>Blockchain: shepherd_mark_suspicious(game_id, sheep_to_mark_index)

    Note over Jugador1(Lobo): No requiere acción del Jugador 1.

    %% 6. Verificación del lobo (Jugador 1)
    Jugador1(Lobo)->>Frontend: Generar prueba ZK (is_wolf)
    Frontend->>Frontend: Generar prueba ZK (is_wolf)
    Frontend->>Blockchain: check_is_wolf(game_id, proof_is_wolf)

    %% 7. Fin de ronda / mezcla / cambio de roles
    alt Wolf encontrado
        Blockchain-->>Frontend: Evento: GameOver o Cambio de roles
    else Wolf no encontrado
        Blockchain-->>Frontend: Evento: Mezclar ovejas y siguiente ronda
    end
```