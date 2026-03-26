ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	source-highlight -d -t 4 *.py
	source-highlight -d -s cpp -t 4 *.sol
	source-highlight -d arbitrage.py
	$(SED) s/"<html>"/"<html lang='en'>"/g *.sol.html *.py.html
	/bin/rm -f *.todel
	../maketabs.py
