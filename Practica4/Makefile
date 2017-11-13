
all: sudoku misat

misat: mySAT.cpp
		g++ -O3 -Wall mySAT.cpp -o misat

sudoku: sudoku.pl
	swipl -quiet -O -g main --stand_alone=true -o sudoku -c sudoku.pl

nurses: nurses.pl
	swipl -quiet -O -g main --stand_alone=true -o nurses -c nurses.pl

packing: packing.pl
	swipl -quiet -O -g main --stand_alone=true -o packing  -c packing.pl

gangsters: gangsters.pl
	swipl -quiet -O -g main --stand_alone=true -o gangsters  -c gangsters.pl
