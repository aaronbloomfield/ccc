doc:
	touch index.md
	cd ../..; make -s
	source-highlight -t 4 -s cpp -d *.sol
	/bin/rm -f TokenDEX.sol.html TokenCC.sol.html ERC20.sol.html Context.sol.html
	source-highlight -d dex.py
	../maketabs.py
