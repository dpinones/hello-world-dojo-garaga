
## Implementación del Frontend

Para implementar el frontend del juego, se necesita seguir estos pasos técnicos detallados:

### 1. Crear una Partida

**Función del contrato**: `create_game()`
**Parámetros**: Ninguno
**Retorna**: `game_id` (ID de la partida)

```javascript
// Ejemplo de llamada al contrato
async function createGame() {
  const gameId = await gameContract.create_game();
  // Guardar el gameId para usarlo en futuras llamadas
  localStorage.setItem('currentGameId', gameId);
  return gameId;
}
```

### 2. Selección y Compromiso del Lobo

**Función del contrato**: `submit_wolf_commitment(game_id, wolf_commitment)`
**Parámetros**:
- `game_id`: ID de la partida
- `wolf_commitment`: Hash del compromiso del lobo

**Preparación en el frontend**:
1. El lobo selecciona una oveja (índice entre 0-15)
2. El frontend genera un valor aleatorio como "salt"
3. Calcula el compromiso usando Poseidon

```javascript
// Ejemplo de implementación
async function selectWolfAndCommit(gameId, selectedWolfIndex) {
  // Generar salt aleatorio
  const wolfSalt = generateRandomSalt();
  
  // Guardar estos valores en localStorage para futuras pruebas ZK
  localStorage.setItem('wolfIndex', selectedWolfIndex);
  localStorage.setItem('wolfSalt', wolfSalt);
  
  // Calcular el compromiso usando Poseidon (librería de hashing ZK)
  const wolfCommitment = await poseidon.hash([selectedWolfIndex, wolfSalt]);
  
  // Enviar el compromiso al contrato
  await gameContract.submit_wolf_commitment(gameId, wolfCommitment);
  
  return { selectedWolfIndex, wolfSalt, wolfCommitment };
}

function generateRandomSalt() {
  // Generar un número aleatorio grande para usar como salt
  return BigInt(Math.floor(Math.random() * Number.MAX_SAFE_INTEGER));
}
```

### 3. Lobo Mata una Oveja

**Función del contrato**: `wolf_kill_sheep(game_id, proof, sheep_to_kill_index)`
**Parámetros**:
- `game_id`: ID de la partida
- `proof`: Prueba ZK generada
- `sheep_to_kill_index`: Índice de la oveja a matar

**Generación de la prueba ZK**:
1. Recuperar datos guardados (wolfIndex, wolfSalt)
2. Obtener el estado actual de las ovejas
3. Generar la prueba usando el circuito `kill_sheep.nr`

```javascript
async function wolfKillSheep(gameId, sheepToKillIndex) {
  // Recuperar los datos del lobo
  const wolfIndex = localStorage.getItem('wolfIndex');
  const wolfSalt = localStorage.getItem('wolfSalt');
  
  // Obtener el estado actual de las ovejas (alive/dead)
  const sheepAliveStatus = await getSheepAliveStatus(gameId);
  
  // Verificar adyacencia (implementación simplificada)
  if (!areAdjacent(wolfIndex, sheepToKillIndex)) {
    throw new Error("La oveja seleccionada no es adyacente al lobo");
  }
  
  // Obtener el valor actual de la oveja lobo (su número en el tablero)
  const wolfValue = await getSheepValue(wolfIndex);
  
  // Obtener todas las posiciones de las ovejas
  const sheepPositions = await getAllSheepPositions();
  
  // Generar prueba ZK usando circuito kill_sheep
  const inputs = {
    // Entradas privadas
    wolf_value: wolfValue,
    wolf_index: wolfIndex,
    wolf_salt: wolfSalt,
    sheep_positions: sheepPositions,
    sheep_alive: sheepAliveStatus,
    
    // Entradas públicas
    wolf_commitment: await getWolfCommitment(gameId),
    sheep_to_kill_index: sheepToKillIndex
  };
  
  // Generar la prueba (esto sería usando la librería de Noir)
  const { proof } = await noir.generateProof(killSheepCircuit, inputs);
  
  // Enviar la prueba al contrato
  await gameContract.wolf_kill_sheep(gameId, proof, sheepToKillIndex);
}

function areAdjacent(wolfIndex, sheepIndex) {
  // Convierte los índices a coordenadas (filas y columnas)
  const wolfRow = Math.floor(wolfIndex / 4);
  const wolfCol = wolfIndex % 4;
  const sheepRow = Math.floor(sheepIndex / 4);
  const sheepCol = sheepIndex % 4;
  
  // Calcula las diferencias absolutas
  const rowDiff = Math.abs(wolfRow - sheepRow);
  const colDiff = Math.abs(wolfCol - sheepCol);
  
  // Verifica si están adyacentes (incluyendo diagonales)
  return (rowDiff <= 1 && colDiff <= 1 && !(rowDiff === 0 && colDiff === 0));
}
```

### 4. Pastor Marca una Oveja Sospechosa

**Función del contrato**: `shepherd_mark_suspicious(game_id, sheep_to_mark_index)`
**Parámetros**:
- `game_id`: ID de la partida
- `sheep_to_mark_index`: Índice de la oveja sospechosa

```javascript
async function markSuspiciousSheep(gameId, suspiciousSheepIndex) {
  // Validar que la oveja está viva
  const sheepAliveStatus = await getSheepAliveStatus(gameId);
  if (!sheepAliveStatus[suspiciousSheepIndex]) {
    throw new Error("La oveja seleccionada ya está muerta");
  }
  
  // Marcar la oveja como sospechosa
  await gameContract.shepherd_mark_suspicious(gameId, suspiciousSheepIndex);
}
```

### 5. Lobo Genera Prueba para Verificar

**Función del contrato**: `check_is_wolf(game_id, proof)`
**Parámetros**:
- `game_id`: ID de la partida
- `proof`: Prueba ZK generada

```javascript
async function checkIsWolf(gameId) {
  // Obtener la oveja marcada como sospechosa
  const suspiciousSheepIndex = await getSuspiciousSheepIndex(gameId);
  
  // Recuperar los datos del lobo
  const wolfIndex = localStorage.getItem('wolfIndex');
  const wolfSalt = localStorage.getItem('wolfSalt');
  
  // Obtener el estado actual de las ovejas
  const sheepAliveStatus = await getSheepAliveStatus(gameId);
  
  // Obtener el compromiso actual del lobo
  const wolfCommitment = await getWolfCommitment(gameId);
  
  // Determinar si la oveja sospechosa es el lobo
  const isWolf = (wolfIndex == suspiciousSheepIndex) ? 1 : 0;
  
  // Generar prueba ZK usando circuito is_wolf
  const inputs = {
    // Entradas privadas
    wolf_index: wolfIndex,
    wolf_salt: wolfSalt,
    sheep_alive: sheepAliveStatus,
    
    // Entradas públicas
    wolf_commitment: wolfCommitment,
    sheep_to_check_index: suspiciousSheepIndex,
    is_wolf_result: isWolf
  };
  
  // Generar la prueba (usando la librería de Noir)
  const { proof } = await noir.generateProof(isWolfCircuit, inputs);
  
  // Enviar la prueba al contrato
  await gameContract.check_is_wolf(gameId, proof);
  
  return isWolf; // Para actualizar la UI
}
```

### 6. Monitoreo del Estado del Juego

Para mantener la UI actualizada, el frontend debe suscribirse a eventos del contrato:

```javascript
async function setupGameStateMonitoring(gameId) {
  // Suscribirse a eventos relevantes
  gameContract.on("RoundStateChanged", (id, state) => {
    if (id === gameId) {
      updateUIForRoundState(state);
    }
  });
  
  gameContract.on("SheepKilled", (id, sheepIndex) => {
    if (id === gameId) {
      updateUIForDeadSheep(sheepIndex);
    }
  });
  
  gameContract.on("GameOver", (id, winnerAddress) => {
    if (id === gameId) {
      showGameOverScreen(winnerAddress);
    }
  });
}
```