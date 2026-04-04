ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	/bin/rm -f TokenDEX.sol.html TokenCC.sol.html ERC20.sol.html Context.sol.html
	../maketabs.py
	make source

source:
	custom-source-highlight.sh *.py *.sol

sync:
	/bin/cp ../tokens/IERC165.sol ../tokens/IERC20.sol ../tokens/IERC20Metadata.sol .
