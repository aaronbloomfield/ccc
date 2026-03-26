ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	source-highlight -t 4 -s cpp -d *.sol
	$(SED) s/"<html>"/"<html lang='en'>"/g *.sol.html
	/bin/rm -f *.todel
	solc --abi IDebts.sol > IDebts.sol.abi
	/bin/mv -f IDebts.sol.abi IDebts.sol.abi.txt
