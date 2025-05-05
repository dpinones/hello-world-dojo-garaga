# Ejemplo del Juego "Hunting the Wolf" en un Tablero 4x4

En este ejemplo, ilustraremos el juego en un tablero 4x4 con 16 ovejas (numeradas del 1 al 16) para mostrar los dos escenarios principales: cuando el pastor no encuentra al lobo y cuando finalmente lo encuentra.

### Configuración Inicial

**Ubicación del lobo:**
Elijo una oveja puntual para que el lobo se esconda. En este caso, se esconde en la oveja 12 (cuarta columna, tercera fila).

```
┌───┬───┬───┬───┐
│ 1 │ 2 │ 3 │ 4 │
├───┼───┼───┼───┤
│ 5 │ 6 │ 7 │ 8 │
├───┼───┼───┼───┤
│ 9 │10 │11 │12 │ ← (El lobo está aquí, pero nadie lo sabe excepto él)
├───┼───┼───┼───┤
│13 │14 │15 │16 │
└───┴───┴───┴───┘
```

### Turno del Lobo
1. El lobo (escondido en la oveja 12) decide matar a la oveja 8 adyacente.
2. El lobo genera una prueba ZK que verifica:
   - Que es quien dice ser (coincide con el compromiso)
   - Que la oveja a matar (8) está adyacente a él
   - Que la oveja a matar está viva

```
┌───┬───┬───┬───┐
│ 1 │ 2 │ 3 │ 4 │
├───┼───┼───┼───┤
│ 5 │ 6 │ 7 │ X │ ← (X = oveja 8 muerta)
├───┼───┼───┼───┤
│ 9 │10 │11 │12 │ ← (El lobo está aquí en la oveja 12)
├───┼───┼───┼───┤
│13 │14 │15 │16 │
└───┴───┴───┴───┘
```

### Turno del Pastor
1. El pastor observa que la oveja 8 ha sido asesinada.
2. Razona: "El lobo debe estar adyacente a 8. Podría ser 3, 4, 7, 11 o 12".
3. El pastor decide marcar la oveja 4 como sospechosa.

### Verificación
1. El lobo genera una prueba ZK de `is_wolf` que verifica si la oveja 4 es el lobo.
2. La prueba confirma que la oveja 4 NO es el lobo, sin revelar dónde está realmente el lobo.
3. La oveja 4 muere por ser erróneamente acusada.

```
┌───┬───┬───┬───┐
│ 1 │ 2 │ 3 │ X │ ← (X = oveja 4 muerta)
├───┼───┼───┼───┤
│ 5 │ 6 │ 7 │ X │ ← (X = oveja 8 muerta)
├───┼───┼───┼───┤
│ 9 │10 │11 │12 │ ← (El lobo está aquí en la oveja 12)
├───┼───┼───┼───┤
│13 │14 │15 │16 │
└───┴───┴───┴───┘
```

### Mezcla de Ovejas Entre Rondas

Al final de cada ronda, todas las ovejas vivas (no muertas) cambian de posición:

1. Las ovejas vivas (1, 2, 3, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16) se mezclan aleatoriamente en el tablero.
2. El lobo mantiene su identidad pero ahora puede estar en una nueva posición.
3. Esta mezcla añade complejidad al juego y dificulta el seguimiento del lobo.

Después de la mezcla, el tablero podría verse así (donde cada número representa la oveja que ahora ocupa esa posición):

```
┌───┬───┬───┬───┐
│ 7 │ 2 │16 │ X │ ← (X = oveja 4 muerta)
├───┼───┼───┼───┤
│ 1 │15 │ 6 │ X │ ← (X = oveja 8 muerta)
├───┼───┼───┼───┤
│ 3 │11 │13 │10 │
├───┼───┼───┼───┤
│ 9 │ 5 │14 │12 │ ← (El lobo está aquí en la oveja 12)
└───┴───┴───┴───┘
```

### Turno del Lobo
1. El lobo (escondido en la oveja 12, ahora en la esquina inferior derecha) decide matar a la oveja 10 adyacente (ubicada arriba de él).
2. El lobo genera una prueba ZK que verifica que puede matar a la oveja en esa posición.

```
┌───┬───┬───┬───┐
│ 7 │ 2 │16 │ X │
├───┼───┼───┼───┤
│ 1 │15 │ 6 │ X │
├───┼───┼───┼───┤
│ 3 │11 │13 │ X │ ← (X = oveja 10 muerta)
├───┼───┼───┼───┤
│ 9 │ 5 │14 │12 │ ← (El lobo está aquí en la oveja 12)
└───┴───┴───┴───┘
```

### Turno del Pastor
1. El pastor observa que la oveja 10 ha sido asesinada.
2. Razona: "Esta oveja solo podía ser atacada por las ovejas en las posiciones adyacentes. Podría ser 6, 13, 14 o 12".
3. El pastor, después de analizar el patrón de muertes y movimientos, decide marcar la oveja 12 como sospechosa.

### Verificación
1. El lobo genera una prueba ZK de `is_wolf` que verifica si la oveja marcada es el lobo.
2. La prueba confirma que la oveja marcada SÍ es el lobo.
3. La ronda termina con el pastor habiendo encontrado exitosamente al lobo.

```
┌───┬───┬───┬───┐
│ 7 │ 2 │16 │ X │
├───┼───┼───┼───┤
│ 1 │15 │ 6 │ X │
├───┼───┼───┼───┤
│ 3 │11 │13 │ X │
├───┼───┼───┼───┤
│ 9 │ 5 │14 │ L │ ← (L = lobo encontrado)
└───┴───┴───┴───┘
```

La ronda termina con el pastor habiendo encontrado exitosamente al lobo.

Al empezar la siguiente ronda, el lobo se esconde en una nueva oveja y el juego continúa.
El jugador 1 durante los primeros 3 turnos es el lobo, y el jugador 2 es el pastor. 
En los próximos 3 turnos, se invierten los roles.
Gana el que más ovejas mata siendo el lobo.
