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



% 3. Haz un programa prolog que escriba la manera de colocar sobre un tablero de
%    ajedrez ocho reinas sin que éstas se ataquen entre sí.
%    Por ejemplo, ésta sería una solucion:

queens(N,Qs) :-
	range(1,N,Ns),
	queens(Ns,[],Qs).

queens([],Qs,Qs).
queens(UnplacedQs,SafeQs,Qs) :-
	select(UnplacedQs,UnplacedQs1,Q),
	not_attack(SafeQs,Q),
	queens(UnplacedQs1,[Q|SafeQs],Qs).

not_attack(Xs,X) :-
	not_attack(Xs,X,1).

not_attack([],_,_) :- !.
not_attack([Y|Ys],X,N) :-
	X =\= Y+N, X =\= Y-N,
	N1 is N+1,
	not_attack(Ys,X,N1).

select([X|Xs],Xs,X).
select([Y|Ys],[Y|Zs],X) :- select(Ys,Zs,X).

range(N,N,[N]) :- !.
range(M,N,[M|Ns]) :-
	M < N,
	M1 is M+1,
range(M1,N,Ns).
