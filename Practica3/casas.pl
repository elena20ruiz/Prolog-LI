% 2. Tenemos una fila de cinco casas, con cinco vecinos con casas de colores diferentes, y cinco
% profesiones, animales, bebidas y nacionalidades diferentes, y sabiendo que:
%
%     1 - El que vive en la casa roja es de Peru
%     2 - Al frances le gusta el perro
%     3 - El pintor es japones
%     4 - Al chino le gusta el ron
%     5 - El hungaro vive en la primera casa
%     6 - Al de la casa verde le gusta el coñac
%     7 - La casa verde esta a la izquierda de la blanca
%     8 - El escultor cría caracoles
%     9 - El de la casa amarilla es actor
%    10 - El de la tercera casa bebe cava
%    11 - El que vive al lado del actor tiene un caballo
%    12 - El hungaro vive al lado de la casa azul
%    13 - Al notario la gusta el whisky
%    14 - El que vive al lado del medico tiene un ardilla,

incre(N, N1) :-
  N1 is N + 1.

decre(N, N1) :-
  N1 is N - 1.

allado(N, N1) :-
  decre(N, N1).

allado(N, N1) :-
  incre(N, N1).


casas:-	Sol = [	[1,A1,B1,C1,D1,E1],       %1. Estructura de la solucion
            		[2,A2,B2,C2,D2,E2],       %   Lista de listas
            		[3,A3,B3,C3,D3,E3],       %
            		[4,A4,B4,C4,D4,E4],
            		[5,A5,B5,C5,D5,E5] ],
        % member( [ num, casa,         allado(I6,I7),profesion,animal,bebida,pais] , Sol),
        member([_,'roja',_,_,_,'Perú'],Sol),           %1
        member([_,_,_,'perro',_,'Francia'],Sol),       %2
        member([_,_,'pintor',_,_,'Japón'],Sol),        %3
        member([_,_,_,_,'ron','China'],Sol),           %4
        member([1,_,_,_,_,'Hungría'],Sol),             %5
        member([I1,'verde',_,_,'coñac',_],Sol),        %6
        incre(I1,I2),
        member([I2,'blanca',_,_,_,_],Sol),             %7
        member([_,_,'escultor','caracoles',_,_],Sol),  %8
        member([_,'amarilla','actor',_,_,_],Sol),     %9
        member([3,_,_,_,'cava',_],Sol),                %10
        allado(I3,I4),
        member([I4,_,_,'caballo',_,_],Sol),            %11
        allado(I5, I55),
        member( [ I55, _, _, _,_, "Hungría" ]  , Sol),
        member([I5,'azul',_,_,_,_],Sol),               %12
        member([_,_,'notario',_,'whisky',_],Sol),      %13
        member([I6,'medico',_,_,_,_],Sol),             %14
        allado(I6,I7),
        member([I7,_,'ardilla',_,_,_],Sol),            %15
	      write(Sol), nl.
