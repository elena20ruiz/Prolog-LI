:-use_module(library(clpfd)).

main:-
	sendmory(Send + More = Money),
	write(Send), write(' + '), write(More), write(' = '), write(Money), nl,
	halt.

sendmory([ S, E, N, D ] + [ M, O, R, E ] = [ M, O, N, E, Y ]):-


	L = [ S, E, N, D, M, O, R, Y ],

	L ins 0..9,
	S #\= 0, M #\= 0,
	all_different(L),

	S * 1000 + E * 100 + N * 10 + D +

	M * 1000 + O * 100 + R * 10 + E #=
	
	M * 10000 + O * 1000 + N * 100 + E * 10 + Y,

	label(L).
