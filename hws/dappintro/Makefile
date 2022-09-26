doc:
	cd ../..; make
	source-highlight -d dappintro.py
	source-highlight -d -s cpp Poll.sol IPoll.sol
	../maketabs.py
	solc --abi Poll.sol| tail -1 | jq . - > Poll.abi
	solc --bin Poll.sol | tail -1 > Poll-normal.bin
	solc --bin --optimize Poll.sol | tail -1 > Poll-optimized.bin
	solc --asm Poll.sol > Poll.asm
