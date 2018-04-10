%:-include(entradaPacking5).
:-include(library).
:-dynamic(varNumber/3).
symbolicOutput(0).

%% We are given a large rectangular piece of cloth from which we want
%% to cut a set of smaller rectangular pieces. The goal of this problem
%% is to decide how to cut those small pieces from the large cloth, i.e.
%% how to place them.
%%
%% Note 1: The smaller pieces cannot be rotated.
%%
%% Note 2: All dimensions are integer numbers and are given in
%% meters. Additionally, the larger piece of cloth is divided into
%% square cells of dimension 1m x 1m, and every small piece must
%% obtained exactly by choosing some of these cells

%%%%%% Some helpful definitions to make the code cleaner:
rect(R):-rect(R,_,_).
insideTable(X,Y):- width(W), height(H), between(1,H,Y), between(1,W,X).

%%%%%%  Variables
% starts-R-X-Y:   rect R has its left-bottom cell with coordinates (X, Y)
%  fills-R-I-J:   rect R fills cell with coordinates (I, J)

writeClauses:-
    fitsInTable,
    fills,
    eachCellAMO,
    eachRectALO,
    true.

ocupa(R, X, Y, I, J) :-
    rect(R, W, H),
    between(1, W, DX),
    between(1, H, DY),
    I is X + DX - 1,
    J is Y + DY - 1.

fitsInTable :-
    rect(R),
    insideTable(X, Y),
    ocupa(R, X, Y, I, J),
    \+ insideTable(I, J),
    writeClause([\+ starts-R-X-Y]),
    fail.
fitsInTable.

fills :-
    rect(R),
    insideTable(X, Y),
    ocupa(R, X, Y, I, J),
    writeClause([\+ starts-R-X-Y, fills-R-I-J]),
    fail.
fills :-
    rect(R),
    insideTable(X, Y),
    insideTable(I, J),
    \+ ocupa(R, X, Y, I, J),
    writeClause([\+ starts-R-X-Y, \+ fills-R-I-J]),
    fail.
fills.

eachCellAMO :-
    insideTable(I, J),
    findall(fills-R-I-J, rect(R), Lits),
    atMost(1, Lits),
    fail.
eachCellAMO.

eachRectALO :-
    rect(R),
    findall(starts-R-X-Y, insideTable(X, Y), Lits),
    atLeast(1, Lits),
    fail.
eachRectALO.

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% show the solution. Here M contains the literals that are true in the model:

displaySol(M):- nl, insideTable(I, J), member(fills-R-I-J, M), line(I), space(I), num(R), write(R), fail.
displaySol(_):- nl,nl.

line(I):- I == 1, nl,!.
line(_).
space(I):- I \== 1, write(' '),!.
space(_).
num(R):- R < 10, write(' '),!.
num(_).
