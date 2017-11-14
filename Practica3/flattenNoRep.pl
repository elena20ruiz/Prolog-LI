
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
    concatenarNoRep(L1,L2,F).
%___________________________________

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

isList([_|_]).
isList([]).
