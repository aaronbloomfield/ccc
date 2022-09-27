doc:
	touch index.md
	cd ../..; make -s
	source-highlight -t 4 *.py
	source-highlight -s cpp -t 4 *.sol
	source-highlight -d arbitrage.py
	../maketabs.py
