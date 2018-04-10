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

 %  G = (V,E), si R está incluido en V y toda arista de E tiene al menos un vértice en R.

cover(K):-
    nVertices(N),
    length(Vars,N),
    Vars ins 0..1,
    coverEdges(Vars),        % each edge has at least one of its extreme points chosen (to be implemented)
    atMostKVertices(Vars,K), % we choose at most K vertices (to be implemented)
    label(Vars),!,
    displaySolCover(Vars).

coverEgdes(Vars) :-
		    findall(edge(Vars,V),include(V),List),
		    lengthC(List,S),
		    S > 0.

coverEgdes(Vars) :-
		    findall(edge(V,Vars),include(V),List),
		    lengthC(List,S),
		    S > 0.

coverEdges(_).


atMostKVertices(Vars,K):- findall(Vars,include(Vars),List),
			  lengthC(List,S),
			  S1 is S +1,
			  S1 < K.
	  
atMostKVertices(_,_).


include(Vars) :- edge(Vars,_).
include(Vars) :- edge(_,Vars).


lengthC([],0).
lengthC([L|Lit],S):- L, lengthC(Lit,S1), S is S1 + 1.
lengthC([L|Lit],S):- \+L, length(Lit,S1),S is S1.




		

