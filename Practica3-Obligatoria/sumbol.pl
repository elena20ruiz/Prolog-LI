% <programa> 		--> begin <intrucciones> end
% <instrucciones> 	--> <instruccion>
% <instrucciones> 	--> <instruccion>; <instrucciones>

% <instruccion>		--> <variable> = <variable> + <variable>
% <instruccion>		--> if <variable> = <variable> then <intrucciones>

% <variable>		--> x.
% <variable>		--> .
% <variable>		--> z.



lastEnd([end]).
lastEnd([_|Z]) :- lastEnd(Z).

variable(x).
variable(y).
variable(z).


instruccion([V0|L]):- variable(V0),
		      append([=],L1,L),
		      L1 = [V1|L2],
		      variable(V1),
		      append([+],L3,L2),
		      append([V2],L4,L3),
		      variable(V2),
		      (append([;],L5,L4) -> instruccion(L5);true).
		      

instruccion(["if"|L]) :- L = [V0|L1],
			variable(V0),
			append([=],L2,L1),
			L2 = [V1|L3],
			variable(V1),
			append([then], L4, L3),
			instruccions(L4). 

programa([begin|L]) :- 
			 lastEnd(L),
			 instruccion(L).
