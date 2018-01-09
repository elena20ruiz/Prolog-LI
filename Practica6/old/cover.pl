:-use_module(library(clpfd)).

nVertices(5).
edge(1,2).
edge(1,3).
edge(2,3).
edge(3,4).
edge(4,5).
edge(5,1).
edge(5,2).

displaySolCover(Vars):-
    nVertices(N),
    between(1,N,V),
    nth1(V,Vars,X), %% X is the V-th element of the list Vars (first element has index 1)
    write('Chosen('), write(V), write(') = '), write(X), nl, fail.
displaySolCover(_).

cover(K):-
    nVertices(N),
    length(Vars,N),
    Vars ins 0..1,
    coverEdges(Vars),
    atMostKVertices(Vars,K),
    label(Vars), !,
    displaySolCover(Vars).

coverEdges(Vars) :-
    findall(A, edge(A,_), As),
    findall(B, edge(_,B), Bs),
    coverEdges(Vars, As, Bs).

coverEdges(Vars, [A|As], [B|Bs]) :-
    nth1(A, Vars, X),
    nth1(B, Vars, Y),
    sum([X, Y], #>=, 1),
    coverEdges(Vars, As, Bs).
coverEdges(_,[],[]).

atMostKVertices(Vars, K) :- sum(Vars, #=<, K).
    
