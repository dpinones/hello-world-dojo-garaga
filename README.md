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
   - Genera una prueba ZK con el circuito `kill_sheep`
   - La oveja muere y se guarda en el contrato

3. **Elección de la oveja sospechosa por el pastor**:
   - El pastor selecciona una oveja sospechosa
   - Esta selección se guarda en el contrato

4. **El lobo genera una prueba ZK para verificar si la oveja marcada es el lobo**:
   - El frontend del lobo esta esperando a que el pastor marque una oveja como sospechosa.
   - Genera una prueba ZK con el circuito `is_wolf`
   - La prueba ZK se envía al contrato

5. **Verificación del lobo**:
   - El contrato verifica la prueba ZK y determina el resultado
   - El resultado (1=es lobo, 0=no es lobo) se obtiene sin revelar la identidad del lobo
   - Solo si se encuentra al lobo (resultado=1), termina la ronda
   - Si no se encuentra al lobo, se guarda la partida para la siguiente ronda
