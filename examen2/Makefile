
all: stations important

stations: stations.pl
	swipl -quiet -O -g main --stand_alone=true -o stations -c stations.pl

important: important.pl
	swipl -quiet -O -g main --stand_alone=true -o important -c important.pl


