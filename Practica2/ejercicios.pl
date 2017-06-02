%suma(L,S) es cert si S es la suma dels elements de la llista L
%		 PRE: L es una llista d'enters.

suma([],0).
suma([X|L], S) :-
		  suma(L,S1),
		  S is X + S1.

pert(X, [X|_]).
pert(X, [_|L]) :- pert(X,L).

concat([],[],[]).
concat([],L2,L2).
concat(L1,[],L1).
concat([X|L1], L2 , [X|C]):- concat(L1,L2,C).

%ultim(L,U)
ultim(L,U):- concat(_,[U],L).

%fact(N,F), donat N calcula F el seu facturial
fact(0,1).
fact(N,F):- 
	N > 0,
	N1 is N-1,
	fact(N1,F1),
	F is N*F1.

2, 3 , 5 , 6 ,7 ,8 ,9
