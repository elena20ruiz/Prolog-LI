
% 3. Haz un programa prolog que escriba la manera de colocar sobre un tablero de
%    ajedrez ocho reinas sin que éstas se ataquen entre sí.
%    Por ejemplo, ésta sería una solucion:

queens(N,Sol) :-
  length(Sol,N),        %Se definen las dimensiones
  Sol ins 1..N,         %Se define el contenido
  reinas_a_salvo(Sol).  %Se genera la solucion

reinas_a_salvo([]).
reinas_a_salvo([S|Ts]) :-
    mirar_anteriores(Ts,S,1),     %Para cada tupla se mira lo que hay anterior
    reinas_a_salvo(Ts).


mirar_anteriores([],_,_).
mirar_anteriores([S|Ts],R, D):-
  R \= S,
  abs(R - S) \= D,
  D1 = D + 1,
  mirar_anteriores(Ts,R,D1).
