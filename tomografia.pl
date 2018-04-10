% matrix which contains zeroes and ones gets "x-rayed" vertically and
% horizontally, giving the total number of ones in each row and column.
% The problem is to reconstruct the contents of the matrix from this
% information. Sample run:
%
%	?- p.
%	    0 0 7 1 6 3 4 5 2 7 0 0
%	 0
%	 0
%	 8      * * * * * * * *
%	 2      *             *
%	 6      *   * * * *   *
%	 4      *   *     *   *
%	 5      *   *   * *   *
%	 3      *   *         *
%	 7      *   * * * * * *
%	 0
%	 0
%

:- use_module(library(clpfd)).

ejemplo1( [0,0,8,2,6,4,5,3,7,0,0], [0,0,7,1,6,3,4,5,2,7,0,0] ).
ejemplo2( [10,4,8,5,6], [5,3,4,0,5,0,5,2,2,0,1,5,1] ).
ejemplo3( [11,5,4], [3,2,3,1,1,1,1,2,3,2,1] ).

% Lista vacia
listVars(0, []) :- !.
listVars(N, [_|L]) :- N1 is N-1, listVars(N1, L).

firstNElementsRest(L, N, E, R) :-
	append(E, R, L),
	length(E, N).

matrixByRows([], _, []) :- !.
matrixByRows(L, N, [E|L1]) :-
	firstNElementsRest(L, N, E, R),
	matrixByRows(R, N, L1).

declareConstraints([], []).
declareConstraints([L|Matrix], [S|Sums]) :-
	sum(L, #=, S), 	%Toda la fila/col ha de ser = a S
	declareConstraints(Matrix, Sums).	%recursividad

p:-
	ejemplo3(RowSums,ColSums),		% INPUT
	length(RowSums,NumRows),			% DEFINIR VARS
	length(ColSums,NumCols),
	NVars is NumRows*NumCols,			% NVars = size(mapXY)

	listVars(NVars,L),						% Crear lista vacia de tamaño NVars
	L ins 0..1,										% Dominio de la lista

	matrixByRows(L,NumCols,MatrixByRows),	%Recorrer matriz por columnas

	transpose(MatrixByRows, MatrixByCols),	%Nueva variable para comprovacion

	declareConstraints(MatrixByRows, RowSums),	% RESTRICCIONES RowSums[i] = MatrixByRows[i]
	declareConstraints(MatrixByCols, ColSums),  % RESTRICCIONES

	labeling([ff], L),					% Generación

	pretty_print(RowSums,ColSums,MatrixByRows).


pretty_print(_,ColSums,_):- write('     '), member(S,ColSums), writef('%2r ',[S]), fail.
pretty_print(RowSums,_,M):- nl,nth1(N,M,Row), nth1(N,RowSums,S), nl, writef('%3r   ',[S]), member(B,Row), wbit(B), fail.
pretty_print(_,_,_).
wbit(1):- write('*  '),!.
wbit(0):- write('   '),!.

main:- p,  nl , halt.
