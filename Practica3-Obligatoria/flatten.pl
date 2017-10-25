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

%Escribe otro que elimina las repeticiones:
%?- flattenNoRepetitions( [a,[b,c,[b,b],e], f], L).
%L = [a,b,c,e,f]
flattenNoRepetitions([],[]).

flattenNoRepetitions([X|L1], F):-
    flattenNoRepetitions(L1,L2), %recursividad.
    incluir(X,L2,F).

%FUNCIONES AUXILIARES-----------------------------------------------------------

%incluir(Elemento/Lista, Lista, Lista final)
% El elemento/los elementos se incluye en la lista final si no se encuentra en la lista

%Caso A: Es elemento y se ya esta en la lista
incluir(X,L2, L2):-
    \+isList(X),
    containsElement(X,L2). %

%Caso B: Es elemento y no esta en la lista
incluir(X,L2, [X|L2]):-
    \+isList(X),
    \+containsElement(X,L2).

%Caso C: Es una lista se   mira de incluir la lista
incluir(X,L2, F):-
    isList(X),
    flattenNoRepetitions(X, L1),
    incluir(L1,L2,F).
%___________________________________

incluirLista([],[],[]).
incluirLista([],[X],[X]).
incluirLista([X],[],[X]).
incluirLista([X|L1],L2,F):-
    incluir(L1,L2,F1), %recursividad
    concatenarNoRep(X,F1,F).        %incluye elemento (se sabe que es un elemento basica)
%____________________________________

%noRep(Lista,Lista)
%Dada una lista devuelve otra lista con los mismo elementos pero no repetidos
noRep([],[]).
noRep([X],[X]).

noRep([X|L],F):-
    containsElement(X,L),
    noRep(L,F).

noRep([X|L],[X|F]):-
    \+containsElement(X,L),
    noRep(L,F).
%________________________________

%concatenarNoRep(Lista1,Lista2, Lista1·Lista2)
%concatenacion de dos listas sin repeticion de elementos
concatenarNoRep([],[],[]).
concatenarNoRep(L,[],F):- noRep(L,F).
concatenarNoRep([],L,F):- noRep(L,F).

concatenarNoRep( [X|L1], L2, F):- %Elemento X esta en L2
    containsElement(X,L2),
    concatenarNoRep(L1,L2,F).

concatenarNoRep( [X |L1], L2, [X|F]):- %Elemento no esta en L2
    \+containsElement(X,L2),
    concatenarNoRep(L1,L2,F).
%___________________________________

%containsElement(Element,Lista)
%Es cierto si la lista contiene el elemento X
containsElement(X, [X|_]).
containsElement(X, [Y|L]):-
        X \= Y,
        containsElement(X,L).
%___________________________________
