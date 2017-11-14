%%FUNCIONES DE EJEMPLO NECESARIOS:
%===============================================================================
%PERMUTACIONES CON RESTO
pert_con_resto(X,L,Resto):-
	concat(L1,[X|L2], L),
	concat(L1, L2, Resto).

% longitud de una lista
long([],0).
long([_|L],M):- long(L,N), M is N+1.


factores_primos(1,[]) :- !.
factores_primos(N,[F|L]):- nat(F), F>1, 0 is N mod F,
N1 is N // F, factores_primos(N1,L),!.

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

subcjto([],[]). %subcjto(L,S) es: "S es un subconjunto de L".
subcjto([X|C],[X|S]):-subcjto(C,S).
subcjto([_|C],S):-subcjto(C,S).
%===============================================================================


%2. prod(L,P).
prod([X|L],P):- prod(L,P1), P is P1*X.
prod([],1).

%3. pescalar(L1,L2,P)
pescalar([],[],0).
pescalar([X1|L1],[X2|L2],P):-
				pescalar(L1,L2,P1),
				P is P1+X1*X2.

%4.-----------------------------------------------------
%[AUX] pert:
pert(X, [X|_]).
pert(X, [_|L]) :- pert(X,L).

%4.1 union
union([],[],[]).
union(L,[],L).
union([],L,L).
union(L1, [X|L2], L):-
		pert(X,L1),
		union(L1,L2,L).
union(L1, [X|L2], [X|L]):-
	union(L1,L2,L).

%4.2 interseccion
interseccion([],[],[]).
interseccion([],_,[]).
interseccion(_,[],[]).
interseccion([X|L1],L2,[X|L]):-
	pert(X,L2),
	interseccion(L1,L2,L).
interseccion([_|L1],L2,L):- interseccion(L1,L2,L).

%5.------------------------------------------------------------------

%[PRACTICA]Implementación del concat
concat([],[],[]).
concat([],L2,L2).
concat(L1,[],L1).
%Va possat el primer de L1 davant de la llista concatenada.
concat([X|L1],L2,[X|C]):- concat(L1,L2,C).

%5.1 ultim(L,U).
ultim(L,U) :-concat(_,[U],L).

%5.2 reverse(L,L2).
reverse([],[]).
reverse([X],[X]).
reverse(L1,[U|L3]):-
		reverse(L2,L3),
		concat(L2,[U],L1).

%6. -------------------------------------------------------------------
%fib(N,F).
fib(1,1).
fib(2,1).
fib(N,F):-
	  N > 2,
		N1 is N -1,
		N2 is N -2,
		fib(N1,F1),
		fib(N2,F2),
		F is F1 + F2.

%7. ------------------------------------------------------------------

%dados(P,N,L).
%La lista L expresa una manera de sumar P puntos lanzando N dados
%Ej: P is 5, X is 2 -> Resp: [1,4], [2,3], [3,2], [4,1].

dados(0,0,[]).
dados(P,N,[X|L]):-
	  N > 0,
		pert(X,[1,2,3,4,5,6]),
		N1 is N - 1,
		P1 is P - X,
		dados(P1,N1,L).

%8. ------------------------------------------------------------------

n_elementos([],0).
n_elementos([_|L],N):-
	n_elementos(L,N1),
	N is N1 + 1.

suma_demas(L):-
	n_elementos(L,N),
	pert(N,L),!.

%9. -------------------------------------------------------------------

% Escribe un predicado suma ants(L) que, dada una lista de enteros
% L, se satisface si existe algun elemento en ´ L que es igual a la suma de los
% elementos anteriores a el en ´ L, y falla en caso contrario.


%suma(L,S) es cert si S es la suma dels elements de la llista L
%		 PRE: L es una llista d'enters.
%[FUNCION AUX]
suma([],0).
suma([X|L], S) :-
		  suma(L,S1),
  S is X + S1.

suma_ants([X|L]):- suma(L,N), X = N, !.
suma_ants([_|L]):- suma_ants(L).

%10. --------------------------------------------------------------------

% Escribe un predicado card(L) que, dada una lista de enteros L,
% escriba la lista que, para cada elemento de L, dice cuántas veces aparece este
% elemento en L. Por ejemplo, card( [1,2,1,5,1,3,3,7] ) escribirá
% [[1,3],[2,1],[5,1],[3,2],[7,1]].

car( [X|L] , [ [X,N1] |Cr] ):-car(L,C),pert_con_resto([X,N],C,Cr),!,N1 is N+1.
car( [X|L] , [ [X,1]   |C] ):-car(L,C).

car(L):-car(L,C),write(C).

%11. --------------------------------------------------------------------
% está ordenada([3,45,67,83]). dice yes
% Con ?-está ordenada([3,67,45]). dice no

anteriorMayor([],_).
anteriorMayor([X|List],Y):-
	X >= Y,
	anteriorMayor(List,X), !.

anteriorMayor([X|_],Y):-
	X < Y,
	write("no"),
	fail.

esta_ordenada([]).
esta_ordenada([_]).
esta_ordenada([X|L]):-
	anteriorMayor(L,X),
	write("yes").

%12. --------------------------------------------------------------------
ordenacion(L1,L2) :- permutacion(L1,L2), esta_ordenada(L2).

%13. --------------------------------------------------------------------

%14. --------------------------------------------------------------------

%15. --------------------------------------------------------------------

%16. --------------------------------------------------------------------

%17. --------------------------------------------------------------------

%18. --------------------------------------------------------------------

%19. --------------------------------------------------------------------

%20. --------------------------------------------------------------------

%21. --------------------------------------------------------------------
