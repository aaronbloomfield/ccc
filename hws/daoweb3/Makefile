ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	source-highlight -t 4 -s cpp -d *.sol
	source-highlight -d *.py
	$(SED) s/"<html>"/"<html lang='en'>"/g *.sol.html *.py.html
	/bin/rm -f *.todel
	-solc --abi IDAO.sol > IDAO.abi.txt
	../maketabs.py

sync:
	/bin/cp -f ../tokens/IERC165.sol .
