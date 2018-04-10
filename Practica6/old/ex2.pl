:- use_module(library(clpfd)).

example1([1,2,3,5,6,7], [1,4,7,11,14,15]).

% Crea variables sense nom
listVars(0, []).
listVars(N, [_|L1]) :-
	N1 is N - 1,
	listVars(N1, L1).

weights([], _, 0).
weights([X | W], [Y | L], X * Y + WT) :-
	weights(W, L, WT).

values([], _, 0).
values([X | V], [Y | L], R + X*Y) :-
	values(V, L, R).

p:-
	example1(Weight, Value),
	length(Weight, N),
	listVars(N, L),
	%L = [A, B, C, D, E, F],
	L ins 0..80,
	weights(Weight, L, WeightL),
	values(Value, L, ValueL),
	WeightL #=< 80,
	labeling([max(ValueL)], L),

	write(WeightL),nl,
	write(L),
	!.
