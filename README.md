# Hunting the Wolf - ZK Game

Un juego de deducción donde un lobo se esconde entre ovejas y un pastor intenta encontrarlo, usando pruebas de conocimiento cero (ZK) para mantener oculta la identidad del lobo.

## Concepto del Juego

Hunting the Wolf es un juego donde un jugador (el lobo) se disfraza como una oveja y otro jugador (el pastor) intenta encontrarlo entre las demás ovejas. El juego implementa pruebas de conocimiento cero para mantener la identidad del lobo privada, añadiendo una capa de seguridad criptográfica al juego.

### Mecánica del Juego

1. **Inicio del Juego**:
   - Se genera un tablero con 16 ovejas, cada una con un número asignado.
   - El lobo elige una oveja para ocultar su identidad y envía un compromiso criptográfico que mantiene en secreto su elección.

2. **Rondas**:
   - En cada ronda, el lobo debe seleccionar una oveja adyacente para matar, verificado mediante pruebas ZK.
   - La oveja aparece muerta en el tablero.
   - El pastor marca una oveja como sospechosa.
   - El lobo genera una prueba ZK que verifica si la oveja marcada es o no el lobo, sin revelar su identidad.
   - Si la oveja marcada es el lobo, la ronda termina. Si no, la oveja muere y el juego continúa.

3. **Final**:
   - Después de 3 rondas, los jugadores intercambian roles (el pastor se convierte en lobo y viceversa).
   - El juego finaliza después de 6 rondas totales (3 por cada rol).
   - La puntuación se basa en la cantidad de ovejas que cada jugador logró eliminar.
   - El jugador con la puntuación más alta gana.

## Cómo Jugar

1. Un jugador crea una partida en el contrato.
2. El jugador que toma el rol del lobo envía su compromiso criptográfico para ocultar qué oveja es realmente el lobo.
3. Durante su turno, el lobo elimina una oveja adyacente utilizando pruebas ZK.
4. El pastor marca una oveja como sospechosa.
5. El lobo genera una prueba ZK que verifica si la oveja marcada es el lobo.
6. El juego continúa hasta que el pastor encuentra al lobo o se completan todas las rondas.

## Sistema de Privacidad

El juego implementa dos circuitos ZK principales:

1. **kill_sheep**: Verifica que:
   - El lobo es quien dice ser (coincide con el compromiso)
   - La oveja a matar está adyacente al lobo (en horizontal, vertical o diagonal)
   - La oveja a matar está viva

2. **is_wolf**: Verifica que:
   - El compromiso del lobo es válido
   - La oveja marcada está viva
   - Si la oveja marcada es o no el lobo

### Flujo de Privacidad

1. **Compromiso inicial del lobo**:
   - El lobo elige una oveja y genera un valor aleatorio (salt) que guarda en localStorage
   - Crea un compromiso usando la función Poseidon: `poseidon([wolf_sheep_number, wolf_salt])`
   - Solo este hash se publica en la blockchain, manteniendo la identidad del lobo secreta

2. **Muerte de la oveja**:
   - El lobo selecciona una oveja adyacente para matar
   - La oveja muere y se guarda en el contrato

3. **Verificación del pastor**:
   - El pastor selecciona una oveja sospechosa
   - Esta selección se guarda en el contrato

4. **Generación de prueba ZK**:
   - El lobo proporciona como entradas privadas:
     - La identidad real del lobo (wolf_sheep_number)
     - El salt secreto (wolf_salt)
     - El estado de todas las ovejas (sheep_alive)
   - La prueba verifica criptográficamente la validez del compromiso y si la oveja marcada es el lobo

5. **Verificación en el contrato**:
   - El contrato verifica la prueba ZK y determina el resultado
   - El resultado (1=es lobo, 0=no es lobo) se obtiene sin revelar la identidad del lobo
   - Solo si se encuentra al lobo (resultado=1), termina la ronda

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

### Consideraciones Adicionales

1. **Manejo de Turnos**: Implementar lógica para alternar entre el turno del lobo y el pastor.
2. **UI para Selección de Ovejas**: Crear una interfaz visual del tablero con las 16 ovejas.
3. **Visualización del Estado**: Mostrar ovejas vivas/muertas y la marcada como sospechosa.
4. **Cambio de Roles**: Después de 3 rondas, gestionar el cambio de roles entre jugadores.
5. **Puntuación**: Mostrar la puntuación acumulada de cada jugador.

La privacidad se mantiene porque el pastor nunca conoce qué oveja es el lobo hasta que lo encuentra, y todas las verificaciones se realizan de manera criptográfica a través de pruebas ZK.

## Tecnologías Utilizadas

- **Noir**: Lenguaje para escribir los circuitos ZK
- **Dojo/Cairo**: Para el contrato inteligente en StarkNet
- **Poseidon**: Función hash utilizada para los compromisos criptográficos

## Futuras Mejoras

- Implementar una interfaz de usuario para jugar más fácilmente
- Añadir mecánicas adicionales, como habilidades especiales para el lobo y el pastor
- Implementar un sistema de clasificación para competiciones
