ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	../maketabs.py
	solc --abi IPoll.sol| tail -1 | jq . - > IPoll.abi
	/bin/mv -f IPoll.abi IPoll.abi.txt
	solc --abi Poll.sol| tail -1 | jq . - > Poll.abi
	/bin/mv -f Poll.abi Poll.abi.txt
	solc --bin Poll.sol | tail -1 > Poll-normal.bin.txt
	solc --bin --optimize Poll.sol | tail -1 > Poll-optimized.bin.txt
	solc --asm Poll.sol > Poll.asm.txt
	make source

source:
	custom-source-highlight.sh *.py *.sol