doc:
	touch index.md
	cd ../..; make -s
	source-highlight -t 4 -s cpp -d *.sol
	source-highlight -d daoweb3.py
	-solc --abi IDAO.sol > IDAO.abi
	../maketabs.py
