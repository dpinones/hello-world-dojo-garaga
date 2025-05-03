# Hunting the Wolf - ZK Game

Un juego de deducción donde un lobo se esconde entre ovejas y un pastor intenta encontrarlo, usando pruebas de conocimiento cero (ZK) para mantener oculta la identidad del lobo.

## Concepto del Juego

Hunting the Wolf es un juego donde un jugador (el lobo) se disfraza como una oveja y otro jugador (el pastor) intenta encontrarlo entre las demás ovejas.

### Mecánica del Juego

1. **Inicio del Juego**:
   - Se genera una matriz de n×m con i ovejas, cada una con un número asignado.
   - El lobo elige una oveja para ocultar su identidad y envía un compromiso hash H(Oveja#, SalLobo) que mantiene en secreto su elección.

2. **Rondas**:
   - En cada ronda, el lobo debe seleccionar una oveja adyacente para matar.
   - La oveja aparece muerta en el tablero.
   - El pastor hace deducciones y puede disparar a una oveja para ver si es el lobo. Si no es el lobo, la oveja muere.
   - Después, las ovejas se mezclan aleatoriamente para la siguiente ronda.

3. **Final**:
   - El juego termina cuando el pastor mata al lobo.
   - La puntuación se basa en el número de ovejas que quedan vivas.
   - Los jugadores pueden intercambiar roles y comparar puntuaciones.

## Tecnología

El juego utiliza:

- **Noir**: Para implementar los circuitos de pruebas de conocimiento cero
- **Solidity**: Para los contratos inteligentes que gestionan el juego
- **Zero-Knowledge Proofs**: Para verificar acciones sin revelar información privada

## Implementación

El proyecto consta de los siguientes componentes:

### Contratos Solidity

- `WolfHuntGame.sol`: Contrato principal que gestiona el juego
- `IWolfKillSheep.sol`: Interfaz para el verificador de pruebas del lobo
- `IShepherdKillSheep.sol`: Interfaz para el verificador de pruebas del pastor

### Circuitos Noir

- `wolf_kill_sheep.nr`: Circuito para verificar que el lobo mata a una oveja válida
- `shepherd_kill_sheep.nr`: Circuito para verificar si una oveja es el lobo o no

## Inspiración

Este juego se inspiró en [ZK-Hunt](https://0xparc.org/blog/zk-hunt), un proyecto que exploró diferentes mecánicas de juego utilizando pruebas de conocimiento cero y estados privados.

## Cómo Jugar

1. Un jugador crea una partida en el contrato, especificando el tamaño del tablero y el número de ovejas.
2. El jugador que toma el rol del lobo envía su compromiso para ocultar qué oveja es realmente el lobo.
3. Los jugadores alternan turnos, con el lobo matando ovejas y el pastor intentando encontrar al lobo.
4. El juego continúa hasta que el pastor encuentra al lobo o todas las ovejas (excepto el lobo) han sido eliminadas.

## Futuras Mejoras

- Implementar una interfaz de usuario para jugar más fácilmente
- Añadir mecánicas adicionales, como habilidades especiales para el lobo y el pastor
- Implementar un sistema de clasificación para competiciones 



Fin de la Partida y Revelación ZK
Cuando el pastor dispara al lobo, el Lobo revela Oveja # y SalLobo, y cualquiera puede comprobar que:

bash
Copy
Edit
Hash(Oveja #, SalLobo) == H
Si el pastor nunca acierta y quedan ≤2 ovejas, el lobo gana por “escapada”.

6. Cartas de Acción

Carta	Efecto

Movimiento Extra	Lobo mata 2 ovejas esta ronda (debe probar adyacencia ZK para ambas).

Visión Parcial	Pastor mira el número de 1 oveja viva (sin matarla).

Trampa	Pastor coloca una trampa en una casilla: si el lobo mata ahí, pierde la ronda.

Pregunta Flagrante: pertenece a esa fila/columna, sin revelar cuál es.

puede matar a 2 de distancia: Obliga al Pastor a replantear deducciones previas tras cada uso.

Tras matar una oveja y antes del barajado, el Lobo puede “ocultar” esa muerte durante la siguiente fase de disparo.
Tras el disparo del Pastor, se revela la oveja “fantasma” y pasa al montón de muertas normalmente.

4x4 el tablero


Explicación del sistema de privacidad en "Hunting the Wolf"
El circuito shepherd_kill_sheep.nr ha sido corregido para mantener la privacidad usando pruebas de conocimiento cero (ZK). Aquí está cómo funciona el flujo correcto para garantizar que el lobo permanezca oculto:

Compromiso inicial del lobo:
El lobo elige una oveja para ser (secretamente) el lobo. Genera un "salt" aleatorio(SE GUARDA EN LOCAL STORAGE)
Crea un compromiso usando poseidon_2([wolf_sheep_number, wolf_salt])
Solo este compromiso (hash) se publica en la blockchain, sin revelar la identidad del lobo


Cuando el pastor quiere verificar una oveja:
El pastor selecciona una oveja para verificar (posible sospechoso)
Esta selección se hace pública (SE GUARDA EN EL CONTRATO)


El front del lobo esta suscrito a un cambio de modelo para la generación de la prueba ZK:
PUNTO CLAVE: La prueba ZK es generada por el lobo, no por el pastor

El lobo proporciona como entradas privadas:
La identidad real del lobo (wolf_sheep_number)
El salt secreto (wolf_salt)
El estado de todas las ovejas (sheep_alive)

La prueba verifica criptográficamente que:
El compromiso del lobo es válido
La oveja verificada está viva
Si la oveja verificada es o no el lobo

Verificación en el contrato:
El contrato recibe la prueba ZK y verifica su validez
El resultado (1=es lobo, 0=no es lobo) se obtiene sin revelar la identidad del lobo
Solo cuando se encuentra al lobo (resultado=1), se termina el juego


La privacidad se mantiene porque:
El pastor nunca recibe wolf_sheep_number ni wolf_salt
Solo conoce el resultado de la verificación (es/no es el lobo)
La generación de pruebas ZK permite verificar la verdad del resultado sin revelar la información secreta
En el flujo de juego real, el lobo proporcionaría la prueba al pastor fuera de la cadena, quien luego la enviaría al contrato inteligente para que la verifique. Esto garantiza que el estado privado (la identidad del lobo) solo sea conocido por el lobo, mientras que todos pueden verificar la legitimidad del juego.

Este modelo es similar a cómo funciona ZK Hunt, donde cierta información privada se verifica sin revelarse completamente hasta que es necesario.


El parámetro is_wolf_result necesita ser público porque comunica el resultado de la comprobación al mundo exterior (el verificador) mientras mantiene la privacidad de qué oveja es realmente el lobo.
En una prueba de conocimiento-cero:
Los datos privados (como el número de oveja_lobo) permanecen ocultos para el verificador.
Las entradas públicas son visibles tanto para el probador como para el verificador.
La aserción assert(is_wolf == is_wolf_result) asegura que el resultado es correcto, pero hacer público is_wolf_result es lo que permite al verificador conocer el resultado (lobo o no lobo) sin revelar la información secreta sobre qué oveja es realmente el lobo.
Si no fuera público, el verificador sabría que se ha generado una prueba válida pero no sabría cuál ha sido el resultado de la comprobación.

Traducción realizada con la versión gratuita del traductor DeepL.com