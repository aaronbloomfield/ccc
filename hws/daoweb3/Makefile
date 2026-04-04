ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	-solc --abi IDAO.sol > IDAO.abi.txt
	../maketabs.py
	make source

source:
	custom-source-highlight.sh *.py *.sol

sync:
	/bin/cp -f ../tokens/IERC165.sol .
