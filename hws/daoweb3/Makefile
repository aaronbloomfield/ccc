doc:
	touch index.md
	cd ../..; make -s
	source-highlight -t 4 -s cpp -d *.sol
	source-highlight -d *.py
	-solc --abi IDAO.sol > IDAO.abi.txt
	../maketabs.py
