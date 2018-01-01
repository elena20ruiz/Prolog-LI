
all: squares tomografia

tomografia: tomografia.pl
	swipl -quiet -O -g main --stand_alone=true -o tomografia -c tomografia.pl

squares: squares.pl
	swipl -quiet -O -g main --stand_alone=true -o squares -c squares.pl

clean:
	rm -r tomografia squares
