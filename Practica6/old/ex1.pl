
:- use_module(library(clpfd)).

listVars(0, []).
listVars(N, [_|L1]) :-
	N1 is N - 1,
	listVars(N1, L1).

p:-
	% John, Paul and Ringo
	L = [A, B, C],
	L ins 0..10,
	2*C #=< A,
	A + 3 #=< B,
	C #>= 3,
	label(L),

	write(L),nl.
