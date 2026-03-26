ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	source-highlight -d dappintro.py
	source-highlight -d -s cpp Poll.sol IPoll.sol
	$(SED) s/"<html>"/"<html lang='en'>"/g *.sol.html dappintro.py.html
	/bin/rm -f *.todel
	../maketabs.py
	solc --abi IPoll.sol| tail -1 | jq . - > IPoll.abi
	/bin/mv -f IPoll.abi IPoll.abi.txt
	solc --abi Poll.sol| tail -1 | jq . - > Poll.abi
	/bin/mv -f Poll.abi Poll.abi.txt
	solc --bin Poll.sol | tail -1 > Poll-normal.bin.txt
	solc --bin --optimize Poll.sol | tail -1 > Poll-optimized.bin.txt
	solc --asm Poll.sol > Poll.asm.txt
