```
make katana
```

```
make setup
```

Se asume que el lobo tomo el valor de la oveja 5 de indice 4

# jugador crea el juego

sozo execute dojo_starter-game_system create_game --wait --world 0x0193e3437b867035092ddd89f1c09281e51e2d21692457d6e8e65f680ee05fe8

# jugador se une al juego

sozo execute dojo_starter-game_system join_game  1 --wait --world 0x0193e3437b867035092ddd89f1c09281e51e2d21692457d6e8e65f680ee05fe8

# jugador sube el commit del lobo

sozo execute dojo_starter-game_system submit_wolf_commitment 1 u256:4 --wait --world 0x0193e3437b867035092ddd89f1c09281e51e2d21692457d6e8e65f680ee05fe8

# jugador mata a la oveja

sozo execute dojo_starter-game_system wolf_kill_sheep 1 0 0 --wait --world 0x0193e3437b867035092ddd89f1c09281e51e2d21692457d6e8e65f680ee05fe8

# jugador sospecha a la oveja

sozo execute dojo_starter-game_system shepherd_mark_suspicious 1 3 --wait --world 0x0193e3437b867035092ddd89f1c09281e51e2d21692457d6e8e65f680ee05fe8

# jugador sube el resultado si es el lobo

sozo execute dojo_starter-game_system check_is_wolf 1 0 --wait --world 0x0193e3437b867035092ddd89f1c09281e51e2d21692457d6e8e65f680ee05fe8


# ver los modelos
sozo model get dojo_starter-Game 1
sozo model get dojo_starter-Round 1
sozo model get dojo_starter-Cell 0