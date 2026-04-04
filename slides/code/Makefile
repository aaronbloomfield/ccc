ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	solc --abi IDebts.sol > IDebts.sol.abi
	/bin/mv -f IDebts.sol.abi IDebts.sol.abi.txt
	make source

source:
	custom-source-highlight.sh *.sol
