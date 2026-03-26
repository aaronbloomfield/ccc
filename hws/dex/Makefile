ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	source-highlight -t 4 -s cpp -d *.sol
	/bin/rm -f TokenDEX.sol.html TokenCC.sol.html ERC20.sol.html Context.sol.html
	source-highlight -d dex.py
	$(SED) s/"<html>"/"<html lang='en'>"/g *.sol.html dex.py.html
	/bin/rm -f *.todel
	../maketabs.py

sync:
	/bin/cp ../tokens/IERC165.sol ../tokens/IERC20.sol ../tokens/IERC20Metadata.sol .
