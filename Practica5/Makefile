
all: sudoku packing gangsters

sudoku: sudoku.pl
	swipl -quiet -O -g main --stand_alone=true -o sudoku -c sudoku.pl

packing: packing.pl
	swipl -quiet -O -g main --stand_alone=true -o packing  -c packing.pl

gangsters: gangsters.pl
	swipl -quiet -O -g main --stand_alone=true -o gangsters  -c gangsters.pl

banner: banner.pl
	swipl -quiet -O -g main --stand_alone=true -o banner  -c banner.pl
