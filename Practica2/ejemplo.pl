
%FAMILIA
padre(juan,pedro).
padre(maria,pedro).
hermano(pedro, vicente).
hermano(pedro, alberto).
tio(x,y) :- padre(x,z) , hermano(z,y).

%AFIRMACIONES
woman(mia).
playsAirGuitar(mia).
party.

%FUNCIONES
mujer(maria).
mujer(sara).
mujer(laura).

quiere(sara,mario).
quiere(laura,pedro).
quiere(maria,alberto).
