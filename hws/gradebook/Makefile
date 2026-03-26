ifeq ($(shell uname),Darwin)
        SED=sed -i .todel
else
        SED=sed -i
endif

doc:
	touch index.md
	cd ../..; make -s
	source-highlight -s cpp -d *.sol
	/bin/rm -f CourseGradebook.sol.html
	source-highlight -d gradebook.py
	$(SED) s/"<html>"/"<html lang='en'>"/g *.sol.html gradebook.py.html
	/bin/rm -f *.todel
	../maketabs.py
