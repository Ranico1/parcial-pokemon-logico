% pokemon(nombre, tipo(_,_)).

pokemon(pikachu,electrico).
pokemon(charizard, fuego).
pokemon(venesaur, planta).
pokemon(blastoise, agua).
pokemon(totodile, agua).
pokemon(snorlax, normal).
pokemon(rayquaza, dragon).
pokemon(rayquaza, volador).


% entrenador(Nombre, pokemon).

entrenador(ash, pikachu). 
entrenador(ash, charizard).
entrenador(brock, snorlax).
entrenador(misty, blastoise).
entrenador(misty, venusaur).
entrenador(misty,arceus).

tipoMultiple(Pokemon) :- 
    pokemon(Pokemon, Tipo),
    pokemon(Pokemon, OtroTipo),
    Tipo \= OtroTipo. 

legendario(Pokemon) :- 
    tipoMultiple(Pokemon), 
    not(entrenador(_, Pokemon)).

misterioso(Pokemon) :-
    pokemon(Pokemon,_),
    caracMisteriosas(Pokemon).

caracMisteriosas(Pokemon) :- 
    not(entrenador(_,Pokemon)).

caracMisteriosas(Pokemon) :- 
    pokemon(Pokemon, Tipo),
    forall((pokemon(OtroPokemon,OtroTipo), Pokemon \= OtroPokemon), Tipo \= OtroTipo).
    

% Punto 2

% movimientos(fisicos(potencia)).
% movimientos(especiales(potencia, tipo)).
% movimientos(defensivos(porcentajeReduccion)). 

movimiento(pikachu, fisico(mordedura,95)).
movimiento(pikachu, especial(impactrueno,40, electrico)).

movimiento(charizard, especial(garraDragon, 100, dragon)).
movimiento(charizard, fisico(mordedura, 95)).

movimiento(blastoise, defensivo(proteccion, 10)).
movimiento(blastoise, fisico(placaje, 50)). 

movimiento(arceus, especial(impactrueno,40, electrico)). 
movimiento(arceus, especial(garraDragon,100, dragon)).
movimiento(arceus, defensivo(proteccion,10)). 
movimiento(arceus, fisico(placaje, 50)).
movimiento(arceus, defensivo(alivio,100)).


% Punto 1

danio(fisico(_,Danio), Danio).
danio(defensivo(_,_), 0).
danio(especial(_,Potencia, Tipo), Danio) :-
    coefTipo(Tipo, CoefTipo),
    Danio is Potencia * CoefTipo.

coefTipo(Tipo, 1.5) :-
basico(Tipo).

coefTipo(dragon, 3).
coefTipo(Tipo, 1) :-
    not(basico(Tipo)),
    Tipo \= dragon. 

basico(fuego).
basico(agua).
basico(planta).
basico(normal).


% Punto 2

capacidadOfensiva(Pokemon, Capacidad) :-
    movimiento(Pokemon,_),
    findall(Danio, danioMovimiento(Pokemon, Danio), Danios),
    sum_list(Danios, Capacidad).

danioMovimiento(Pokemon, Danio) :-
    movimiento(Pokemon, Movimiento),
    danio(Movimiento, Danio). 

% Punto 3 

entrenadorPicante(Entrenador) :- 
    entrenador(Entrenador,_),
    forall(entrenador(Entrenador, Pokemon), altoPokemon(Pokemon)).

altoPokemon(Pokemon) :-
    capacidadOfensiva(Pokemon, Capacidad),
    Capacidad > 200.

altoPokemon(Pokemon) :-
    misterioso(Pokemon). 






