%1. Escribe un predicado prolog "flatten" que aplana listas:

%?- flatten( [a,[b,c,[b,b],e], f], L).
%L = [a,b,c,b,b,e,f]

%aux para flatten
isList([_|_]).
isList([]).


%aux para flattenNoRepetitions

noRep([],[]).
noRep([X],[X]).

%aux
noRep([X|L],F):-
    containsElement(X,L),
    noRep(L,F), !.
%aux
noRep([X|L],[X|F]):-
    noRep(L,F), !.




%Caso INI
concatenarNoRep([],[],[]).

concatenarNoRep(L,[],F):-
    noRep(L,F).
concatenarNoRep([],L,F):-
    noRep(L,F).

%Caso A: Elemento esta en L2
concatenarNoRep( [X|L1], L2, F):-
    containsElement(X,L2), 
    concatenarNoRep(L1,L2,F), !.

%Caso B: Elemento no esta en L2
concatenarNoRep( [X |L1], L2, [X|F]):-
    concatenarNoRep(L1,L2,F).

%aux para flattenNoRepetitions
containsElement(X, [X|_]).
containsElement(X, [Y|L]):-
        X \= Y,
        containsElement(X,L).

%Caso ini 
%flattenM([],[]).

%Caso A: Dentro de la lista solo hay elementos
%si es una lista pasa a la siguiente función
flatten([X|L1],[X|L]):-
    \+isList(X),
    flatten(L1,L), !.

%Caso B: El elemento a tratar es una lista
%Si entra aquí es porque es una lista, no cal comprobar nada.
flatten([X|L1],L):-
    flatten(X,L2),  %X se vuelve en una lista de elementos
    flatten(L1,F),  %L1 se sigue tratando por su cuenta
    append(L2,F,L).  %Se junta el flatten de X con el flatten de L1.
    
%Escribe otro que elimina las repeticiones:
%?- flattenNoRepetitions( [a,[b,c,[b,b],e], f], L).
%L = [a,b,c,e,f]

flattenNoRepetitions([X|L1], F):-
    flattenNoRepetitions(L1,L2), %recursividad.
    incluir(X,L2,F).

%L2 ES UNA LISTA SOLO DE ELEMENTOS BASICOS    

%Caso A: Es elemento y se encuentra en L2. (No se incluye)
incluir(X,L2, L2):-
    \+isList(X),
    containsElement(X,L2),!.
    
%Caso B: Es elemento y no se encuentra en L2. (Se incluye)
incluir(X,L2, [X|L2]):-
    \+isList(X) , !.
    
%Caso C: Es una lista, 
%se hace flattenNoRepetitions del elemento X.
incluir(X,L2, F):-
    flattenNoRepetitions(X, L1),
    incluirLista(L1,L2,F).          %Se mira si se pueden incluir los elementos de L1
    
incluirLista([],[],[]).
incluirLista([X|L1],L2,F):-
    incluirLista(L1,L2,F1), %recursividad
    incluir(X,F1,F).        %incluye elemento (se sabe que es un elemento basica)

