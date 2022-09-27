doc:
	touch index.md
	cd ../..; make -s
	source-highlight -d dappintro.py
	source-highlight -d -s cpp Poll.sol IPoll.sol
	../maketabs.py
	solc --abi IPoll.sol| tail -1 | jq . - > IPoll.abi
	solc --abi Poll.sol| tail -1 | jq . - > Poll.abi
	solc --bin Poll.sol | tail -1 > Poll-normal.bin.txt
	solc --bin --optimize Poll.sol | tail -1 > Poll-optimized.bin.txt
	solc --asm Poll.sol > Poll.asm
