%1. Escribe un predicado prolog "flatten" que aplana listas:
%?- flatten( [a,[b,c,[b,b],e], f], L).
%L = [a,b,c,b,b,e,f]
flatten([],[]).

%Caso A: Dentro de la lista solo hay elementos
%si es una lista pasa a la siguiente función
flatten([X|L1],[X|L]):-
    \+isList(X),
    flatten(L1,L).

%Caso B: El elemento a tratar es una lista
%Si entra aquí es porque es una lista, no cal comprobar nada.
flatten([X|L1],L):-
    flatten(X,L2),  %X se vuelve en una lista de elementos
    flatten(L1,F),  %L1 se sigue tratando por su cuenta
    append(L2,F,L).  %Se junta el flatten de X con el flatten de L1.

%FUNCIONES AUXILIARES-----------------------------------------------------------
isList([_|_]).
isList([]).
%------------------------------------------------------------------------------
